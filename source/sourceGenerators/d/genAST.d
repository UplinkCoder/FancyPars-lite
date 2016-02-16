module sourceGenerators.d.genAST;
import sourceGenerators.d.common;
import fancy_ast;
import fancy_analyzer;
import fancy_grammar_patterns;
import fancy_util;
import std.array;
import std.conv;
import std.string : toLower;
import std.algorithm:filter;

static immutable locationString = q{
	struct MyLocation {
		uint line;
		uint col;
		uint index;
		uint length;
		
		this(Token first, Token last) {
			line = first.line;
			col = first.col;
			index = first.pos;
			length = (first.pos - last.pos) + last.length;
		}
	}

};

string enumify (const EnumifiableGroup_ g, const Group p) {
	auto gid = g.name.identifier;
	auto lgid =	(cast(char)gid[0].toLower) ~ gid[1 .. $];
	string result  = "enum " ~ gid ~ "Enum {\n";
	
	foreach(enumEntry;g.enumEntries) {
		result ~= "\t" ~ enumEntry.enumName.identifier ~ ",\n";
	}
	
	result ~= "}\n\n";

	result ~= "final class " ~ gid 
		~ ( p ? " : " ~ p.name.identifier : "")
		~ " {\n\t" ~ gid ~ "Enum " ~ lgid ~ ";\n\t"
		~ "alias " ~ lgid ~ " this;\n\n";

	result ~= "\tthis(" ~ gid ~ "Enum " ~ lgid ~ ") pure {" 
		~ "\n\t\t" ~ "this." ~ lgid ~ " = " ~ lgid ~ ";"
		~ "\n\t}\n}\n\n";

	return result;
}


string genAST(const GrammerAnalyzer.AnalyzedGrammar ag, const Group parent = null) {
	string result;

	result ~= locationString ~ "\n";
	result ~= "abstract class ";
	result ~= ag.allGroups[0].name.identifier;
	result ~= " {\n\tMyLocation loc;\n}\n\n";
	// duplicated alot of code 
	foreach(eG;ag.allGroups[0].groups.filter!(g => !g.hasGroups)) {
		auto astMembers = ag.astMembers(eG);

		
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
	foreach(pG;ag.allGroups[1..$].filter!(g => g.hasGroups)) {
		Group p;
		foreach(gi;ag.groupInformation) {
			if (gi.group is pG) {
				p = cast (Group) gi.groupInformation.parent;
			}
		}

		if (auto eg = EnumifiableGroup(pG)) {
			result ~= enumify(*eg, p);
			continue ;
		}

		result ~= "abstract class " 
			~ pG.name.identifier 
				~ ( p ? " : " 
					~ p.name.identifier : "")
				~ " {}\n\n";

		foreach(eG;pG.groups.filter!(g => !g.hasGroups)) {
			auto astMembers = ag.astMembers(eG);

			result ~= "final class " 
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
	}

	return result;
}

