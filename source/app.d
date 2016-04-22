//import sdc.terminal;
import std.conv;
import std.algorithm:map,sort;
import fancy_lexer;
import fancy_parser;
import sourceGenerators.d;
import fancy_analyzer;
import fancy_ast;
import std.zip;
import biginput;
import fancy_grammar_fpg;

static immutable _ag = cast(immutable) `Node {
		EnmGrp { 
			OptionOne { "option1" }
			OptionTwo { "option2" }
		}

		DlChrGrp {
			"'", char chr, "'"
		}

		RngGrp {
			[a-zA-Z] id
		}
	}`.lex.parse.analyze;

static immutable sag = cast(immutable) GrammerAnalyzer().analyze(`A {B { ? "a" : bool wasA, ? bool wasA : "b" } }`.lex.parse);
static immutable fpgp = fancyParsGrammar.lex.parse;
static immutable fpga = cast(immutable)fpgp.analyze;

static string lexer_blrplate_tail = `
	return result;
}`;

void main(string[] args) {

	import std.stdio;
	import std.file;
	import std.algorithm:filter;
	import std.exception;

	pragma(msg, fpga.genToken ~ fpga.genAST ~  fpga.genLex ~ fpga.genPars);
	mixin(fpga.genToken ~ fpga.genAST ~  fpga.genLex ~ fpga.genPars);
	
	import std.traits;
	if (args.length == 2) {

		enforce(args[1][$-4 .. $] == ".fpg", "files have to have the .fpg extention");
		string grammar = readText(args[1]);
		auto ag = grammar.lex.parse.analyze;

		string name = args[1][0 .. $-4];
		import std.path : baseName;
		string basename = baseName(name);

		File ast = File(name ~ "_ast.d","wb");
		File parser = File(name ~ "_parser.d","wb");
		File lexer = File(name ~ "_lexer.d","wb");
		File printer = File(name ~ "_printer.d","wb");
		File token = File(name ~ "_token.d","wb");

		token.writeln(ag.genToken());
		ast.writeln("import " ~ basename ~ "_token;\n" ~ ag.genAST);
		lexer.writeln("import " ~ basename ~ "_token;\n", lexer_blrplate_head, ag.genLex(), lexer_blrplate_tail);
		parser.writeln("import " ~ basename ~ "_token;\nimport " ~ basename ~ "_ast;\n", ag.genPars());
		printer.writeln("import " ~ basename ~ "_ast;\n", ag.genPrinter());

		foreach(e;ag.allElements.filter!(e => cast(AnonymousGroupElement)e)) {
			writeln(cast(PatternElement)e);
		}
	}
	
}
