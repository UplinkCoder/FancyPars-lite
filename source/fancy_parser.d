import fancy_token;
import fancy_ast;
import std.conv;
Group parse(in Token[] tokens) pure { 
	struct Parser {
	pure :
		const(Token[]) tokens;
		uint pos;
		Token lastMatched;
		
		const(Token) peekToken(int offset) {
			assert(pos + offset <= tokens.length && pos + offset >= 0);
			return tokens[pos + offset];
		}
		
		
		bool peekMatch(TokenType[] arr) {
			foreach (uint i,e;arr) {
				if(peekToken(i).type != e) {
					return false;
				}
			}
			return true;
		}
		
		bool opt_match(TokenType t) {
			lastMatched = cast(Token) peekToken(0);
			
			if (lastMatched.type == t) {
				pos++;
				return true;
			} else {
				lastMatched = Token.init;
				return false;
			}
		}
		
		Token match(TokenType t) {
			import std.conv;
			import std.exception:enforce;

			if (!__ctfe) {
				enforce(opt_match(t), "Expected : " ~ to!string(t) ~ " Got : " ~ to!string(peekToken(0)) );
			} else {
				assert(opt_match(t),to!string(t));
			}
			return lastMatched;
		}


		bool isIdentifier() {
			return peekMatch([TokenType.TT_Identifier]);
		}

		bool isGroup() {
			return peekMatch([TokenType.TT_Identifier, TokenType.TT_18])
			|| peekMatch([TokenType.TT_Identifier, TokenType.TT_12]);
		}
		
		bool isQueryElement() {
			return peekMatch([TokenType.TT_10, TokenType.TT_16]);
		}

		bool isNamedElement() {
			return peekMatch([TokenType.TT_Identifier, TokenType.TT_Identifier])
				|| peekMatch([TokenType.TT_Identifier, TokenType.TT_14])
				|| isAnonymousGroupElement();
		}

		bool isAnonymousGroupElement() {
			return peekMatch([TokenType.TT_18]);
		}

		bool isNamedChar() {
			return peekMatch([TokenType.TT_17]);
		}

		bool isStringElement() {
			return peekMatch([TokenType.TT_StringElement]);
		}

		bool isCharRange() {
			return peekMatch([TokenType.TT_CharRange]);
		}

		bool isRangeElement() {
			return peekMatch([TokenType.TT_13]);
		}

		bool isLookbehindElement() {
			return peekMatch([TokenType.TT_11]);
		}

		bool isNotElement() {
			return peekMatch([TokenType.TT_2]);
		}

		bool isParenElement() {
			return peekMatch([TokenType.TT_4]);
		}

		bool isFlagElement() {
			return peekMatch([TokenType.TT_16]);
		}

		bool isOptionalElement() {
			return peekMatch([TokenType.TT_10]);
		}

		bool isASTNode() {
			return isGroup()
				|| isPatternElement();
		}

		bool isPatternElement() {
			return isQueryElement()
				|| isNamedElement()
				|| isOptionalElement()
				|| isParenElement()
				|| isFlagElement()
				|| isLexerElement();
		}

		bool isLexerElement() {
			return isLookbehindElement()
				|| isNamedChar()
					|| isStringElement()
					|| isCharRange()
					|| isRangeElement()
					|| isNotElement();
		}

		ASTNode parseASTNode() {
			if (isGroup()) {
				return parseGroup();
			}  else 
				assert(0, "No Matching ASTNode" );
		}


		Group parseGroup() {
			Identifier name;
			Identifier[] annotations;
			PatternElement[] elements;
			Group[] groups;
			
			name = parseIdentifier();
			if (opt_match(TokenType.TT_12)) {
				
				annotations ~= parseIdentifier();
				while(opt_match(TokenType.TT_12)) {
					annotations ~= parseIdentifier();
				}
			}
			match(TokenType.TT_18);
			if (isPatternElement()) {
				
				elements ~= parsePatternElement();
				while(opt_match(TokenType.TT_6)) {
					elements ~= parsePatternElement();
				}
			} else if (isGroup()) {
				while(isGroup()) {
					groups ~= parseGroup();
				}
			} 
			match(TokenType.TT_19);
			
			return new Group(name, annotations, elements, groups);
		}

//		Group parseGroup() { 
//			Identifier name;
//			Identifier annotation;
//
//			name = parseIdentifier();
//
//			if (opt_match(TokenType.TT_12)) {
//				annotation = parseIdentifier();
//
//			}
//
//			match(TokenType.TT_18);
//			if (isGroup()) {
//				Group[] groups;
//
//				while(!opt_match(TokenType.TT_19)) {
//					groups ~= parseGroup();
//				}
//
//
//				return new Group(name, annotation, groups);
//			} else if (isPatternElement()) {
//
//				PatternElement[] elements;
//				elements ~= parsePatternElement();
//
//				while(opt_match(TokenType.TT_6)) {
//					elements ~= parsePatternElement();
//				}
//
//				match(TokenType.TT_19);
//				return new Group(name, annotation, elements);
//
//			} else
//				assert(0, "No Match!" ~ to!string(peekToken(-1)) ~ "  " ~ to!string(peekToken(0))  ~ "  " ~ to!string(peekToken(1)) );
//			
//			
//		}

		Identifier parseIdentifier() { 
			return new Identifier(cast(string) match(TokenType.TT_Identifier).data);
		}

		PatternElement parsePatternElement(bool inAlternative = false) {
			PatternElement p;

			if (isQueryElement()) {
				p = parseQueryElement();
			}  else if (isNamedElement()) {
				p = parseNamedElement();
			}  else if (isOptionalElement()) {
				p = parseOptionalElement();
			}  else if (isParenElement()) {
				p = parseParenElement();
			}  else if (isFlagElement()) {
				p = parseFlagElement();
			}  else if (isLexerElement()) {
				p = parseLexerElement();
			//}  else if (isAnonymousGroupElement) {
			//	p = parseAnonymousGroupElement;
			} else
				assert(0, "No Matching PatternElement" ~to!string (lastMatched.line) );

			if (peekMatch([TokenType.TT_8]) && !inAlternative) {
				return parseAlternativeElement(p);
			} else {
				return p;
			}
		}

		
		QueryElement parseQueryElement() { 
			Identifier flag_name;
			PatternElement elem;

			match(TokenType.TT_10);
			match(TokenType.TT_16);
			flag_name = parseIdentifier();

			match(TokenType.TT_9);
			elem = parsePatternElement();

			return new QueryElement(flag_name, elem);
		}

		NamedElement parseNamedElement() { 
			Identifier type;
			bool isArray;
			Identifier name;
			AnonymousGroupElement age;
			StringElement lst_sep;

			if (isIdentifier()) {
				type = parseIdentifier();
			} else if (isAnonymousGroupElement()) {
				age = parseAnonymousGroupElement();
			}
			debug {import std.stdio;if(!__ctfe && age !is null)writeln(age.elements);}
			if (opt_match(TokenType.TT_14)) {
				isArray = true;
			}

			name = parseIdentifier();

			if (isArray == true) {
				if (opt_match(TokenType.TT_9)) {
					lst_sep = parseStringElement();

				}

			}

			return new NamedElement(type, age, isArray, name, lst_sep);
		}

		ConditionalElement parseOptionalElement() { 
			LexerElement[] ce;
			PatternElement elem;

			match(TokenType.TT_10);
			ce ~= parseLexerElement();

			while(opt_match(TokenType.TT_6)) {
				ce ~= parseLexerElement();
			}

			if (opt_match(TokenType.TT_9)) {
				elem = parsePatternElement();
			}

			return new ConditionalElement(ce, elem);
		}

		ParenElement parseParenElement() { 
			PatternElement[] elements;

			match(TokenType.TT_4);
			elements ~= parsePatternElement();

			while(opt_match(TokenType.TT_6)) {
				elements ~= parsePatternElement();
      }

			match(TokenType.TT_5);
			return new ParenElement(elements, );
		}

		FlagElement parseFlagElement() { 
			Identifier flag_name;

			match(TokenType.TT_16);
			flag_name = parseIdentifier();

			return new FlagElement(flag_name);
		}

		AlternativeElement parseAlternativeElement(PatternElement p) { 
			PatternElement[] alternatives;

			alternatives ~= p;

			while(opt_match(TokenType.TT_8)) {
				alternatives ~= parsePatternElement(true);
			}

			assert(alternatives.length>1);

			return new AlternativeElement(alternatives);
		}

		AnonymousGroupElement parseAnonymousGroupElement() {
			PatternElement[] elements;
			
			match(TokenType.TT_18);
			
			elements ~= parsePatternElement();
			while(opt_match(TokenType.TT_6)) {
				elements ~= parsePatternElement();
			}
			match(TokenType.TT_19);
			
			return new AnonymousGroupElement(elements);
		}

		LexerElement parseLexerElement() {
			if (isLookbehindElement()) {
				return parseLookbehindElement();
			}  else if (isNamedChar()) {
				return parseNamedChar();
			}  else if (isStringElement()) {
				return parseStringElement();
			}  else if (isRangeElement()) {
				return parseRangeElement();
			}  else if (isNotElement()) {
				return parseNotElement();
			}  else 
				assert(0, "No Matching LexerElement" );
		}

		
		LookbehindElement parseLookbehindElement() { 
			StringElement str;

			match(TokenType.TT_11);
			match(TokenType.TT_4);
			str = parseStringElement();

			match(TokenType.TT_5);
			return new LookbehindElement(str, );
		}

		NamedChar parseNamedChar() { 
			bool isArray;
			Identifier name;

			match(TokenType.TT_17);
			if (opt_match(TokenType.TT_14)) {
				isArray = true;
			}

			name = parseIdentifier();

			return new NamedChar(isArray, name);
		}

		StringElement parseStringElement() { 
			return new StringElement(match(TokenType.TT_StringElement).data);
		}

		CharRange parseCharRange() {
			auto t = match(TokenType.TT_CharRange);
			return new CharRange(t.data[0], t.data[1]);
		}

		RangeElement parseRangeElement() { 
			CharRange[] ranges;
			bool isArray;
			Identifier name;

			match(TokenType.TT_13);
			while(!opt_match(TokenType.TT_15)) {
				ranges ~= parseCharRange();
			}
			
			if(opt_match(TokenType.TT_14)) {
				isArray = true;
			} 
			
			if (peekMatch([TokenType.TT_Identifier])) {
				name = parseIdentifier();
			}

			return new RangeElement(ranges, isArray, name);
		}

		NotElement parseNotElement() { 
			LexerElement ce;

			match(TokenType.TT_2);
			ce = parseLexerElement();

			return new NotElement(ce);
		}

	}

	return Parser(tokens).parseGroup();
}
