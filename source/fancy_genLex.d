module fancy_genLex;
import std.array;
import std.conv;
import std.algorithm:filter,any,map,reduce,all,sort,min,commonPrefix;
import std.typecons:Tuple;
import std.traits:Unqual;
import fancy_util;
import fancy_ast;
import fancy_grammar;

string genFixedToken(string[] strings) pure {
	string result;
	const (char)[] next;
	char[] currentPrefix;

	uint longestSoFar;
	bool charsEqualToNext;

	uint chainLength;
	//Tuple!(uint, "strNum", uint, "chainBreak") chainBreaks;
	uint[uint] chainBreaks;

	foreach(uint i,str;strings) {
		if (i<strings.length-1) {
			next = strings[i+1];
		} else {
			next = null;
		}

		if (str.length>longestSoFar) {
			longestSoFar = cast(uint) str.length;
		}
		
		if (next && str[0] == next[0]){
			++chainLength;
			continue;
		}

		
		foreach(uint j,chr;str) {
			if (j == 0) {
				result ~= "\n";
			}

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
							} else {
								//Do Nothing here
							}
						} else {
							debug {
								import std.stdio;
								writeln(chainBreaks);
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

string genTokenSize(string[] strings) {
	string result = cast(string) "uint TokenSize(TokenType t) {\n".indentBy(1);
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
		if (value < currentMaxVal) {
			currentMaxVal = value;
			maxKey = key;
		}
	}




	return result;
}

string genTokenTypeEnum(const Group[] allGroups) {
	import std.conv:to;
	//	assert(isSorted(strings));
	
	string result = "enum TokenType {\n\tTT_0, // Invalid Token\n";
	string[] strings = sort(getStrings(allGroups)).release;

	foreach(rangeG;allGroups.filter!(g => RangeGroup(g))) {
		result ~= "\n\t" ~ "TT_" ~ rangeG.name.identifier ~ ",";
	}

	result ~= "\n";

	foreach(i,str;strings) {
		result ~= "\n\t" ~ "TT_" ~ to!string(i+1) ~ ", // " ~ str;
	}

	return result ~ "\n}\n";
}

string genLex(const (Group)[] allGroups) {
	string result;

	foreach(rangeG;allGroups.filter!(g => RangeGroup(g))) {

		result ~= "\n\tbool is" ~ rangeG.name.identifier ~ "(char c) {\n" ~ 
			"return (".indentBy(2);
		foreach(CharRange range;(cast(RangeElement)rangeG.elements[0]).ranges) {
			if (range.rangeEnd) {
				result ~= "(c >= '" ~ range.rangeBegin ~ "' && c <= '" ~ range.rangeEnd ~ "') || ";
			} else {
				result ~= "(c == '" ~ range.rangeBegin ~ "') || "; 
			}
		}

		result = result[0 .. $-4] ~ ");\n\t}\n";
	}

	//	foreach(delimG;allGroups.filter!(g => DelimitedCharGroup(g))) {
//		import std.stdio;
//		writeln(delimG.name.identifier);
//	}

	
	result ~= genFixedToken(sort(getStrings(allGroups)).release);
	return result;
}
