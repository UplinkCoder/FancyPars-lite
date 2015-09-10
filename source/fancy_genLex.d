module fancy_genLex;
import std.array;
import std.algorithm:filter,any,map,reduce,all,sort,min,commonPrefix,SortedRange;
import std.typecons:Tuple;
import std.traits:Unqual;
import fancy_util;
import fancy_ast;
import fancy_grammar;

string genFixedToken(SortedRange!(string[], "a < b") sortedStrings) pure {
	import std.conv:to;
	string[] strings = sortedStrings.release;

	string result;
	const (char)[] next;
	char[] currentPrefix;

	uint longestSoFar;
	bool charsEqualToNext;

	uint chainLength;
	//Tuple!(uint, "strNum", uint, "chainBreak") chainBreaks;
	uint[uint] chainBreaks;

	foreach(uint i,str;strings) {
		result ~= "\n";

		if (i<strings.length-1) {
			next = strings[i+1];
		} else {
			next = null;
		}

		if (str.length>longestSoFar) {
			longestSoFar = cast(uint) str.length;
		}
		
		if (next && str[0] == next[0]) {
			++chainLength;
			continue;
		}
		
		foreach(uint j,chr;str) {
			result ~= "case '".indentBy(j+2) ~ chr ~ "' :\n";

			if (str.length>1 && j<str.length-1) {
				result ~= "switch (_chrs[".indentBy(j+3) ~ to!string(j+1) ~ "]) {\n";
				if (chainLength) {
					foreach_reverse(k;0 .. chainLength) {
						if (strings[i-k-1].length>j && strings[i-k-1][0 .. j+1] == strings[i][0 .. j+1]) {
							if (strings[i-k-1].length == j+1 && strings[i-k-1][j] == strings[i][j]) { 
								result ~= "default :\n".indentBy(j+3) ~ "return TokenType.TT_".indentBy(j+3) ~ to!string(i-k) ~ ";\n";
							} else if (strings[i-k-1].length == j+3 && strings[i-k-1][j] != strings[i][j]) {
								result ~= "case '".indentBy(j+3) ~ strings[i-k-1][j+1] ~ "' :\n"
									~ "return TokenType.TT_".indentBy(j+4) ~ to!string(i-k) ~ ";\n";
							}
						}
					}
				} else {
					result ~= "default : return TokenType.TT_0;\n".indentBy(j+3);
				}
				
			} 
		}
		chainLength = 0;

		
		result ~= "return TokenType.TT_".indentBy(cast(uint)str.length+2) ~ to!string(i+1) 
			~ ";\n";

		foreach_reverse (uint j; 1 .. cast(uint) str.length) {
			result ~= "}\n".indentBy(j+2);
		}

	}

	return "\n\tTokenType fixedToken(char[" ~ to!string(longestSoFar) ~ "] _chrs) {\n\t\tswitch(_chrs[0]) {\n\t\tdefault :\n\t\t\treturn TokenType.TT_0;\n" ~ result ~ "\n\t\t}\t\n}";
}

string genTokenSize(SortedRange!(string[], "a < b") strings) {
	import std.conv:to;

	string result = cast(string) ("uint TokenSize(TokenType t) {\n" ~
		"switch(t) {\n".indentBy(1));

	uint currentMaxVal;
	uint maxKey;
	uint[uint] counts;

	foreach(s;strings) {
		if (s.length in counts) {
			counts[s.length]++;
		} else {
			counts[s.length] = 1;
		}
	}
	foreach(key,value;counts) {
		if (value > currentMaxVal) {
			currentMaxVal = value;
			maxKey = key;
		}
	}

	{
		uint i;
		foreach(s;strings.filter!((s) {i++;return s.length != maxKey;})) {
			result  ~= "case TokenType.TT_".indentBy(2) 
				~ to!string(i) 
				~ " : return " ~ s.length.to!string ~ ";\n"; 
		}
	}

	result ~= "default : return ".indentBy(2)
		~ maxKey.to!string ~ ";\n"
		~ "}\n".indentBy(1) ~ "}\n";


	return result;
}

string genTokenTypeEnum(const Group[] allGroups) {
	import std.conv:to;

	string result = "enum TokenType {\n\tTT_0, // Invalid Token\n";
	auto sortedStrings = getStrings(allGroups);

	foreach(rangeG;allGroups.filter!(g => LexerGroup(g))) {
		result ~= "\n\t" ~ "TT_" ~ rangeG.name.identifier ~ ",";
	}

	result ~= "\n";
	{
		uint i;
		foreach(str;sortedStrings) {
			result ~= "\n\t" ~ "TT_" ~ to!string(++i) ~ ", // " ~ str;
		}
	}

	return result ~ "\n}\n" ~ genTokenSize(sortedStrings);
}

string genLex(const (Group)[] allGroups) {
	string result;

	foreach(rangeG;allGroups.map!(g => RangeGroup(g)).filter!(rg => rg !is null)) {

		result ~= "\n\tbool is" ~ rangeG.name.identifier ~ "(char c) pure {\n" ~ 
			"return (".indentBy(2);
		foreach(CharRange range;rangeG.re.ranges) {
			if (range.rangeEnd) {
				result ~= "(c >= '" ~ range.rangeBegin ~ "' && c <= '" ~ range.rangeEnd ~ "') || ";
			} else {
				result ~= "(c == '" ~ range.rangeBegin ~ "') || "; 
			}
		}

		result = result[0 .. $-4] ~ ");\n\t}\n";

		result ~= "\n\tvoid lex" ~ rangeG.name.identifier ~ "() {\n\t\tchar[] __a;\n\t\tchar __c;"
			~ "\n\n\t\twhile(is" ~ rangeG.name.identifier ~ "(__c = peek(__a.length))) {"
			~ "\n\t\t\t__a ~= __c;\n\t\t}\n\n\t\tputToken(TokenType.TT_" ~ rangeG.name.identifier
			~ ", __a, cast(uint) __a.length);\n\n\t\treturn;\t\n}\n";

	}

	foreach(delimG;allGroups.map!(g => DelimitedCharGroup(g)).filter!(dcg => dcg !is null)) {

		import std.conv:to;
			result ~= "\n\tbool isBegin" ~ delimG.name.identifier ~ "() {\n" 
				~ "\n\t\tif(";
		foreach(i,c;delimG.begin.string_) {
			result ~= "\n\t\t\tpeek(" ~ i.to!string ~ ") != '" ~ c ~ "' ||";
		}
		result = result[0 .. $-3] ~ "\n\t\t) {\n\t\t\treturn false;"
			~ "\n\t\t} else {\n\t\t\treturn true;\n\t\t}\n\t}\n";

	}

	
	result ~= genFixedToken(getStrings(allGroups));
	return result;
}
