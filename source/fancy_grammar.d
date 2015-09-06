module fancy_grammar;
import fancy_util;
import fancy_ast;
import std.conv;
import std.traits;
import std.range;
import std.algorithm:filter,map,partition,sort,commonPrefix,multiSort,countUntil,any,all;
import std.array;


private auto disambiguationElements_(const (Group)[] canidateGroups, const Group group, const uint i) pure {
	//assert(group.elements.length>i);
	auto filterd = canidateGroups
		.filter!(g => g.elements !is null)
		.filter!(g => g.elements.length > i)
		.filter!(g => g !is group)
		.filter!(g => g.elements[i].isSame(group.elements[i]));

	return filterd;

}

auto disambiguationElements(const Group grp, const (Group)[] allGroups) {
	PatternElement[][] daes;
	auto grs = allGroups;
	auto p = cast (Group) getDirectLeftRecursiveParent(allGroups.getGroupNamed(grp.name.identifier));
	
	debug {
		import std.stdio;
		writeln(grp.name.identifier ,(p ? ":" ~ p.name.identifier : ""));
	}
	
	foreach(i;(p?1:0) .. grp.elements.length) {
		if (grs.length>1) {
			grs = disambiguationElements_(grs, grp, i).array;
		} else {
			if (cast(OptionalElement)grp.elements[i-1]) {
				i++;
			} else if (auto ne = cast(NamedElement)grp.elements[i-1]) {
				//allGroups.getGroupNamed(ne.name.identifier)
			}
			return splitOptionals(grp.elements[0 .. i]);
		}
	}
	debug {
		import std.stdio;
		writeln (grp.name.identifier ~ to!string(grp.elements.length) ~ grs.length.to!string);
	}
	// if we get here the foreach-loop did not fire ... (we had an element count of one)
	// HACK
	
	if (auto ne = cast(NamedElement)grp.elements[0]) {
		if (ne.isArray) {
			if (ne.lst_sep) {
				return splitOptionals([ne.lst_sep]);
			} else {
				assert(0, "There cannot be an left recursive Group with an unended Array... I suppose ...");
			}
		}
	}
	
		return splitOptionals([grp.elements[0]]);
	}

const (Group[]) getDirectLeftRecursiveChildren (const Group g) pure {
	static immutable func = assumePure(&getDirectLeftRecursiveChildren__);
	return func(g);
}

const (Group[]) getDirectLeftRecursiveChildren__ (const Group g) {
	const(Group)[] result;
	foreach(group;g.getAllGroups) {
		if (getDirectLeftRecursiveParent(group) == g) {
			result ~= group;
		}
	}
	
	return cast(const(Group[])) (result.length ? result : null);
}
const (Group) getDirectLeftRecursiveParent (const Group g) pure {
	static immutable func = assumePure(&getDirectLeftRecursiveParent__);
	return func(g);
}

const (Group) getDirectLeftRecursiveParent__ (const Group g) {
	static const (Group) getDirectLeftRecursiveParent_(const NamedElement ne, const Group p) {
		if (ne.type == p.name) {
			return p;
		} else if (p.parent) {
			 return getDirectLeftRecursiveParent_(ne, p.parent);
		} else {
			return null;
		}
	}

	if (!g.elements) {
		return null;
	}

	auto ne = (cast(NamedElement)g.elements[0]);
	if (ne !is null) {
		return getDirectLeftRecursiveParent_(ne, g);
	} else {
		return null;
	}
}


auto getDirectLeftRecursiveGroups (GR)(GR groupRange) if (is(Unqual!(ElementType!GR) : Group)) {
	auto lrgs = groupRange
		.filter!(g => !g.hasGroups)
		.filter!(g => getDirectLeftRecursiveParent(g));
	
	return lrgs;
}

pure :

const(PatternElement[][]) splitOptionals(const PatternElement[] elms) {
	PatternElement[][] result;

	PatternElement[][] options;
	PatternElement[] untouched;
	uint[] optpos_s;
	uint lasti;

	foreach(uint i,elm;elms) {
		if (auto oe = cast(OptionalElement) elm) {
			optpos_s ~= i;
			PatternElement[] tmp; 
			foreach(opt;oe.ce) {
				tmp ~= cast(PatternElement) opt;
			}

			options ~= tmp;
		} else {
			untouched ~= cast(PatternElement) elm;
		}
	}

	result ~= untouched[0 .. $];

	foreach(uint i;0 .. cast(uint)elms.length) {
		//FIXME handle multiple optionals
		foreach(j,optpos;optpos_s) {
			if (i == optpos) {
				result ~= untouched[0 .. j+1] ~ options[j] ~ untouched[j+1 .. $];
			}
		}
	}

	return result;

}

const(Group[]) getAllGroups(const Group root) {
	return cast(const(Group[]))getAllGroups(cast(Group)root, null);
}

Group[] getAllGroups(Group root, Group parent) {
	Group[] result;
	
	if (root.hasGroups) {
		Group g = new Group(cast(Identifier)root.name, cast(Identifier[])root.annotations, null, (cast(Group[])(root.groups)).dup);
		cast(Group)(g.parent) = cast(Group)parent;
		result ~= g;

		foreach(gr;g.groups) {
			result ~= cast(Group[])getAllGroups(gr, g);
		}

	} else {
		PatternElement[] elements;
		foreach(elm;cast(PatternElement[])root.elements) {
			elements ~= elm;
			elements[$-1].parent = root;
		}

		result ~= new Group(cast(Identifier)root.name, cast(Identifier[])root.annotations, elements, null);
		cast(Group)(result[$-1].parent) = cast(Group)parent;
		
	}
	return result;
}
const (PatternElement)[] getAllElements (const (PatternElement)[] elements) {
	return cast(const PatternElement[]) getAllElements (cast(PatternElement[])elements, null);
}

PatternElement[] getAllElements(PatternElement[] elements, ASTNode parent) {
	PatternElement[] result;

	foreach(elm;elements) {
		 {
			result ~= elm;
			if (parent) {
				result[$-1].parent = parent;
			}
			if (elm.containingElements) {
				result ~= getAllElements(elm.containingElements, result[$-1]);
			}
		}
	}
	return result;
}

string genDecl(const PatternElement element) {
	string result;
	if(!element.isASTMember) {
		return "\n/*+++ERROR+++\n*/\n";
	}
	
	return getType(element) ~ " " ~ getName(element) 
		~ ";\n";
	
	assert(0, "Wrong argument to genDecl " ~ to!string(typeid(element)));
	
}

const (Group) getGroupNamed(GR)(GR groupRange, const string name) if (is(Unqual!(ElementType!GR) : Group)) {
	auto canidates = groupRange
		.filter!(g => g.name.identifier == name);
	auto group = (canidates.empty ? null : canidates.front);

	debug {
		if (group !is null) canidates.popFront;
		assert(canidates.empty, "Multipile groups are named : " ~ name);
	}

	return group;
}
string[] getStrings(const (Group[]) allGroups) { 
	string[] strings;

	foreach(elements;allGroups
		.getElementGroups
		.map!(g => g.elements)
		) {
		foreach (elm;elements.getAllElements) {
			if (auto e = cast(StringElement)elm) {
				bool isIn;
				foreach(str;strings) {
					if (str==e.string_) {
						isIn = true;
						break;
					}
				}
				if (!isIn) {
					strings ~= e.string_.idup;
				}
			}
		}
	}
	return sort(strings).array;
}

auto orderByLength(const (Group)[] groups) {
	auto part = (cast(Group[])groups).partition!(g => g.hasGroups);
	auto sortGroups = part.array;

	return sortGroups
 		.sort!((a,b) => a.elements.length > b.elements.length).release
			~ groups.filter!(g => g.hasGroups).array;
}

auto orderByPrefix(const (Group)[] groups) {
	const uint[const PatternElement] rank; 
	uint[const PatternElement] seenFirsts;
	const(PatternElement)[][const PatternElement] knownPrefixs;

	foreach(group;groups) {
		if (auto n = group.elements[0] in seenFirsts) {
			++(*n);
			foreach(elm;group.elements) {
				knownPrefixs[group.elements[0]] ~= elm;
			}
		} else {
			++seenFirsts[group.elements[0]];
		}
	}

	auto part = (cast(Group[])groups).partition!(g => g.hasGroups);
	auto sortGroups = part.array;
	
	return sortGroups
		.sort!((a,b) => a.elements.length > b.elements.length).release
			~ groups.filter!(g => g.hasGroups).array;
}

auto filterOutInternal(GR)(GR groupRange) if (is(Unqual!(ElementType!GR) : Group)) {
	return groupRange
		.filter!(g => !g.isInternal);
}

auto getElementGroups(GR)(GR groupRange) if (is(Unqual!(ElementType!GR) : Group)) {
	return groupRange
		.filter!(g => !g.hasGroups);
}

auto getParentGroups(GR)(GR groupRange) if (is(Unqual!(ElementType!GR) : Group)) {
	return groupRange
		.filter!(g => g.hasGroups);
}

string getName(const PatternElement element) {
	if (auto ne = cast (NamedElement)element) {
		return ne.name.identifier;
	} else if (auto qe = cast (QueryElement)element) {
		return qe.flag_name.identifier;
	} else if (auto fe = cast (FlagElement)element) {
		return fe.flag_name.identifier;
	}	else if (auto nc = cast (NamedChar)element) {
		return nc.name.identifier;
	} else if (auto re = cast (RangeElement)element) {
		return re.name.identifier;
	} else {
		assert(0, "Element " ~ to!string(typeid(element)) 
			~ "is no AST member");
	}
	
}

string getType(const PatternElement element, bool withArray = true) {
	if (auto ne = cast (NamedElement)element) {
		return cast(string) (ne.type.identifier 
			~ (ne.isArray && withArray ? "[]" : ""));
	} else if (auto fe = cast (FlagElement)element) {
		return "bool";
	}	else if (auto nc = cast (NamedChar)element) {
		return cast(string) ("char" 
			~ (nc.isArray && withArray ? "[]" : ""));
	} else if (auto re = cast (RangeElement)element) {
		return cast(string) ("char" 
			~ (re.isArray && withArray ? "[]" : ""));
	} else {
		assert(0, "Element " ~ to!string(typeid(element)) 
			~ "is no AST member");
	}
	
}

bool isArray(const PatternElement element) {
	if (auto ne = cast(NamedElement)element) {
		return ne.isArray;
	} else if (auto nc = cast(NamedChar)element) {
		return nc.isArray;
	} else if (auto re = cast(RangeElement)element) {
		return re.isArray;
	} else {
		return false;
	}
}

bool isSame (const PatternElement e1, const PatternElement e2) {
	if (cast(NamedElement)e1 && cast(NamedElement)e2) {
		return (((cast(NamedElement)e1).type.identifier
			== (cast(NamedElement)e2).type.identifier));	
	} else if (cast(StringElement)e1 && cast(StringElement)e2) {
		return (((cast(StringElement)e1).string_
			== (cast(StringElement)e2).string_));	
	} else {
		return false;
	}

}


auto ASTMembers(ER)(ER elementRange) if (is(Unqual!(ElementType!ER) : PatternElement)) {
	return elementRange.getAllElements
		.filter!(e => e.isASTMember);
}

auto LexerGroup (const Group grp) {
	return  RangeGroup(grp) ? grp : DelimitedCharGroup(grp) ? grp : null;
}

auto RangeGroup(const Group grp) {
	return (
		grp.elements.length == 1
			&& cast(RangeElement)grp.elements[0] !is null
		)
		? grp :
		null;
}

auto DelimitedCharGroup(const Group grp) {
	return (
		grp.elements.length == 3
			&& cast(StringElement)grp.elements[0] !is null
			&& cast(NamedChar)grp.elements[1] !is null
			&& cast(StringElement)grp.elements[2] !is null
		)
		? grp :
		null;
}

auto containingElements(const PatternElement elem) {
	if (auto ae = cast(AlternativeElement)elem) {
		return ae.alternatives;
	} else if (auto ne = cast(NotElement)elem) {
		return [cast(PatternElement)ne.ce];
	} else if (auto pe = cast(ParenElement)elem) {
		return pe.elements;
	} else if (auto oe = cast(OptionalElement)elem) {
		PatternElement[] res;
		foreach(elm;oe.ce) {
			res ~= elm;
		}
		res ~= oe.elem;
		return res;
	} else if (auto _ne = cast(NamedElement)elem) {
		return (_ne.lst_sep ? [cast(PatternElement)_ne.lst_sep] : null); 
	}  else if (auto qe = cast(QueryElement)elem) {
		return ([qe.elem]); 
	} else {
		return null;
	}
}

bool hasAnnotation (const Group g, const char[] annotation) {
	foreach(a;g.annotations) {
		if (a.identifier == annotation) {
			return true;
		}
	}
	return false;
}

bool isInternal(const Group g) {
	return g.hasAnnotation("internal");
}

bool isASTMember(const PatternElement element) {
	if (element is null) {
		return false;
	}
	bool ne = (cast(NamedElement)element) !is null;
	bool fe = (cast(FlagElement)element) !is null;
	bool nc = (cast(NamedChar)element) !is null;
	bool re = (cast(RangeElement)element) !is null; 
	//bool ce = element.containingElements.any!isASTMember;

	return (ne || fe || re || nc /*|| ce*/);
}
