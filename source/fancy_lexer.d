import fancy_token;
import std.conv;
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

	bool isWhiteSpace(char c) pure {
		return (c == ' ' || c == '\t' || c == '\n' || c == '\r');
	}

	bool isIdentifier(char c) {
		return ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '_' && c <= '_'));
	}

	bool isNumber(char c) {
		return ((c >= '0' && c <= '9'));
	}

	

	void putToken(TokenType ttype, char[] data, uint offset=0) {

		uint length = offset ? offset : cast(uint) data.length;

		
		result ~= Token(ttype, pos, line, col, length, data);
		
		col += length;
		pos += length;
	}

	TokenType fixedToken(char[4] _chrs) {
		switch(_chrs[0]) {
			default :
				return TokenType.TT_0;
				
			case ' ' :
				return TokenType.TT_1;
				
			case '!' :
				return TokenType.TT_2;
				
			case '"' :
				return TokenType.TT_3;
				
			case '(' :
				return TokenType.TT_4;
				
			case ')' :
				return TokenType.TT_5;
				
			case ',' :
				return TokenType.TT_6;
				
			case '-' :
				return TokenType.TT_7;
				
			case '/' :
				return TokenType.TT_8;
				
			case ':' :
				return TokenType.TT_9;
				
			case '?' :
				switch (_chrs[1]) {
					default :
						return TokenType.TT_10;
					case 'l' :
						switch (_chrs[2]) {
							default : return TokenType.TT_0;
							case 'b' :
								return TokenType.TT_11;
						}
				}
				
			case '@' :
				return TokenType.TT_12;
				
			case '[' :
				switch (_chrs[1]) {
					default :
						return TokenType.TT_13;
					case ']' :
						return TokenType.TT_14;
				}
				
			case ']' :
				return TokenType.TT_15;
				
			case 'b' :
				switch (_chrs[1]) {
					default : return TokenType.TT_0;
					case 'o' :
						switch (_chrs[2]) {
							default : return TokenType.TT_0;
							case 'o' :
								switch (_chrs[3]) {
									default : return TokenType.TT_0;
									case 'l' :
										return TokenType.TT_16;
								}
						}
				}
				
			case 'c' :
				switch (_chrs[1]) {
					default : return TokenType.TT_0;
					case 'h' :
						switch (_chrs[2]) {
							default : return TokenType.TT_0;
							case 'a' :
								switch (_chrs[3]) {
									default : return TokenType.TT_0;
									case 'r' :
										return TokenType.TT_17;
								}
						}
				}
				
			case '{' :
				return TokenType.TT_18;
				
			case '}' :
				return TokenType.TT_19;
				
		}
	}

	void lexIdentifier() {
		char[] identifer;

		char __p = peek(0);

		while(isIdentifier(__p)) {
			identifer ~= __p;
			__p = peek(cast(uint) identifer.length);
		}

		putToken(TokenType.TT_Identifier, identifer, cast(uint) identifer.length); 

		return;
	}

	void lexStringElement() {
		char[] string_;

		int offset = 1;
		enforce(peek(0) == '"');
		
		while(peek(offset) != '"') {
			if (peek(offset) == '\\') {
				offset++;
			}
			string_ ~= peek(offset++);
		}

		enforce(peek(offset) == '"');

		putToken(TokenType.TT_StringElement, string_, offset + 1);
		return;
	}

	void lexCharRange() {
		char rangeBegin;
		char RangeEnd;

		rangeBegin = peek(0);
		if(peek(1) == '-') {
			RangeEnd = peek(2);
		} else {
			RangeEnd = peek(0);
		}

		putToken(TokenType.TT_CharRange, [rangeBegin, RangeEnd], (peek(1) == '-' ? 3 : 1));
		return;
	}

	
	uint TokenSize(TokenType t) {
		switch(t) {
			case TokenType.TT_11 : return 3;
			case TokenType.TT_16 : return 4;
			case TokenType.TT_17 : return 4;
			case TokenType.TT_14 : return 2;
			default : return 1;
		}
	}
	
	while(pos<source.length) {
		char p = source[pos];
		if(isWhiteSpace(p)) {
			if (p == '\n') {
				pos++;col=0;line++;
			} else {
				pos++;col++;
			}
		} else if (auto t = fixedToken([p, peek(1), peek(2), peek(3)])) {
			switch(t) {
				case TokenType.TT_3 : lexStringElement();
					break;
				case  TokenType.TT_13 :
					putToken(t, null, TokenSize(t));
					while (peek(0) != ']') { 
						lexCharRange();
					}
					putToken(TokenType.TT_15, null, 1);
					break;
				default : putToken(t, null, TokenSize(t));
			}

		} else if (isIdentifier(p)) {
			lexIdentifier();
		} else {
			enforce(0, "Cannot advance lexer : ASCII Code [" ~ to!string(to!int(p)) ~ "] at line: " ~ to!string(line+1));
		}
	}

	return result;
}
