module fancy_util;
import std.traits;
import std.string;

auto assumePure(T)(T t)
	if (isFunctionPointer!T || isDelegate!T)
{
	enum attrs = functionAttributes!T | FunctionAttribute.pure_;
	return cast(SetFunctionAttributes!(T, functionLinkage!T, attrs)) t;
}

version (opt) {
const(char)[] indentBy(const char[] str, const int indentLevel) pure {
	char[] result;
	result.length = (indentLevel + str.length);

	import core.stdc.string : memcpy, memset;

	memset(result.ptr, '\t', indentLevel);
	memcpy(result.ptr + indentLevel, str.ptr, str.length);
	
	return result;
	}
} else {
	const(char)[] indentBy(const char[] str, const int indentLevel) pure {
		const(char)[] result;
		
		if (!__ctfe) {
			result.reserve(indentLevel + str.length);
		}
		
		
		foreach(t;0..indentLevel) {
			result ~= "\t"; // should be a memset
		}
		
		result ~= str; // should be a call to memcpy
		
		return result;
	}
}


const(char)[] indentBlockBy(const char[] str, const int indentLevel) pure {
	const(char)[] indent;
	const(char)[] result;

	if (!__ctfe) {
		indent.reserve(indentLevel);
		result.reserve(str.length + indentLevel * 8);
	}

	foreach(t;0..indentLevel) {
		indent ~= "\t";
	}

	foreach(line;str.splitLines) {
		result ~= indent ~ line;
	}

	return result;
}


auto unQual(T)(T t) {
	return cast(Unqual!T)t;
}