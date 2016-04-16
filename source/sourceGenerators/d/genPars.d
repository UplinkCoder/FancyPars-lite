module sourceGenerators.d.genPars;
import sourceGenerators.d.common;
import fancy_ast;
import fancy_analyzer;
import fancy_grammar_patterns;
import fancy_util;
import std.algorithm;
import std.range;
import std.conv;
import std.string;

pure :
alias Group = fancy_ast.Group;

static immutable parser_blrplate_head = ` parse(in Token[] tokens) pure { 
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
		
		Token match(bool _try = false)(TokenType t) {
			import std.conv;
			import std.exception:enforce;
			static if (!_try) {
				enforce(opt_match(t), "Expected : " ~ to!string(t) ~ " Got : " ~ to!string(peekToken(0)) );
				return lastMatched;
			} else {
				return ((opt_match(t) ? lastMatched : TokenType.TT_0));
			}
		}

`;
extern string genPars(const GrammerAnalyzer.AnalyzedGrammar ag) pure {
	char[] result;
	string parent_name = null;
	auto pg = ParserGenerator(ag);
	const(Group)[] excludedGroups;

	foreach(group;ag.allGroups) {
		if (group.hasAnnotation("parent")) {
			parent_name = group.name.identifier;
		}
		if (auto eg = EnumifiableGroup(group)) {
			result ~= pg.enumify(*eg, 2);
			excludedGroups ~= group.groups;
			debug {
				import std.stdio;
				writeln(excludedGroups.map!(a => a.name.identifier));
			}
		} else {
			result ~= (!excludedGroups.canFind!((a,b) => a is b)(group) ? pg.genParse(group) : "");
		}
	}

	if (!parent_name) {
		parent_name = ag.allGroups[0].name.identifier;
	}

	return parent_name ~ parser_blrplate_head ~ pg.genIsMethods() ~"\n"~ result 
		~ "\n\t}\n\n\treturn Parser(tokens).parse" ~ parent_name ~ ";\n}";

}

struct ParserGenerator {
	
pure :
	const GrammerAnalyzer.AnalyzedGrammar ag;
	const (Group)[] allGroups;
	SortedRange!(string[], "a < b") sortedStrings;
	Group currentDirectLeftRecursiveParent;
	Group currentGroup;
	bool leftRecursiveElement;
	
	this (const GrammerAnalyzer.AnalyzedGrammar ag) {
		this.ag = ag;
		this.allGroups = ag.allGroups;
		this.sortedStrings = cast(SortedRange!(string[], "a < b")) ag.strings;
		//	this.LexerGroups = allGroups.filter!(g => LexerGroup(g));
	}

	
	//TODO expensive to call!

	string getTokenType(const PatternElement pe) {
		if (auto se = cast(StringElement) pe) {
			uint i;
			foreach(str;sortedStrings) {
				++i;
				if (se.string_ == str) {
					return "TokenType.TT_" ~ to!string(i);
				}
			}
			assert(0, "Trying to match unknown StringElement " ~ se.string_ ~ to!string(sortedStrings.release) );
		} else if (auto re = cast(RangeElement) pe) {
			Group parent;
			foreach(ei;ag.elementInformation) {
				if (ei.element is re) {
					parent = unQual(ei.elementInformation.parentGroup);
				}
			}
			assert(parent);
			return "TokenType.TT_" ~ parent.name.identifier;
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
				
				auto daea = disambiguationElements_(cG, ag);

				foreach(dEs;daea) {
					result ~= "peekMatch([";
					foreach(dE;dEs) {
						//	debug {import std.stdio; writeln(cG.name.identifier, " dE: ",cast(PatternElement)dE);}
						if (auto ne = cast(NamedElement)dE) {
							assert(allGroups.getGroupNamed(ne.name.identifier)
								is null
								|| ag.getDirectLeftRecursiveParent(allGroups.getGroupNamed(ne.name.identifier)) is null,
								"DirectLeftRecursion elemination failed!");
							
							result ~= "TokenType.TT_" ~ ne.type.identifier ~ ", ";
						} else if (auto se = cast(StringElement)dE) {
							result ~= getTokenType(se) ~ ", ";
						} else if (auto re = cast(RangeElement) dE) {
							result ~= getTokenType(re) ~ ", ";
						} else {
							result ~= /*to!string(typeid(dE)) ~ */", ";
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
		assert(elem, "cannot pass null into condOf");

		if (auto oe = cast(ConditionalElement)elem) {
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
		} else if (elem.isASTMember) {
			return cast (char[]) 
				("is" ~ elem.getType(false) ~ "()");
		} else {
			return null;//cast(char[]) to!string(typeid(elem));
		}
	}

	char[] enumify(const EnumifiableGroup_ eg, uint iLvl) {
		auto gid = eg.name.identifier;
		auto lgid =	(cast(char)gid[0].toLower) ~ gid[1 .. $];
		
		char[] result =  gid.indentBy(iLvl++)
			~ " parse" ~ gid ~ "() {\n"
				~  gid.indentBy(iLvl) ~ " " ~ lgid ~ ";"
				~ "\n" ~ "".indentBy(iLvl);
		
		foreach(entry;eg.enumEntries) {
			result ~= "if (opt_match(" 
				~ getTokenType(entry.enumValue) 
					~ ")) {\n" ~ lgid.indentBy(iLvl+1) 
					~ " = new " ~ gid ~ "(" ~ gid ~ "Enum." 
					~ entry.enumName.identifier
					~ ");\n" ~ "} else ".indentBy(iLvl);
		}

		result ~= "assert(0, \"No such EnumValue\");\n\n" ~ "return ".indentBy(iLvl)
			~ lgid ~ ";\n" ~ "}\n\n".indentBy(--iLvl);
		
		return result;
	}

	string genParse(const Group group, uint iLvl = 2) {
		auto dlrcs = getDirectLeftRecursiveChildren(group, ag);

		bool hasRecursiveChildren = dlrcs !is null;
		
		if (group.elements.any!(e => cast (NamedChar)e)) {
			return "";
		}
		
		char[] result;


		char[] genNameEnum() {
			char[] result = cast(char[])"enum " ~ group.name.identifier
				~ "RCEnum {\n" ~ "__Init,\n".indentBy(iLvl+1);
			foreach(dlrG;dlrcs) {
				result ~= "__".indentBy(iLvl+1) ~ dlrG.name.identifier ~ ",\n";
			}
			result = result[0 .. $-2] ~ "\n" ~ "}\n".indentBy(iLvl);
			return result;
		}
		
		if (hasRecursiveChildren) {
			result ~= (genNameEnum()
				.indentBy(iLvl) ~ "\n");
		}
		
		result ~= group.name.identifier.indentBy(iLvl)
			~ " parse" ~ group.name.identifier;
		
		if (auto p = cast(Group) ag.getDirectLeftRecursiveParent(group)) {
			currentDirectLeftRecursiveParent = p;
			currentGroup = cast (Group) group;
			result ~= "(" ~ p.name.identifier ~" prev) {\n";
		} else if (hasRecursiveChildren) {
			result ~= "(" ~ group.name.identifier ~ "RCEnum __rc = " 
				~ group.name.identifier ~ "RCEnum.__Init) {\n";  
		} else {
			result ~= "() {\n";
		}
		iLvl++;
		
		if (group.groups) {

			result ~= group.name.identifier.indentBy(iLvl) 
				~ " " ~ group.name.identifier[0..1].toLower ~ ";\n";

			result ~= `			
			MyLocation loc;
			auto firstToken = peekToken(0);
			loc.line = firstToken.line;
			loc.col = firstToken.col;
			loc.index = firstToken.pos;
`;			
			result ~= "".indentBy(iLvl);

			foreach(cG;group.groups.filterOutInternal) {
				bool isDLR;
				if (dlrcs) {
					foreach(dlrG;dlrcs) {
						if (cG.name.identifier == dlrG.name.identifier) {
							isDLR = true;
							break;
						}
					}
				}
				if (isDLR) {
					// skip direct left recursive childern they come later
				} else {
					result ~= "if (is"
						~ cG.name.identifier ~ "()) {\n"
							~ group.name.identifier[0..1].toLower.indentBy(iLvl+1) 
						~ " = parse"
							~ cG.name.identifier
							~ "();\n" ~ "} else ".indentBy(iLvl);
				}
			}
			result = result[0 .. $-5] ~ "\n\n" ~ "".indentBy(iLvl);
			
			foreach(cG;dlrcs) {
				result ~= "if (is"
					~ cG.name.identifier ~ "() && __rc != " 
						~ group.name.identifier ~ "RCEnum.__" 
						~ cG.name.identifier ~ ") {\n"
						~ group.name.identifier[0..1].toLower.indentBy(iLvl+1) 
					~ " = parse"
						~ cG.name.identifier
						~ "(" ~ group.name.identifier[0..1].toLower
					~ ");\n" ~ "} else ".indentBy(iLvl);
			}
			result = result[0 .. $-5] ~ "\n\n";
			result ~= `			auto lastToken = peekToken(-1);
			loc.length = lastToken.pos - firstToken.pos + lastToken.length;
`;
			result ~= "auto ret = ".indentBy(iLvl) 
				~ group.name.identifier[0..1].toLower ~ ";\n";
			result ~= "\t\t\tret.loc = loc;\n\t\t\treturn ret;\n";
		} else {
			const(PatternElement)[] astMembers;
			foreach(gi;ag.groupInformation) {
				if (gi.group is group) {
					astMembers = gi.groupInformation.astMembers;
				}
			}
			foreach (element;astMembers) {
				result ~= genDecl(element).indentBy(iLvl);
			}
			result ~= "\n";
			result ~= `			
			MyLocation loc;
			auto firstToken = peekToken(0);
			loc.line = firstToken.line;
			loc.col = firstToken.col;
			loc.index = firstToken.pos;
`;			
			
			leftRecursiveElement = ag.getDirectLeftRecursiveParent(group) !is null;
			foreach(element;group.elements) {
				result ~= genParse(element, iLvl);
			}
			result ~= `			auto lastToken = peekToken(-1);
			loc.length = lastToken.pos - firstToken.pos + lastToken.length;
`;
			result ~= "auto ret = new ".indentBy(iLvl) 
				~ group.name.identifier ~ "(";

			foreach(element;astMembers) {
				result ~= getName(element) ~ ", ";
			}
			
			if (!astMembers.empty) {
				result = result[0..$-2];
			}
			
			result ~= ");\n";

			result ~= "\t\t\tret.loc = loc;\n\t\t\treturn ret;\n";
		}
		
		result ~= "}\n\n".indentBy(--iLvl);

		return result;
	}

	string genParse(const PatternElement element, uint iLvl = 2) {
		char[] result;

		if (auto ne = cast(NamedElement)element) {
			if (ne.isArray) {
				if (ne.lst_sep) {
					result ~= "\n" ~ ne.getName.indentBy(iLvl)
						~ " ~= parse" ~ ne.type.identifier ~ "(";
					
					if (leftRecursiveElement) {
						result ~=  
							currentDirectLeftRecursiveParent.name.identifier
								~ "RCEnum.__" ~ currentGroup.name.identifier; 	
					}
					
					result ~= ");\n"; 

					result ~= "while(".indentBy(iLvl++) 
						~ condOf(ne.lst_sep) ~ ") {\n";
				} else {
					result ~= "while(".indentBy(iLvl++) 
						~ condOf(ne) ~ ") {\n";
				}
				
				
			}
			
			result ~= ne.getName.indentBy(iLvl + ne.isArray)
				~ (ne.isArray ? " ~=" :" =") ~ " parse" ~ ne.type.identifier ~ "(";
			if (leftRecursiveElement) {
				result ~=  
					currentDirectLeftRecursiveParent.name.identifier
						~ "RCEnum.__" ~ currentGroup.name.identifier;
			}
			
			result ~= ");\n";
			
			if (ne.isArray) {
				result ~= "}\n".indentBy(--iLvl);
			}
		} else if (auto re = cast(RangeElement)element) {
			result ~= re.name.identifier.indentBy(iLvl)
				~ " = match("~getTokenType(re)~").data;\n";
		} else if (auto nc = cast(NamedChar)element) {
			//	assert(0, "should never get a NamedChar in the parser");
		} else if (auto se = cast(StringElement)element) {
			result ~=  "match(".indentBy(iLvl) ~ 
				getTokenType(se)~");\n";
		} else if (auto oe = cast(ConditionalElement)element) {
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
					result ~= "if (" ~ condOf(alt) 
						~ ") {\n";
					result ~= genParse(alt, iLvl+1) 
						~ "} else ".indentBy(iLvl);
				} else {
					result ~= "if (opt_match(/*handleAlternativeLexerElements*/);\n {} else ";
				}
			}
			result = result[0..$-5] ~ "\n";
		} else {
			assert(0, typeid(element).to!string ~ " is not handled");
		}
		
		leftRecursiveElement = false;
		
		return cast(string) result;
	}

	string genReturn (const Group group, uint iLvl) {
		char[] result;

		result ~= "return new ".indentBy(iLvl) 
			~ group.name.identifier ~ "(";
		const(PatternElement)[] astMembers;
		foreach(gi;ag.groupInformation) {
			if (gi.group is group) {
				astMembers = gi.groupInformation.astMembers;
			}
		}
		foreach(element;astMembers) {
			result ~= getName(element) ~ ", ";
		}

		if (!astMembers.empty) {
			result = result[0..$-2];
		}
		
		return result ~ ");\n";
	}

	
}
