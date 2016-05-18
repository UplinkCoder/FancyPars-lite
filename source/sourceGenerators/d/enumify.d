module sourceGenerators.d.enumify;
import fancy_ast;
import fancy_grammar_patterns;

// @enumify only works on parentGroups that have only ElementGroups that have no ASTMembers,
// and exactly one StringElement
// (the second limitation may be lifted)
// DONE
// eg EnmGrp @enumify { Option1 { "option1" } Option2 {"option2"} }
// this should translate to > enum EnmGrp { Option1, Option2 } 
// DONE
// the parsing for such things is diffrent
// EnmGrp parseEnmGrp { EnmGrp e; if (opt_match(TT.Option1)) {e = new EnumGroup(EnmGrpEnum.Option2) } else 
//      if(opt_match(TT.Option2)) {e = new EnumGroup(EnmGrpEnum.Option2) } return e; }
// this is still normal
// however the parseOption1 { match(TokenType.TT_Option1); return EnmGrp.Option1 }
// has a diffrent Return then before.
// DONE


//static unittest {	
	import fancy_parser;
	import fancy_lexer;
	import fancy_analyzer;

//}
