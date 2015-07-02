import vibe.d;
import std.conv;
import std.algorithm:map,sort;
import fancy_lexer;
import fancy_parser;
import fancy_genAST;
import fancy_genPars;
import fancy_genLex;
import fancy_genPrinter;
import fancy_grammar;
import fancy_ast;
import std.zip;


static string lexer_blrplate_head = `
Token[] lex(in string source) pure {
	uint col;
	uint line;
	uint pos;
	Token[] result;

	char peek(int offset) {
		if (pos + offset > source.length - 1) return '\0';
		enforce(pos + offset <= source.length && pos + offset >= 0);
		return source[pos + offset];
	}

	void putToken(TokenType ttype, char[] data, uint offset=0) {

		uint length = offset ? offset : cast(uint) data.length;

		
		result ~= Token(ttype, pos, line, col, length, data);
		
		col += length;
		pos += length;
	}
`;

static string lexer_blrplate_tail = `
	return result;
}`;

void getIndex(HTTPServerRequest req, HTTPServerResponse res) {
	res.writeBody(`<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<title> FancyPras(e) </title> 
	</head>
	<body>
		<h1> Welcome to FancyPars </h1>
		<p> <a href="/generateParser"> generate Parser </a> </p>
	</body>
</html>`, "text/html");
}

void getGenerateParser(HTTPServerRequest req, HTTPServerResponse res) {
	res.writeBody(`<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html><head>  
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"> <title>fancyForm</title></head><body>
<form method="post" name="fancyForm" action="/generateParser" enctype="multipart/form-data">
  <p> <textarea cols="80" rows="25" name="grammar">ASTNode {
    Identifier @internal {
        [a-zA-Z_][] identifier
    }

    Group @parent {
        Identifier name, ? "@" : Identifier[] annotations : "@", "{",
            PatternElement[] elements : "," / Group[] groups,
             "}"
    }   

    PatternElement @internal {

        AlternativeElement @noFirst {
            PatternElement[] alternatives : "/"
        }

        LexerElement {

            StringElement {
                "\"", char[] string_, "\""
            }

            NamedChar {
                "char", ? "[]" : bool isArray, Identifier name
            }

            CharRange @internal {
                char rangeBegin,  ? "-" : char RangeEnd
            }

            RangeElement {
                "[", CharRange[] ranges, "]"
            }

            LookbehindElement {
                "?lb", "(", StringElement str, ")"
            }

            NotElement {
                "!", LexerElement ce
            }

        }

        NamedElement {
            Identifier type,  ? "[]" : bool isArray, Identifier name, 
            ? bool isArray : ? ":" : StringElement lst_sep
        }

        ParenElement {
            "(", PatternElement[] elements : ",", ")" 
        }

        FlagElement {
            "bool", Identifier flag_name
        }

        QueryElement {
            "?", "bool", Identifier flag_name, ":", PatternElement elem
        }

        OptionalElement {
            "?", LexerElement[] ce : ",", ":", PatternElement elem
        }

    }
}

</textarea> </p>
 <p> <input value="Generate AST" type="submit"> </p>
</form>
</body></html>`,"text/html");
}

void postGenerateParser(HTTPServerRequest req, HTTPServerResponse res) {
	import std.stdio;
	auto allGroups = req.form["grammar"].lex.parse.getAllGroups;
	auto zipdl = new ZipArchive;
//	foreach(i,n;["ast.d","lexer.d","parser.d","printer.d"]) {
//		ArchiveMember member() = new ArchiveMember();
//		zipdl.addMember()
//	}
	res.writeBody("\n/***AST***/\n" ~ allGroups.genAST 
		~ "\n/***Token***/\n" ~ allGroups.genTokenTypeEnum 

		~ "\n/***Lexer***/\n" ~ lexer_blrplate_head 
		~ allGroups.genLex ~ lexer_blrplate_tail 

		~ "\n/***Parser***/\n" ~ allGroups.genPars

		~ "\n/***Printer***/\n" ~ allGroups.genPrinter);
	res.writeBody(serializeToJson(allGroups).toPrettyString);
}

shared static this()
{
	auto router = new URLRouter;
	router.get("/",&getIndex);
	router.get("/generateParser",&getGenerateParser);
	router.post("/generateParser",&postGenerateParser);


	router.get("*", serveStaticFiles("public/"));
	auto settings = new HTTPServerSettings;
	//settings.bindAddresses = ["::1", "127.0.0.1"];
	settings.sessionStore = new MemorySessionStore();
	settings.port = 8080;
	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}




void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}
