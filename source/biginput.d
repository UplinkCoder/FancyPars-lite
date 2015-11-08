module biginput;

static immutable string bigInput =  `
ASTNode {
	Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group @parent {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {

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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}

		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
				Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
	}
		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}		Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}
		
		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}	
	
	Identifier {
		[a-zA-Z_-_][] identifer
	}

	Number {
		[0-9][] number
	}

	Group  {
		Identifier name, ? "@", !" " : Identifier annotation, "{",
 			PatternElement[] elements : "," / Group[] groups,
			 "}"
	}	

	PatternElement {
		
		AlternativeElement {
			PatternElement[] alternatives : "/"
		}
		
		LexerElement {
			
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
				"?!lb", "(", StringElement str, ")"
			}
			
			NotElement {
				"!", LexerElement ce
			}

		}

		NamedElement {
			Identifier type,  ? "[]" : bool isArray, Identifier name, 
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
		
		OptionalElement {
			"?", ConstantElement[] ce, ":", PatternElement elem
		}
		
	}
}`;

