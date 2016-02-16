module sourceGenerators.d.genToken;
import std.range;
import fancy_analyzer;
import fancy_util;
import fancy_grammar_patterns;

immutable static string token_blrplate = `
struct Token {
	TokenType type;
	
	uint pos;
	uint line;
	uint col;
	uint length;
	
	char[] data;
}
`;

extern string genToken(const GrammerAnalyzer.AnalyzedGrammar ag) {
	string genTokenSize(SortedRange!(string[], "a < b") strings) pure {
		import std.conv:to;
		
		string result = cast(string) ("uint TokenSize(TokenType t) pure {\n" ~
			"switch(t) {\n".indentBy(1));
		
		uint currentMaxVal;
		uint maxKey;
		uint[uint] counts;
		
		foreach(s;strings) {
			if (cast(uint)s.length in counts) {
				counts[cast(uint)s.length]++;
			} else {
				counts[cast(uint)s.length] = 1;
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
		foreach(s;strings) {
				/* .filter!((s) {i++;return s.length != maxKey;})	
				 * does not work with gdc because filter is infered impure
				 */
				i++;
				if (s.length != maxKey) {
					result  ~= "case TokenType.TT_".indentBy(2) 
						~ to!string(i) 
							~ " : return " ~ s.length.to!string ~ ";\n";
				}
			}
		}
		
		result ~= "default : return ".indentBy(2)
			~ maxKey.to!string ~ ";\n"
				~ "}\n".indentBy(1) ~ "}\n";
		
		
		return result;
	}
	
	string genTokenTypeEnum(const GrammerAnalyzer.AnalyzedGrammar ag) pure {
		import std.conv:to;
		
		string result = "enum TokenType {\n\tTT_0, // Invalid Token\n";
		
		foreach(rangeG;ag.allGroups.filter!(g => LexerGroup(g))) {
			result ~= "\n\t" ~ "TT_" ~ rangeG.name.identifier ~ ",";
		}
		
		result ~= "\n";
		{
			uint i;
			foreach(str;unQual(ag.strings)) {
				result ~= "\n\t" ~ "TT_" ~ to!string(++i) ~ ", // " ~ str;
			}
		}
		
		return result ~ "\n}\n";
	}

	return token_blrplate ~ genTokenTypeEnum(ag) ~ genTokenSize(unQual(ag.strings));
}