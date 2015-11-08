module sourceGenerators.d.common;
import fancy_ast;
import fancy_analyzer;
import std.conv;

string genDecl(const PatternElement element) pure {
	string result;
	if(!element.isASTMember) {
		return "\n/*+++ERROR+++\n*/\n";
	}
	
	return getType(element) ~ " " ~ getName(element) 
		~ ";\n";
	
	assert(0, "Wrong argument to genDecl " ~ to!string(typeid(element)));
	
}
