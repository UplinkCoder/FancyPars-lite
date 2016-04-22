module fancy_grammar_fpg;

static immutable string fancyParsGrammar  = 
q{ASTNode {
    Identifier @internal {
        [a-zA-Z_][] identifier
    }

    Group @parent {
        Identifier name, ? "@" : Identifier[] annotations : "@", "{",
            PatternElement[] elements : "," / Group[] groups,
             "}"
    }   

    PatternElement @internal {

        AlternativeElement @noFirst {
            PatternElement[] alternatives : "/"
        }
		
		AnonymosuGroupElement {
			"{", PatternElement[] elements : ",", "}"
		}
		
        LexerElement {

            StringElement {
                "\"", char[] string_, "\""
            }

            NamedChar {
                "char", ? "[]" : bool isArray, Identifier name
            }

            CharRange @internal {
                char rangeBegin,  ? "-" : char RangeEnd
            }

            RangeElement {
                "[", CharRange[] ranges, "]"
            }

            LookbehindElement {
                "?lb", "(", StringElement str, ")"
            }

            NotElement {
                "!", LexerElement ce
            }

        }

        NamedElement {
            Identifier type / AnonymousGroupElement age,  ? "[]" : bool isArray, Identifier name, 
            ? bool isArray : ? ":" : StringElement lst_sep
        }

        ParenElement {
            "(", PatternElement[] elements : ",", ")" 
        }

        FlagElement {
            "bool", Identifier flag_name
        }

        QueryElement {
            "?", "bool", Identifier flag_name, ":", PatternElement elem
        }

        ConditionalElement {
            "?", LexerElement[] ce : ",", ":", PatternElement elem
 		}

    }
}};