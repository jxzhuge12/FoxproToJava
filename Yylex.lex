package translator;

import java_cup.runtime.Symbol;
import java.io.FileInputStream;
import java.io.InputStream;

%%
%cup
%line

%{
	public static void main(String args[]) throws Exception {
		InputStream is = new FileInputStream(args[0]);
		Yylex lexer = new Yylex(is);

		Symbol token = null;
		do {
			token = lexer.next_token();
			System.out.println(token == null ? "EOF" : token.toString());
		} while (token != null);
	}
	
	private int countLines(String str){
		int count = 0;
		for(int i = 0; i < str.length(); ++i){
			if(str.charAt(i) == '\n'){
				++count;
			}
		}
		return count;
	}
%}

DIGIT = [0-9]
INT = {DIGIT}+
LETTER = [a-zA-Z_]+
IDE = {LETTER}({LETTER}|{DIGIT})*
IF = [Ii][Ff]
ENDIF = [Ee][Nn][Dd][Ii][Ff]


%%

"IF"			{ return new Symbol(sym.IF); }
"ENDIF"			{ return new Symbol(sym.ENDIF); }
"+"				{ return new Symbol(sym.ADD); }
"-"				{ return new Symbol(sym.MINUS); }
"*"				{ return new Symbol(sym.PLUS); }
"/"				{ return new Symbol(sym.DIV); }
"{"				{ return new Symbol(sym.LC); }
"}"				{ return new Symbol(sym.RC); }
"("				{ return new Symbol(sym.LPAR); }
")"				{ return new Symbol(sym.RPAR); }
{IDE}			{ return new Symbol(sym.IDE, yytext()); }
{INT}			{ return new Symbol(sym.INTCONST, new Integer(Integer.parseInt(yytext()))); }
[\n]			{ ++yyline; }
[\r\t\f\ ]+		{    }
.				{ System.err.println("unexpected char " + yytext() + " !\n"); System.exit(0); }