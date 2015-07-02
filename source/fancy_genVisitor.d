module fancy_genVisitor;

import fancy_ast;
import fancy_grammar;
import fancy_util;

string genVisitor(const (Group)[] allGroups, const char[] retType = "void", const char[] funcName = "visit", uint iLvl=0) pure {
	string result;

	foreach(pG;allGroups.getParentGroups) {
		result ~= "\n\n" ~ retType.indentBy(iLvl) ~ " " ~ funcName ~"(" ~ pG.name.identifier ~ " _p) {\n"
			~ "".indentBy(iLvl+1);
		foreach (eG;pG.groups) {
			result ~= "if(auto _g = cast(" ~ eG.name.identifier ~ ") _p) {\n"
				~ "return ".indentBy(iLvl+2) ~ funcName ~"(_g);" ~ "\n" ~ "} else ".indentBy(iLvl+1);
		}
		result = cast(string)(result[0..$-5] ~ "\n" ~ "}".indentBy(iLvl));
	}
	return result;
}