module fancy_genPars;
import fancy_ast;
import fancy_grammar;
import fancy_util;
import std.algorithm:filter,any;
import std.conv;

pure :

extern string genPars(const (Group[]) allGroups) pure {
	char[] result;
	auto pg = ParserGenerator(allGroups);
	
	foreach(group;allGroups) {
		result ~= pg.genParse(group);
	}

	return pg.genIsMethods() ~"\n"~ result;

}

struct ParserGenerator {
pure :
	const (Group)[] allGroups;
	string[] strings;
	
	this (const (Group)[] allGroups) {
		this.allGroups = allGroups;
		this.strings = allGroups.getStrings;
	//	this.LexerGroups = allGroups.filter!(g => LexerGroup(g));
	}


	//TODO expensive to call!

	string getTokenType(const PatternElement pe) {
	 if (auto se = cast(StringElement) pe) {
			foreach(i,str;strings) {
				if (se.string_ == str) {
					return "TokenType.TT_" ~ to!string(i+1);
				}
			}
			assert(0, "Trying to match unknown StringElement " ~ se.string_);
		} else if (auto re = cast(RangeElement) pe) {
			return "TokenType.TT_" ~ (cast(Group)(re.parent)).name.identifier;
			//assert(0, "Trying to match unknown LexerGroup " ~ (cast(Group)(re.parent)).name.identifier);
		} else {
			return "";
			assert (0, "we sould never get here");
		}

	}

	string genIsMethods() {
		char[] result;
		
		foreach(pG;allGroups.getParentGroups.filter!(g => !g.hasAnnotation("noFirst"))) {
			result ~= "\n" ~ "bool is".indentBy(2) 
				~ pG.name.identifier
				~ "() {\n" ~ "return".indentBy(3);
			
			auto ocGS = pG.groups.orderByLength;

			foreach(cG;ocGS.filterOutInternal.filter!(g => !g.hasAnnotation("noFirst"))) {
				result ~= " is" ~ cG.name.identifier
					~ "()\n" ~ "||".indentBy(3);
			}
			
			result[$-6 .. $] = ";\n" ~ "}\n".indentBy(2);
			
			foreach(cG; ocGS.filter!(g => !g.hasGroups)) {
				result ~= "\n" ~ "bool is".indentBy(2) 
					~  cG.name.identifier ~	"() {\n" 
					~ "return ".indentBy(3);
				auto disambiguationElements_ = assumePure(&disambiguationElements);
				
				auto daea = disambiguationElements_(cG, allGroups);
				debug {
					import std.traits;
					import std.stdio;
					foreach(i,e;daea) {
					//	writeln(i,e.map!(a => cast(Unqual!(typeof(a)))a));
					}
				}
				foreach(dEs;daea) {
					result ~= "peekMatch([";
					foreach(dE;dEs) {
					//	debug {import std.stdio; writeln(cG.name.identifier, " dE: ",cast(PatternElement)dE);}
						if (auto ne = cast(NamedElement)dE) {
							result ~= "TokenType.TT_" ~ getType(dE, false) ~ ", ";
						} else if (auto se = cast(StringElement)dE) {
							result ~= getTokenType(se) ~ ", ";
						} else {
							result ~= /*to!string(typeid(dE)) ~*/ ", ";
						}
					}
					result = result[0 .. $-2] ~ "])\n" ~ "|| ".indentBy(3);
				}

				result = result[0 .. $-9] ~ "]);\n" ~ "}\n".indentBy(2);

			}
			
		}

		return cast(string) result;
	}

	char[] condOf(const PatternElement elem) {
		char[] result;
		if (elem is null) {
			return cast(char[])"";
		}
		if (elem.isASTMember) {
				return cast (char[]) 
					("is" ~ elem.getType(false) ~ "()");
		} else if (auto oe = cast(OptionalElement)elem) {
			foreach (cond;oe.ce) {
				result ~= condOf(cond) ~ " && ";
			}
			return result[0..$-4];
		} else if (auto ne = cast(NotElement)elem) {
			return cast (char[]) ("!opt_match("
				~ getTokenType(ne.ce) ~ ")");
		} else if (auto le = cast(LexerElement)elem) {
			return cast (char[]) 
				("opt_match(" ~ getTokenType(elem) ~ ")");
		} else {
			return null;//cast(char[]) to!string(typeid(elem));
		}
	}

	string genParse(const Group group, uint iLvl = 1) {
		if (group.elements.any!(e => cast (NamedChar)e)) {
			return "";
		}
		char[] result;
		if (isDirectLeftRecursive(group)) {
			result = group.name.identifier.indentBy(iLvl)
			~ " parse" ~ group.name.identifier
	    ~ "(bool inRecursion) {\n";
		} else {
			result = group.name.identifier.indentBy(iLvl)
			~ " parse" ~ group.name.identifier
	    ~ "() {\n";
		}
		iLvl++;
	  
	  //TODO LeftRecursionSpecialHandling
	  
	  if (group.groups) {
	    result ~= "".indentBy(iLvl);
	    
	    foreach(cG;group.groups.filterOutInternal) {
	      result ~= "if (is"
	        ~ cG.name.identifier ~ "()) {\n"
	        ~ "return parse".indentBy(iLvl+1)
	        ~ cG.name.identifier
	        ~ "();\n" ~ "} else ".indentBy(iLvl);
	    }
	    
	    result = result[0 .. $-5] ~ "\n";
		} else {
	    foreach (element;group.elements.getAllElements) {
			if (element.isASTMember) {
	        	result ~= genDecl(element).indentBy(iLvl);
			}
	    }
	    result ~= "\n";
	    foreach(element;group.elements) {
	      result ~= genParse(element, iLvl);
	    }

	    result ~= "\n" ~ genReturn(group);
	  }
	  
		result ~= "}\n\n".indentBy(--iLvl);

		return result;
	}

	string genParse(const PatternElement element, uint iLvl = 1) {
		char[] result;

		if (auto ne = cast(NamedElement)element) {
			if (ne.isArray) {
				
				if (ne.lst_sep) {
					result ~= "\n" ~ ne.getName.indentBy(iLvl)
						~ " ~= parse" ~ ne.getType(false)
						~ "();\n";

					result ~= "while(".indentBy(iLvl++) 
						~ condOf(ne.lst_sep) ~ ") {\n";
				} else {
					result ~= "while(".indentBy(iLvl++) 
						~ condOf(ne) ~ ") {\n";
				}
				
				result ~= ne.getName.indentBy(iLvl+1)
					~ " ~= parse" ~ ne.getType(false)
						~ "();\n" ~ "}\n".indentBy(--iLvl);
			} else {
				result ~= ne.getName.indentBy(iLvl) 
					~ " = parse" ~ ne.getType(false) 
						~ "();\n";
			}
		} else if (auto re = cast(RangeElement)element) {
			result ~= re.name.identifier.indentBy(iLvl)
				~ " = match("~getTokenType(re)~").data;\n";
		} else if (auto nc = cast(NamedChar)element) {
		//	assert(0, "should never get a NamedChar in the parser");
		} else if (auto se = cast(StringElement)element) {
			result ~=  "match(".indentBy(iLvl) ~ 
				getTokenType(se)~");\n";
		} else if (auto oe = cast(OptionalElement)element) {
			result ~= "if (".indentBy(iLvl) 
				~ condOf(oe) ~ ") {\n" 
				~ genParse(oe.elem, iLvl+1)
				~ "}\n".indentBy(iLvl); 
		} else if (auto qe = cast(QueryElement)element) {
			result ~=  "if (".indentBy(iLvl)
				~ getName(qe) ~ ") {\n" 
				~ genParse(qe.elem, iLvl+1)
				~ "}\n".indentBy(iLvl);
		} else if (auto fe = cast(FlagElement)element) {
			result ~= getName(fe).indentBy(iLvl) 
				~ " = true;\n";
		} else if (auto pe = cast(ParenElement)element) {
			foreach(elm;pe.elements) {
				result ~= genParse(elm, iLvl);
			}
		} else if (auto ae = cast(AlternativeElement) element) {
			result ~= "".indentBy(iLvl);
			foreach(alt;ae.alternatives/*reorderByPrefix*/) {
				//there are just 2 special cases
				//OptionalElement and QueryElement


				if(alt.isASTMember) {
					result ~= "if (is" ~ getType(alt, false) 
							~ "()) {\n";
						result ~= genParse(alt, iLvl+1) 
						~ "} else ".indentBy(iLvl);
				} else {
					result ~= "if (opt_match(/*handleAlternativeLexerElements*/);\n {} else ";
				}
			}
			result = result[0..$-5] ~ "\n";
		} else {
			//assert(0, typeid(element).to!string ~ " is not handled");
		}
		return cast(string) result;
	}

	string genReturn (const Group group) {
		char[] result;

		result ~= "return new ".indentBy(2) 
			~ group.name.identifier ~ "(";
	  
	    foreach(element;group.elements.getAllElements.filter!(e => e.isASTMember)) {
	        result ~= getName(element) ~ ", ";
	    }

		if (!group.elements.getAllElements.filter!(e => e.isASTMember).empty) {
	    	result = result[0..$-2];
		}
	  
	    return result ~ ");\n";
	}


}