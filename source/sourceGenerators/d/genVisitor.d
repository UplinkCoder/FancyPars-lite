module sourceGenerators.d.genVisitor;

import fancy_ast;
import fancy_analyzer;
import fancy_util;
import fancy_grammar_patterns;

string genVisitor(const AnalyzedGrammar ag, const char[] retType = "void", const char[] funcName = "visit", uint iLvl=0, string function(const PatternElement) pure ef = null) pure {
	auto allGroups = ag.allGroups;
	const(Group)[] excludeGroups;
	string result;

	foreach(pG;allGroups.getParentGroups) {
		if (auto eg = EnumifiableGroup(pG)) {
			result ~= "\n\n" ~ retType.indentBy(iLvl) ~ " " ~ funcName ~ "(" 
				~ pG.name.identifier ~ "Enum _e) {\n" ~ "switch (_e) {\n".indentBy(iLvl + 1);

				foreach(entry;eg.enumEntries) {
					result ~= "case ".indentBy(iLvl + 2) ~ pG.name.identifier ~  "Enum." ~ entry.enumName.identifier ~ " :\n"
						~ ef(entry.enumValue).indentBy(iLvl);
					excludeGroups ~= ag.allGroups.getGroupNamed(entry.enumName.identifier);
				}

				result ~= "\n" ~ "}\n".indentBy(iLvl + 1) ~ "}\n".indentBy(iLvl);
				continue ;
		}

		result ~= "\n\n" ~ retType.indentBy(iLvl) ~ " " ~ funcName ~"(" ~ pG.name.identifier ~ " _p) {\n"
			~ "".indentBy(iLvl+1);
		foreach (eG;pG.groups) {
			result ~= "if(auto _g = cast(" ~ eG.name.identifier ~ ") _p) {\n"
				~ "return ".indentBy(iLvl+2) ~ funcName ~"(_g);" ~ "\n" ~ "} else ".indentBy(iLvl+1);
		}
		result = cast(string)(result[0..$-5] ~ "\n" ~ "}".indentBy(iLvl));
	}

//	foreach(eG;allGroups.getElementGroups) {
//		import std.algorithm;
//		import std.array;
//		if (!excludeGroups.canFind!((a,b)=> a is b)(eG)) {
//			result ~= eG.elements.map!(eG => ef(eG)).array.join;
//		}
//	}
	return result;
}
