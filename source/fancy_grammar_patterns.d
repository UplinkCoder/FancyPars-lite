module fancy_grammar_patterns;
import fancy_ast;

pure : 

struct EnumifiableGroup_ {
	Identifier name;
	static struct EnumEntry {
		Identifier enumName;
		StringElement enumValue;
	}

	EnumEntry[] enumEntries;

	this(Identifier name, EnumEntry[] enumEntries) pure {
		this.name = name;
		this.enumEntries = enumEntries;
	}
}

EnumifiableGroup_* EnumifiableGroup (const Group pG) pure {
	EnumifiableGroup_.EnumEntry[] enumEntries;

	if (pG.hasGroups) {
		foreach(eG;pG.groups) {
			if (auto _seg = StringElementGroup(eG)) {
				enumEntries ~= EnumifiableGroup_.EnumEntry(_seg.name, _seg.se);
			} else {
				return null;
			} 
		}

		return new EnumifiableGroup_(cast(Identifier)pG.name, enumEntries);
	}

	return null;
}

struct LexerElementConditionElement {
	LexerElement[] conds;
}

struct StringElementGroup_ {
	Identifier name;
	StringElement se;

	this(Identifier name, StringElement se) pure {
		this.name = name;
		this.se = se;
	} 
}

StringElementGroup_* StringElementGroup(const Group eG) pure {
	if	(eG !is null && !eG.hasGroups && eG.elements.length == 1) {
		if (auto se = cast(StringElement) eG.elements[0]) {
			return new StringElementGroup_(cast(Identifier) eG.name, se);
		}
	}

	return null;
}


const(Group) LexerGroup (const Group grp) {
	return  RangeGroup(grp) ? grp : DelimitedCharGroup(grp) ? grp : null;
}

struct RangeGroup_ {
	Identifier name;
	RangeElement re;
}

RangeGroup_* RangeGroup(const Group grp) {

	if (grp.elements.length == 1) {
		RangeGroup_* rg = new RangeGroup_();
		rg.re = cast(RangeElement)grp.elements[0];
		if (rg.re !is null) {
			rg.name = cast(Identifier) grp.name;
			return rg;
		}
		rg.destroy;
	}
	
	return null;
}

struct DelimitedCharGroup_ {
	Identifier name;
	StringElement begin;
	NamedChar content;
	StringElement end;
}


DelimitedCharGroup_* DelimitedCharGroup(const Group grp) {
	if (!grp.hasGroups && grp.elements.length == 3) {
		DelimitedCharGroup_* dcg = new DelimitedCharGroup_();
		dcg.begin = cast(StringElement)grp.elements[0];
		dcg.content = cast(NamedChar)grp.elements[1];
		dcg.end = cast(StringElement)grp.elements[2];
		
		if (dcg.begin !is null
			&& dcg.content !is null
			&& dcg.end !is null
		) {
			dcg.name = cast(Identifier) grp.name;
			return dcg;
		}
		dcg.destroy;
	}
	
	return null;
}

void static_unittest() {
	import fancy_analyzer;
	import fancy_lexer;
	import fancy_parser;

	static immutable _ag = cast(immutable) `Node {
		EnmGrp { 
			OptionOne { "option1" }
			OptionTwo { "option2" }
		}

		DlChrGrp {
			"'", char chr, "'"
		}

		RngGrp {
			[a-zA-Z] id
		}
	}`.lex.parse.analyze;

	static assert (_ag.allGroups.getGroupNamed("EnmGrp").EnumifiableGroup !is null, "EnumifiableGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("DlChrGrp").EnumifiableGroup is null, "EnumifiableGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("RngGrp").EnumifiableGroup is null, "EnumifiableGroup is broken");

	static assert (_ag.allGroups.getGroupNamed("EnmGrp").DelimitedCharGroup is null, "DelimitedCharGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("DlChrGrp").DelimitedCharGroup !is null, "DelimitedCharGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("RngGrp").DelimitedCharGroup is null, "DelimitedCharGroup is broken");

	static assert (_ag.allGroups.getGroupNamed("DlChrGrp").RangeGroup is null, "RangeGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("EnmGrp").RangeGroup is null, "RangeGroup is broken");
	static assert (_ag.allGroups.getGroupNamed("RngGrp").RangeGroup !is null, "RangeGroup is broken");
}
