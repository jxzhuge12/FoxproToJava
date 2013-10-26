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
INT = {DIGIT}+|\-{DIGIT}+
RATI = {DIGIT}+\.{DIGIT}+|\-{DIGIT}+\.{DIGIT}+
LETTER = [a-zA-Z_]+
IDE = {LETTER}({LETTER}|{DIGIT})*
IF = [Ii][Ff]
ELSE = [Ee][Ll][Ss][Ee]
ENDIF = [Ee][Nn][Dd][Ii][Ff]


%%

"IF"			{ System.out.println("sym.IF"); }
"ELSE"			{ System.out.println("sym.ELSE"); }
"ENDIF"			{ System.out.println("sym.ENDIF"); }
{IDE}			{ System.out.println("sym.IDE, yytext()"); }
{RATI}			{ System.out.println("sym.RATIONAL, new Double(Double.parseDouble(yytext()))"); }
{INT}			{ System.out.println("sym.INTCONST, new Integer(Integer.parseInt(yytext()))"); }
">="			{ System.out.println("sym.GE"); }
"<="			{ System.out.println("sym.LE"); }
">"				{ System.out.println("sym.GT"); }
"<"				{ System.out.println("sym.LT"); }
"<>"			{ System.out.println("sym.UNEQ"); }	
"="				{ System.out.println("sym.EQUAL"); }	
"+"				{ System.out.println("sym.ADD"); }
"-"				{ System.out.println("sym.MINUS"); }
"*"				{ System.out.println("sym.MULTI"); }
"/"				{ System.out.println("sym.DIV"); }
"{"				{ System.out.println("sym.LC"); }
"}"				{ System.out.println("sym.RC"); }
"("				{ System.out.println("sym.LPAR"); }
")"				{ System.out.println("sym.RPAR"); }
\r\n|\n			{ ++yyline; }
[\ ]			{  }