module sourceGenerators.dalt.genAST;
import sourceGenerators.d.common;
import fancy_ast;
import fancy_analyzer;
import fancy_grammar_patterns;
import fancy_util;
import std.string : toLower;
import std.algorithm : filter;

pure:
static immutable locationString = q{
struct MyLocation {
	uint line;
	uint col;
	uint index;
	uint length;
		
	this(const Token first, const Token last) pure {
		line = first.line;
		col = first.col;
		index = first.pos;
		length = (first.pos - last.pos) + last.length;
	}
}
};

string enumify(const EnumifiableGroup_ g) {
	auto gid = g.name.identifier;
	auto lgid = (cast(char) gid[0].toLower) ~ gid[1 .. $];
	string result = "enum " ~ gid ~ "Enum {\n";

	foreach (enumEntry; g.enumEntries) {
		result ~= "\t" ~ enumEntry.enumName.identifier ~ ",\n";
	}

	result ~= "}\n\n";

	result ~= "struct " ~ gid ~ " {\n\t" ~ gid ~ "Enum " ~ lgid ~ ";\n\t" ~ "alias " ~ lgid ~ " this;\n\n";

	result ~= "\tthis(" ~ gid ~ "Enum " ~ lgid ~ ") pure {" ~ "\n\t\t" ~ "this." ~ lgid ~ " = " ~ lgid ~ ";" ~ "\n\t}\n}\n\n";

	return result;
}

import std.format;

private string typeEnum(const Group group) {
	string result;
	result = format("enum %sType {\n", group.name.identifier);

	foreach (g; group.groups) {
		result ~= format("\t%s,\n", g.name.identifier);
	}

	result ~= "}\n";
	
	return result;
}

private auto beginStruct(const Group group) {
	return format(`struct %s {
	MyLocation loc;
	`, group.name.identifier);
}

private auto endStruct() {
	return "\n}";
}

private auto lowerFrist(const(char)[] chars) {
	import std.ascii : toLower;

	return chars[0].toLower ~ chars[1 .. $];
}

private string parentGroupNode(const Group group, const AnalyzedGrammar ag, const Group parent = null) {

	auto constructor(const Group child) {
		string result;
		return format(q{

	this(%s* %s) pure {
		_type = %sType.%s;
		this.%s = %s;
	}
},		child.name.identifier, child.name.identifier.lowerFrist,
		group.name.identifier, child.name.identifier,
		child.name.identifier.lowerFrist, child.name.identifier.lowerFrist
		);
	}

	string result;
	string constructors;
	string tail;

	assert(group.hasGroups);

	result ~= typeEnum(group);
	result ~= "\n";
	result ~= beginStruct(group);

	result ~= format("%sType _type;\n", group.name.identifier);

	if (parent) {
		result ~= format("\n\t%s* _parent;\n", parent.name.identifier);
	}

	result ~= "\n\tunion {\n\t\t";

	foreach (g; group.groups) {
		result ~= format("%s* %s;\n\t\t", g.name.identifier, g.name.identifier.lowerFrist);

		constructors ~= constructor(g);

		if (g.hasGroups) {
			if (auto eg = EnumifiableGroup(g)) {
				tail ~= enumify(*eg);
			} else {
				tail ~= parentGroupNode(g, ag, group) ~ "\n";
			}
		} else {
			tail ~= elementGroupNode(g, ag, group) ~ "\n";
		}
	}

	result ~= "\n\t}";

	result ~= constructors ~ endStruct ~ tail;

	return result;
}

private string elementGroupNode(const Group group, const AnalyzedGrammar ag, const Group parent) {
	string result;

	result ~= beginStruct(group);

	if (parent) {
		result ~= format("\n\t%s* _parent;\n", parent.name.identifier);
	} else {
		assert(0, "ElementGroups must have a parent");
	}

	auto astMembers = ag.astMembers(group);
	import std.array : empty;
	if (!astMembers.empty) {
		result ~= "\n";

		foreach (el; astMembers) {
			result ~= genDecl(el).indentBy(1);
		}

		result ~= "\n\tthis(";
		foreach (el; astMembers) {
			result ~= format("%s %s, ", getType(el), getName(el));
		}
		
		result = result[0 .. $ - 2] ~ ") pure {\n";
		
		foreach (el; astMembers) {
			result ~= format("\t\tthis.%s = %s;\n", getName(el), getName(el));
		}

		result ~= "\t}\n";

	}

	result ~= endStruct();
	
	return result;
}

string genAST(const GrammerAnalyzer.AnalyzedGrammar ag) {
	string result = locationString ~ "\n";
	auto rootGroup = ag.allGroups[0];

	result ~= parentGroupNode(rootGroup, ag, null);

	return result;
}
