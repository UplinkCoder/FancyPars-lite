import fancy_ast;
import fancy_util;
import std.array;
string print(const Group root) pure {
	
	struct Printer {
	pure :
		Appender!(char[]) sink;
		uint iLvl;

		void print(const char c) {
			sink.put([c]);
		}

		

		void print(Identifier g) {
			foreach(_e;g.identifier) {
				print(_e);
			}
			sink.put(" ");
		}

		
		void print(Group g) {
			print(g.name);
			sink.put(" ");
			foreach (_a;g.annotations) {
				sink.put('@');
				print(_a);
				sink.put(" ");
			}
			sink.put("{\n\t");
			if (g.groups) {
				foreach(_e;g.groups) {
					print(_e);
				}
			}
			if (g.elements) {
				foreach(_e;g.elements) {
					print(_e);
					sink.put(", ");
				}

			}
			sink.put("\n}\n");
		}

		
		void print(AlternativeElement g) {
			foreach(_e;g.alternatives) {
				print(_e);
				sink.put("/");
			}
			sink.put(" ");
		}

		
		void print(NamedChar g) {
			sink.put("char");
			if (g.isArray) {
				sink.put("[]");
			}
			sink.put(" ");
			print(g.name);
		}

		
		void print(CharRange g) {
			print(g.rangeBegin);
			sink.put("-");
			print(g.rangeEnd);
		}

		
		void print(RangeElement g) {
			sink.put("[");
			foreach(_e;g.ranges) {
				print(_e);
			}
			sink.put("]");
			if (g.isArray) {
				sink.put("[]");
			}
			sink.put(" ");
			print(g.name);
		}

		
		void print(LookbehindElement g) {
			sink.put("?lb");
			sink.put(" ");
			sink.put("(");
			print(g.str);
			sink.put(")");
		}


		void print(StringElement g) {
			sink.put("\"");
			foreach(c;g.string_) {
				sink.put(c);
			}
			sink.put("\"");
		}
		
		void print(NotElement g) {
			sink.put("!");
			sink.put(" ");
			print(g.ce);
		}

		
		void print(ParenElement g) {
			sink.put("(");
			foreach(_e;g.elements) {
				print(_e);
				sink.put(",");
			}
			sink.put(")");
		}

		
		void print(NamedElement g) {
			print(g.type);
			if (g.isArray) {
				sink.put("[]");
			}
			sink.put(" ");
			print(g.name);
		}

		
		void print(FlagElement g) {
			sink.put("bool");
			sink.put(" ");
			print(g.flag_name);
			sink.put(" ");
		}

		
		void print(QueryElement g) {
			sink.put("?");
			sink.put(" ");
			sink.put("bool");
			sink.put(" ");
			print(g.flag_name);
			sink.put(" ");
			sink.put(":");
			sink.put(" ");
			print(g.elem);
		}

		
		void print(ConditionalElement g) {
			sink.put("?");
			sink.put(" ");
			foreach(_e;g.ce) {
				print(_e);
			}
			sink.put(" ");
			sink.put(":");
			sink.put(" ");
			print(g.elem);
		}

		
		void print(ASTNode p) {
			if(auto g = cast(Identifier)p) {
				return print(g);
			} else	if(auto g = cast(Group)p) {
				return print(g);
			} else	if(auto g = cast(PatternElement)p) {
				return print(g);
			}
		}

		void print(PatternElement p) {
			if(auto g = cast(AlternativeElement)p) {
				return print(g);
			} else	if(auto g = cast(LexerElement)p) {
				return print(g);
			} else	if(auto g = cast(ParenElement)p) {
				return print(g);
			} else	if(auto g = cast(NamedElement)p) {
				return print(g);
			} else	if(auto g = cast(FlagElement)p) {
				return print(g);
			} else	if(auto g = cast(QueryElement)p) {
				return print(g);
			} else	if(auto g = cast(ConditionalElement)p) {
				return print(g);
			}
		}

		void print(LexerElement p) {
			if(auto g = cast(NamedChar)p) {
				return print(g); 
			} else if(auto g = cast(StringElement)p) {
				return print(g);
			} else if(auto g = cast(CharRange)p) {
				return print(g);
			} else	if(auto g = cast(RangeElement)p) {
				return print(g);
			} else	if(auto g = cast(LookbehindElement)p) {
				return print(g);
			} else	if(auto g = cast(NotElement)p) {
				return print(g);
			}
		}
	}
	auto ptr = Printer();
	ptr.print(cast(Group)root);
	return cast(string)ptr.sink.data;
}

