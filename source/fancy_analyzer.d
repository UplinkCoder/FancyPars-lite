module fancy_analyzer;
import fancy_util;
import fancy_ast;
import std.conv;
import std.traits;
import std.range;
import std.algorithm:filter,map,partition,sort,commonPrefix,multiSort,countUntil,any,all,joiner;
import std.array;


private auto disambiguationElements_(const (Group)[] canidateGroups, const Group group, const uint i) pure {
	assert(group.elements.length>i);
	auto filterd = canidateGroups
		.filter!(g => g.elements !is null && g.elements.length > i && g !is group)
		.filter!(g => g.elements.length > i)
		.filter!(g => g !is group)
		.filter!(g => g.elements[i].isSame(group.elements[i]));

	return filterd;

}

auto disambiguationElements(const Group grp,const GrammerAnalyzer.AnalyzedGrammar ag) {
	PatternElement[][] daes;
	auto grs = cast(const(Group)[]) ag.allGroups;
	auto p = cast (Group) getDirectLeftRecursiveParent(ag.allGroups.getGroupNamed(grp.name.identifier), ag.groupInformation);
	
	debug {
		import std.stdio;
//		writeln(grp.name.identifier ,(p ? ":" ~ p.name.identifier : ""));
	}
	
	foreach(i;(p?1:0) .. cast(uint) grp.elements.length) {
		if (grs.length>1) {
			grs = disambiguationElements_(grs, grp, i).array;
		} else {
			if (cast(ConditionalElement)grp.elements[i-1]) {
				i++;
			} else if (auto ne = cast(NamedElement)grp.elements[i-1]) {
				//allGroups.getGroupNamed(ne.name.identifier)
			}
			return splitOptionals(grp.elements[0 .. i]);
		}
	}
	debug {
		import std.stdio;
	//	writeln (grp.name.identifier ~ to!string(grp.elements.length) ~ grs.length.to!string);
	}
	// if we get here the foreach-loop did not fire ... (we had an element count of one)
	// HACK
	
	if (auto ne = cast(NamedElement)grp.elements[0]) {
		if (ne.isArray) {
			if (ne.lst_sep) {
				return splitOptionals([ne.lst_sep]);
			} else {
				return splitOptionals([grp.elements[0]]);
				//assert(0, "There cannot be an left recursive Group with an unended Array... I suppose ...");
			}
		}
	}
	
		return splitOptionals([grp.elements[0]]);
	}

const (Group[]) getDirectLeftRecursiveChildren (const Group g,  const GrammerAnalyzer.AnalyzedGrammar ag) pure {
	static immutable func = assumePure(&getDirectLeftRecursiveChildren__);
	return func(g, ag);
}
//TODO traverse Tree Top Down instead of doing all work multiple times
const (Group[]) getDirectLeftRecursiveChildren__ (const Group g, const GrammerAnalyzer.AnalyzedGrammar ag) {
	const(Group)[] result;
	foreach(group;ag.allGroups) {
		if (getDirectLeftRecursiveParent(group, ag.groupInformation) == g) {
			result ~= group;
		}
	}
	
	return cast(const(Group[])) (result.length ? result : null);
}
const (Group) getDirectLeftRecursiveParent (const Group g, const GrammerAnalyzer.GroupInformationTuple[] gis) pure {
	static immutable func = assumePure(&getDirectLeftRecursiveParent__);
	return func(g, gis);
}

const (Group) getDirectLeftRecursiveParent__ (const Group g, const GrammerAnalyzer.GroupInformationTuple[] gis) {
	const (Group) getDirectLeftRecursiveParent_(const NamedElement ne, const Group p) {
		Group parent;
		foreach(gi;gis) {
			if (gi.group == p) {
				parent = cast(Group) gi.groupInformation.parent;
			}
		}
		if (ne.type == p.name) {
			return p;
		} else if (parent) {
			 return getDirectLeftRecursiveParent_(ne, parent);
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
		if (auto oe = cast(ConditionalElement) elm) {
			optpos_s ~= i;
			PatternElement[] tmp; 
			foreach(opt;oe.ce) {
				tmp ~= cast(PatternElement) opt;
			}
			if (cast(LexerElement) oe.elem || ((cast(NamedElement)oe.elem !is null) &&
					(cast(NamedElement)oe.elem).type.identifier)) {
				tmp ~= oe.elem;
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
				if (untouched.length) { 
					result ~= untouched[0 .. j+1] ~ options[j] ~ untouched[j+1 .. $];
				}
			}
		}
	}

	return result;

}

//const(Group[]) getAllGroups(const Group root) {
//	return cast(const(Group[]))getAllGroups(cast(Group)root, null);
//}

//Group[] getAllGroups(Group root, Group parent) {
//	Group[] result;
//	
//	if (root.hasGroups) {
//		Group g = new Group(cast(Identifier)root.name, cast(Identifier[])root.annotations, null, (cast(Group[])(root.groups)).dup);
//		cast(Group)(g.parent) = cast(Group)parent;
//		result ~= g;
//
//		foreach(gr;g.groups) {
//			result ~= cast(Group[])getAllGroups(gr, g);
//		}
//
//	} else {
//		PatternElement[] elements;
//		foreach(elm;cast(PatternElement[])root.elements) {
//			elements ~= elm;
//			elements[$-1].parent = root;
//		}
//
//		result ~= new Group(cast(Identifier)root.name, cast(Identifier[])root.annotations, elements, null);
//		cast(Group)(result[$-1].parent) = cast(Group)parent;
//		
//	}
//	return result;
//}
//const (PatternElement)[] getAllElements (const (PatternElement)[] elements) {
//	return cast(const PatternElement[]) getAllElements (cast(PatternElement[])elements, null);
//}

//PatternElement[] getAllElements(PatternElement[] elements, ASTNode parent) {
//	PatternElement[] result;
//
//	foreach(elm;elements) {
//		 {
//			result ~= elm;
//			if (parent) {
//				result[$-1].parent = parent;
//			}
//			if (elm.containingElements) {
//				result ~= getAllElements(elm.containingElements, result[$-1]);
//			}
//		}
//	}
//	return result;
//}

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
//SortedRange!(string[], "a < b") getStrings(const (Group[]) allGroups) { 
//	string[] strings;
//
//	foreach(elements;allGroups
//		.getElementGroups
//		.map!(g => g.elements)
//		) {
//		foreach (elm;elements.getAllElements) {
//			if (auto e = cast(StringElement)elm) {
//				bool isIn;
//				foreach(str;strings) {
//					if (str==e.string_) {
//						isIn = true;
//						break;
//					}
//				}
//				if (!isIn) {
//					strings ~= e.string_.idup;
//				}
//			}
//		}
//	}
//	return sort(strings);
//}

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
	return elementRange
		.map!(e =>  e ~ e.containingElements)
		.join
		.filter!(e => e.isASTMember);
}

auto LexerGroup (const Group grp) {
	return  RangeGroup(grp) ? grp : DelimitedCharGroup(grp) ? grp : null;
}

auto RangeGroup(const Group grp) {
	struct RangeGroup_ {
		Identifier name;
		RangeElement re;
	}
	if (grp.elements.length == 1) {
		RangeGroup_* rg = new RangeGroup_();
		rg.re = cast(RangeElement)grp.elements[0];
		if (rg.re !is null) {
			rg.name = cast (Identifier)grp.name;
			return rg;
		}
		rg.destroy;
	}

	return null;
}

auto DelimitedCharGroup(const Group grp) {
	struct DelimitedCharGroup_ {
		Identifier name;
		StringElement begin;
		NamedChar content;
		StringElement end;
	}

	if (grp.elements.length == 3) {
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

auto containingElements(const PatternElement elem) {
	if (auto ae = cast(AlternativeElement)elem) {
		return cast(const)ae.alternatives;
	} else if (auto ne = cast(NotElement)elem) {
		return cast(const)[cast(PatternElement)ne.ce];
	} else if (auto pe = cast(ParenElement)elem) {
		return cast(const)pe.elements;
	} else if (auto oe = cast(ConditionalElement)elem) {
		PatternElement[] res;
		foreach(elm;oe.ce) {
			res ~= elm;
		}
		res ~= oe.elem;
		return cast(const)res;
	} else if (auto _ne = cast(NamedElement)elem) {
		return cast(const)(_ne.lst_sep ? [cast(PatternElement)_ne.lst_sep] : null); 
	}  else if (auto qe = cast(QueryElement)elem) {
		return cast(const)([qe.elem]); 
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
	bool age = (cast(AnonymousGroupElement)element) !is null;
	//bool ce = element.containingElements.any!isASTMember;

	return (ne || fe || re || nc || age/*|| ce*/);
}

final class GrammerAnalyzer {
	static auto getElementInformation(const PatternElement e,const AnalyzedGrammar ag) {
		Nullable!(ElementInformation) ret;
		foreach(ei;ag.elementInformation) {
			if (e is ei.element) {
				ret = cast(ElementInformation)ei.elementInformation;
				return ret;
			}
		}
		return ret;
	}

	import std.typecons;
	alias ElementInformationTuple = Tuple!(const PatternElement,"element",const ElementInformation,"elementInformation");
	alias GroupInformationTuple = Tuple!(const Group,"group",const GroupInformation,"groupInformation");

	static struct GroupInformation {
		bool isRoot;
		bool hasGroups;
		bool isRangeGroup;
		bool isDelimitedCharGroup;
		Group directLeftRecursiveParent;
		Group[] directLeftRecursiveChildren;
		
		Group parent;
	}
	
	static struct ElementInformation {
		
		Group parentGroup;
		PatternElement parentElement;
		
		enum ElementTypeEnum {
			_Invalid = 0,
			_AnonymousGroupElement,
			_AlternativeElement,
			_FlagElement,
			_NamedElement,
			_ConditionalElement,
			_ParenElement,
			_QueryElement,
			// LexerElements
			_LookbehindElement,
			_NamedChar,
			_NotElement,
			_RangeElement,
			_PeekElement,
			_StringElement,
		}
		
		ElementTypeEnum eType;
		PatternElement[] containingElements;
		
		bool isASTMember() {
			with (ElementTypeEnum)
				return eType == _NamedElement 
					|| eType == _NamedChar 
					|| eType == _RangeElement
					|| eType == _FlagElement
					|| eType == _AnonymousGroupElement;
		}
	}

	void analyzeElement(ref ElementInformation ei, PatternElement elm, ref AnalyzedGrammar ag, PatternElement parent = null) pure {

		ei.parentElement = parent;
		if (ag.allElements[$-1] !is elm) ag.allElements ~= elm;
		
		with (ElementInformation.ElementTypeEnum) {
			if (!cast(LexerElement)elm) {
				if (auto e = cast(AlternativeElement) elm) {
					ei.eType = _AlternativeElement;
					ei.containingElements = e.alternatives;
				} else if (auto e = cast(FlagElement) elm) {
					ei.eType = _FlagElement;
				} else if (auto e = cast(NamedElement) elm) {
					ei.eType = _NamedElement;
					ei.containingElements = [e.age, e.lst_sep];
				} else if (auto e = cast(ConditionalElement) elm) {
					ei.eType = _ConditionalElement;
					PatternElement[] tmp;
					foreach(el;e.ce) {
						tmp ~= cast(PatternElement)el;
					}
					ei.containingElements = tmp ~ e.elem;
				} else if (auto e = cast(ParenElement) elm) {
					ei.eType = _ParenElement;
					ei.containingElements = e.elements;
				} else if (auto e = cast(QueryElement) elm) {
					ei.eType = _QueryElement;
					ei.containingElements = [e.elem];
				} else if (auto e = cast(AnonymousGroupElement) elm) {
					ei.eType = _AnonymousGroupElement;
				}
			} else {
				if (auto e = cast(LookbehindElement) elm) {
					ei.eType = _LookbehindElement;
				} else if (auto e = cast(NamedChar) elm) {
					ei.eType = _NamedChar;
				} else if (auto e = cast(NotElement) elm) {
					ei.eType = _NotElement;
					ei.containingElements = [e.ce];
				} else if (auto e = cast(RangeElement) elm) {
					ei.eType = _RangeElement;
					//} else if (auto e = cast(PeekElement) elm) {
					//ei.eType =	_PeekElement;
					//ei.containingElements = [e.ce];
				} else if (auto e = cast(StringElement) elm) {
					ei.eType = _StringElement;
					bool dontAdd = false;
					foreach(str;ag._strings) {
						if (str == e.string_) {
							dontAdd = true;
							break;
						}
					}
					if (!dontAdd) {
						ag._strings ~= cast(string)e.string_;
					}
				}
			}
			
			if (ei.containingElements) {
				foreach(ce;ei.containingElements) {
					ElementInformation cei;
					analyzeElement(cei, ce, ag, elm);
					ag.elementInformation ~= ElementInformationTuple(ce, cei);
				}
			}
		}
		
	}

	static struct AnalyzedGrammar {
		string rootNodeName;
		string[] _strings;
		SortedRange!(string[], "a < b") strings;
		const(Group)[] allGroups;
		const(PatternElement)[] allElements;
		
		//alias GroupNameTuple = Tuple!(const char[],"name",Group,"group"); 
		//[] groupsByName;
		
		GroupInformationTuple[] groupInformation;
		ElementInformationTuple[] elementInformation;
	}
	
	AnalyzedGrammar analyze(const Group root) pure {
		string[] _strings;
		AnalyzedGrammar result;


		void getAllGroups(const Group root, const Group parent = null) {
			GroupInformation gi;
			import std.exception:enforce;
			//enforce (root.name.identifier !in result.groupsByName, "multiple groups are named "
			//	~ root.name.identifier);
			//result.groupsByName[root.name.identifier] = root;
			result.allGroups ~= root;

			if (parent) {
				gi.parent = cast(Group) parent;
			}
			if (root.hasGroups) {
				foreach(gr;root.groups) {
					getAllGroups(gr, root);
				}
				
			} else {
				foreach(el;root.elements) {
					result.allElements ~= el;
					ElementInformation ei;
					ei.parentGroup = cast(Group)root;
					analyzeElement(ei, cast(PatternElement)el, result);
					result.elementInformation ~= ElementInformationTuple(el, ei);
				}
			}
			
			result.groupInformation ~= GroupInformationTuple(root, gi);
			return ;
		}

		getAllGroups(root);
	//	assert(_strings.length);
		result.strings = sort(result._strings);
		result.rootNodeName = root.name.identifier;

		return result;
	}
	
}
