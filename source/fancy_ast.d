abstract class ASTNode {}
pure :
class Identifier : ASTNode {

	override string toString() pure {
		return cast(string) ("ID:" ~ identifier ); 
	}
	alias opEquals = Object.opEquals;
	
	override bool opEquals(Object o) pure {
		auto id = (cast(Identifier)o);
		return (id ? opEquals(id) : false);
	}
	
	bool opEquals(Identifier rhs) pure {		
		return this.identifier == rhs.identifier;
	}

	string identifier;

	this(string identifier) pure {
		this.identifier = identifier;
	}
}
class Number : ASTNode {
	char[] number;

	this(char[] number) pure {
		this.number = number;
	}
}
class Group : ASTNode {
	//Group parent;
	Identifier name;
	Identifier[] annotations;

	PatternElement[] elements;
	Group[] groups;

	this(/*Group parent,*/ Identifier name, Identifier[] annotations, PatternElement[] elements, Group[] groups) pure {
//		this.parent = null;
		this.name = name;
		this.annotations = annotations;
		this.elements = elements;
		this.groups = groups;
	}

	const bool hasGroups() pure {
		return !!groups;
	}

	override bool opEquals(Object o) pure {
		auto g = (cast(Group)o);
		return (g ? opEquals(g) : false);
	}

	bool opEquals(Group rhs) pure {
		return this.name.identifier == rhs.name.identifier;
	}


}
abstract class PatternElement : ASTNode {
	ASTNode parent;
	override bool opEquals(Object o) pure {
		auto pe = (cast(PatternElement)o);
		return (pe ? opEquals(pe) : false);
	}

	override string toString() pure {
		assert(0, "toString has to be overriden");
	}
	
//	bool opEquals(PatternElement rhs) pure {		
//		if (cast(NamedElement)this &&
//			cast(NamedElement)rhs) {
//			return cast(NamedElement) this
//				== cast(NamedElement) rhs;
//		} else if (cast(Group)this &&
//			cast(Group)rhs) {
//			return cast(Group) this
//				== cast(Group) rhs;
//		} else  if (cast(StringElement)this &&
//			cast(StringElement)rhs) {
//			return cast(StringElement) this
//				== cast(StringElement) rhs;
//		} else 
//			return false;
//	}
//
}

class AlternativeElement : PatternElement {

	override string toString() pure {
		string result;
		foreach (elem;alternatives) {
			result ~= elem.toString ~ "/";
		}
		result = result[0 .. $-1];

		return result; 
	}


	PatternElement[] alternatives;

	this(PatternElement[] alternatives) pure {
		this.alternatives = alternatives;
	}
}

class AnonymousGroupElement : PatternElement {
	PatternElement[] elements;

	this (PatternElement[] elements) pure {
		this.elements = elements;
	}

	alias opEquals = PatternElement.opEquals;
	
	override bool opEquals(Object o) pure {
		auto age = (cast(AnonymousGroupElement)o);
		return (age ? opEquals(age) : false);
	}

	bool opEquals(AnonymousGroupElement rhs) pure {		
		return this.elements == rhs.elements;
	}
}

abstract class LexerElement : PatternElement {
	alias opEquals = PatternElement.opEquals;
	
	override bool opEquals(Object o) pure {
		auto le = (cast(LexerElement)o);
		return (le ? opEquals(le) : false);
	}
	
	bool opEquals(LexerElement rhs) pure {		
		return this is rhs;
	}
}

class StringElement : LexerElement {
	const char[] string_;

	override string toString() pure {
		return cast(string) ("\"" ~ string_ ~ "\""); 
	}

	this(const char[] string_) pure {
		this.string_ = string_;
	}

	alias opEquals = LexerElement.opEquals;

	override bool opEquals(Object o) pure {
		auto se = (cast(StringElement)o);
		return (se ? opEquals(se) : false);
	}
	
	bool opEquals(StringElement rhs) pure {		
		return this.string_ == rhs.string_;
	}

}
class NamedChar : LexerElement {
	bool isArray;
	Identifier name;

	override string toString() pure {
		return cast(string) ("char" 
			~ (isArray ? "[] ": " ")
			~ name.identifier);
	}

	this(bool isArray, Identifier name) pure {
		this.isArray = isArray;
		this.name = name;
	}
}
class CharRange : LexerElement {
	char rangeBegin;
	char rangeEnd;

	this(char rangeBegin, char rangeEnd) pure {
		this.rangeBegin = rangeBegin;
		this.rangeEnd = rangeEnd;
	}

	override string toString() pure {
		return cast(string) (rangeBegin
			~ "-" ~ rangeEnd);
	}
}
class RangeElement : LexerElement {
	CharRange[] ranges;
	bool isArray;
	Identifier name;

	this(CharRange[] ranges, bool isArray, Identifier name) pure {
		this.ranges = ranges;
		this.isArray = isArray;
		this.name = name;
	}

	override string toString() pure {
		string result = "[";
		foreach (range;ranges) {
			result ~= range.toString;
		}

			result ~= "]" 
			~ (isArray ? "[] ": " ")
			~ name.identifier;

		return result;
	}
}
class LookbehindElement : LexerElement {
	StringElement str;

	this(StringElement str) pure {
		this.str = str;
	}
}
class NotElement : LexerElement {
	LexerElement ce;

	this(LexerElement ce) pure {
		this.ce = ce;
	}
}
class ParenElement : PatternElement {
	PatternElement[] elements;

	this(PatternElement[] elements) pure {
		this.elements = elements;
	}
}
class NamedElement : PatternElement {
	import std.conv:to;
	override string toString() pure {
		return cast(string) (age ? "{" ~ to!string(age.elements) ~ "}": type.identifier 
			~ (isArray ? "[] ": " ")
				~ name.identifier);
	}

	Identifier type;
	AnonymousGroupElement age;
	bool isArray;
	Identifier name;
	StringElement lst_sep;

	alias opEquals = PatternElement.opEquals;

	override bool opEquals(Object o) pure {
		auto ne = (cast(NamedElement)o);
		return (ne ? opEquals(ne) : false);
	}
	
	bool opEquals(NamedElement rhs) pure {		
			return rhs.type.identifier == this.type.identifier;
	}

	this(Identifier type,AnonymousGroupElement age, bool isArray, Identifier name, StringElement lst_sep) pure {
		this.type = type;
		this.age = age;
		this.isArray = isArray;
		this.name = name;
		this.lst_sep = lst_sep;
	}
}
class FlagElement : PatternElement {
	Identifier flag_name;

	this(Identifier flag_name) pure {
		this.flag_name = flag_name;
	}

	override string toString() pure {
		return cast(string) ("bool " 
			~ flag_name.identifier);
	}
}
class QueryElement : PatternElement {
	Identifier flag_name;
	PatternElement elem;

	this(Identifier flag_name, PatternElement elem) pure {
		this.flag_name = flag_name;
		this.elem = elem;
	}
}
class ConditionalElement : PatternElement {

	override string toString() pure {
		return cast(string) ("? "  ~ ce[0].toString ~ " : " ~ elem.toString); 
	}

	override bool opEquals(Object o) pure {
		auto oe = (cast(ConditionalElement)o);
		return (oe ? opEquals(oe) : false);
	}
	
	bool opEquals(ConditionalElement rhs) pure {		
		return this.ce == rhs.ce;
	}

	bool opEquals(LexerElement rhs) {		
		return (this.ce[0]) == rhs;
	}

	LexerElement[] ce;
	PatternElement elem;

	this(LexerElement[] ce, PatternElement elem) pure {
		this.ce = ce;
		this.elem = elem;
	}
}


