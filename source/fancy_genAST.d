module fancy_genAST;
import fancy_ast;
import fancy_genPars;
import fancy_grammar;
import fancy_util;
import std.array;
import std.conv;
import std.algorithm:filter;

string genAST(const (Group[]) allGroups, const Group parent = null) {
	string result;

	foreach(pG;allGroups.getParentGroups) {
		result ~= "abstract class " 
			~ pG.name.identifier 
				~ ( pG.parent ? " : " 
					~ pG.parent.name.identifier : "")
				~ " {}\n\n";
		foreach(eG;pG.groups.filter!(g => !g.hasGroups)) {
			auto astMembers = eG.elements.getAllElements.filter!(e => e.isASTMember);

			result ~= "class " 
				~ eG.name.identifier ~ " : "
				~ pG.name.identifier ~ " {";
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

				result = result[0..$-2] ~ ") {\n";
				
				foreach(el;astMembers) {
						result ~= "this.".indentBy(2)
							~ getName(el) 
							~ " = " ~ getName(el) ~ ";\n";
				}

				result ~= "}\n".indentBy(1);
			
			}
			result ~= "}\n\n";
			
		}

	}
	return result;

}

