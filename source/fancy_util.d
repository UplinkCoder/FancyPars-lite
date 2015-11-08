module fancy_util;
import std.traits;

auto assumePure(T)(T t)
	if (isFunctionPointer!T || isDelegate!T)
{
	enum attrs = functionAttributes!T | FunctionAttribute.pure_;
	return cast(SetFunctionAttributes!(T, functionLinkage!T, attrs)) t;
}

const(char)[] indentBy(const char[] str, const int indentLevel) pure {
	char[] indent;
	//indent.reserve(5);
	foreach(t;0..indentLevel) {
		 indent ~= "\t";
	}
	return indent ~ str;
}

auto unQual(T)(T t) {
	return cast(Unqual!T)t;
}