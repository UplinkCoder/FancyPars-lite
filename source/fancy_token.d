struct Token {
	TokenType type;
	
	uint pos;
	uint line;
	uint col;
	uint length;
	
	const(char)[] data;
}
enum TokenType {
	TT_0, // INVALID

	TT_Identifier,
	TT_StringElement,
	TT_CharRange,

	TT_1, //  
	TT_2, // !
	TT_3, // "
	TT_4, // (
	TT_5, // )
	TT_6, // ,
	TT_7, // -
	TT_8, // /
	TT_9, // :
	TT_10, // ?
	TT_11, // ?lb
	TT_12, // @
	TT_13, // [
	TT_14, // []
	TT_15, // ]
	TT_16, // bool
	TT_17, // char
	TT_18, // {
	TT_19, // }
}
