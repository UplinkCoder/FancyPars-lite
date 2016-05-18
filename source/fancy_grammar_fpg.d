module fancy_grammar_fpg;


/+
 		ActionElement @internal {
			"(", ? Identifier[] args : (), ")",
			 "{", char[] code_, "}" 
		}
		+/

/+
		-> { 	
				bool wasSlash;
				foreach(i,c;string_) {
					if (wasSlash) {
						char nextChar;
						switch (c) {
						}
						string_ = string_[0 .. i] ~ nextChar ~ string_[i+1 .. $];
					} else if (c == '\') wasSlash = true;
				}  
			}
+/
static immutable string fancyParsGrammar  = q{
ASTNode {
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
		
		AnonymousGroupElement {
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
            "?", PatternElement ce, ":", PatternElement elem
 		}

    }
}};
