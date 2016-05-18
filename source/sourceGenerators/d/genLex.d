module sourceGenerators.d.genLex;
import std.array;
import std.algorithm;
import std.range;
import std.typecons:Tuple;
import std.traits:Unqual;
import fancy_util;
import fancy_ast;
import fancy_analyzer;
import fancy_grammar_patterns;
alias Group = fancy_ast.Group;



static immutable string lexer_blrplate_head = `
import std.exception;
Token[] lex(in string source) pure {
	uint col;
	uint line;
	uint pos;
	Token[] result;

	char peek(int offset) {
		if (pos + offset > source.length - 1) return '\0';
		enforce(pos + offset <= source.length && pos + offset >= 0);
		return source[pos + offset];
	}

	void putToken(TokenType ttype, char[] data, uint offset=0) {

		uint length = offset ? offset : cast(uint) data.length;

		
		result ~= Token(ttype, pos, line, col, length, data);
		
		col += length;
		pos += length;
	}
`;

string genLex(const GrammerAnalyzer.AnalyzedGrammar ag) {
	string result = lexer_blrplate_head;
	
	foreach(rangeG;ag.allGroups.map!(g => RangeGroup(g)).filter!(rg => rg !is null)) {
		
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
			~ "\n\n\t\twhile(is" ~ rangeG.name.identifier ~ "(__c = peek(cast(uint) __a.length))) {"
				~ "\n\t\t\t__a ~= __c;\n\t\t}\n\n\t\tputToken(TokenType.TT_" ~ rangeG.name.identifier
				~ ", __a, cast(uint) __a.length);\n\n\t\treturn;\t\n}\n";
		
	}
	
	foreach(delimG;ag.allGroups.map!(g => DelimitedCharGroup(g)).filter!(dcg => dcg !is null)) {
		
		import std.conv:to;
		result ~= "\n\tbool isBegin" ~ delimG.name.identifier ~ "() {\n" 
			~ "\n\t\tif(";
		foreach(i,c;delimG.begin.string_) {
			result ~= "\n\t\t\tpeek(" ~ i.to!string ~ ") != '" ~ c ~ "' ||";
		}
		result = result[0 .. $-3] ~ "\n\t\t) {\n\t\t\treturn false;"
			~ "\n\t\t} else {\n\t\t\treturn true;\n\t\t}\n\t}\n";
		
	}
	//TODO FIX genLexFixedToekn! 
	string genLexFixedToken(SortedRange!(string[], "a < b") sortedStrings) pure {
		import std.conv:to;
		const string[] strings = sortedStrings.release;
		
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
							} else {
								//debug {import std.stdio;if (!__ctfe) {writeln(strings[i]);} }
								result ~= "default :\n".indentBy(j+3) ~ "return TokenType.TT_0;\n".indentBy(j+3);
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
		
		return "\n\tTokenType lexFixedToken(char[" ~ to!string(longestSoFar) ~ "] _chrs) {\n\t\tswitch(_chrs[0]) {\n\t\tdefault :\n\t\t\treturn TokenType.TT_0;\n" ~ result ~ "\n\t\t}\n\t}\n";
	}


	result ~= genLexFixedToken(unQual(ag.strings)) ~ "\n\treturn result;\n}";
	return result;
}

