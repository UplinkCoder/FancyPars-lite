module sourceGenerators.d.genAST;
import sourceGenerators.d.common;
import fancy_ast;
import fancy_analyzer;
import fancy_util;
import std.array;
import std.conv;
import std.algorithm:filter;

auto locationString = q{
struct MyLocation {
	uint line;
	uint col;
	uint index;
	uint length;
}
};

string genAST(const GrammerAnalyzer.AnalyzedGrammar ag, const Group parent = null) {
	uint anonGroupCount;
	string result;

	result ~= locationString ~ "\n";
	result ~= "abstract class ";
	result ~= ag.allGroups[0].name.identifier;
	result ~= " {\n\tMyLocation loc;\n}\n\n";
	// duplicated alot of code 
	foreach(eG;ag.allGroups[0].groups.filter!(g => !g.hasGroups)) {
		auto astMembers = eG.elements.ASTMembers;
		
		result ~= "final class " 
			~ eG.name.identifier ~ " : "
				~ ag.allGroups[0].name.identifier ~ " {";
		result ~= parent ? "\n" ~ parent.name.identifier.indentBy(1) ~ " parent;\n" : "";

		
		if (!astMembers.empty) {
			result ~= "\n";
			
			foreach(el;astMembers) {
				result ~= genDecl(el).indentBy(1);
			}
			
			result ~= "\n" ~ "this(".indentBy(1);
			foreach(el;astMembers) {
				result ~= getType(el) ~ " "  
					~ getName(el) ~ ", ";
			}
			
			result = result[0..$-2] ~ ") pure {\n";
			
			foreach(el;astMembers) {
				result ~= "this.".indentBy(2)
					~ getName(el) 
						~ " = " ~ getName(el) ~ ";\n";
			}
			
			result ~= "}\n".indentBy(1);
			
		}
		result ~= "}\n\n";
		
	}
	// this is duplicated under here
	foreach(pG;ag.allGroups[1..$].getParentGroups) {
		Group p;
		foreach(gi;ag.groupInformation) {
			if (gi.group is pG) {
				p = cast (Group) gi.groupInformation.parent;
			}
		}

		foreach(eG;pG.groups.filter!(g => !g.hasGroups)) {
			auto astMembers = eG.elements.ASTMembers;
			
			result ~= "final class " 
				~ eG.name.identifier ~ " : "
					~ pG.name.identifier ~ " {";
			result ~= parent ? "\n" ~ parent.name.identifier.indentBy(1) ~ " parent;\n" : "";
			
			foreach(age;ag.allElements.filter!(e => cast(AnonymousGroupElement)e !is null)) {
				debug{import std.stdio;writeln("Age :",anonGroupCount++);}
			}
			
			if (!astMembers.empty) {
				result ~= "\n";
				
				foreach(el;astMembers) {
					result ~= genDecl(el).indentBy(1);
				}
				
				result ~= "\n" ~ "this(".indentBy(1);
				foreach(el;astMembers) {
					result ~= getType(el) ~ " "  
						~ getName(el) ~ ", ";
				}
				
				result = result[0..$-2] ~ ") pure {\n";
				
				foreach(el;astMembers) {
					result ~= "this.".indentBy(2)
						~ getName(el) 
							~ " = " ~ getName(el) ~ ";\n";
				}
				
				result ~= "}\n".indentBy(1);
				
			}
			result ~= "}\n\n";
			
		}
		result ~= "abstract class " 
			~ pG.name.identifier 
				~ ( p ? " : " 
					~ p.name.identifier : "")
				~ " {}\n\n";
//		foreach(eG;pG.groups.filter!(g => !g.hasGroups)) {
//			auto astMembers = eG.elements.ASTMembers;
//
//			result ~= "final class " 
//				~ eG.name.identifier ~ " : "
//				~ pG.name.identifier ~ " {";
//			result ~= parent ? "\n" ~ parent.name.identifier.indentBy(1) ~ " parent;\n" : "";
//
//			foreach(age;ag.allElements.filter!(e => cast(AnonymousGroupElement)e !is null)) {
//				debug{import std.stdio;writeln("Age :",anonGroupCount++);}
//			}
//
//			if (!astMembers.empty) {
//				result ~= "\n";
//
//				foreach(el;astMembers) {
//					result ~= genDecl(el).indentBy(1);
//				}
//
//				result ~= "\n" ~ "this(".indentBy(1);
//				foreach(el;astMembers) {
//						result ~= getType(el) ~ " "  
//							~ getName(el) ~ ", ";
//				}
//
//				result = result[0..$-2] ~ ") pure {\n";
//				
//				foreach(el;astMembers) {
//						result ~= "this.".indentBy(2)
//							~ getName(el) 
//							~ " = " ~ getName(el) ~ ";\n";
//				}
//
//				result ~= "}\n".indentBy(1);
//			
//			}
//			result ~= "}\n\n";
//			
//		}

	}
	return result;

}

