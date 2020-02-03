enum grammer = `
RootNode
{
    Desc @parent {
	    ? "FromInput" : ( "{", Parameter[] parameterList : ";", "}" ),
		    Statement[] staements;
    }
	Parameter @internal {
		Identifier name, ":", Type type
	}
	
	Identifier @internal {
		[a-zA-Z] identifer;
	}
	
	Type @internal {
		"string" / "int32"
	}
	Statement @internal
	{
		IfStatement
		{
			"if", "(", Expression expr, ")", Statement stmt
		}
		BlockStatement
		{
			"{", Statement[] statement : ";", "}"
		} 
		AddToBodyStatement
		{
			"addToBody", "(", { "\"", char[] fstring, "\""}, ? "," : ( Identifier[] vars : "," ), ")"
		}
			
	}
	
}
`;

enum ExampleCode = `
	FormInput
	{
		name : string;
		age : int32
	}
	if (age is null) { addToBody("FormInput age is expected"); }
	if (age not in  0 .. 99)
	{
		addToBody("age: %d is not in the range from 0 to 99< br/>", age);
	}
`;
