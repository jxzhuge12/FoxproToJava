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

"IF"			{ return new symbol(sym.IF); }
"ELSE"			{ return new symbol(sym.ELSE); }
"ENDIF"			{ return new symbol(sym.ENDIF); }
{IDE}			{ return new symbol(sym.IDE, yytext()); }
{RATI}			{ return new symbol(sym.RATIONAL, new Double(Double.parseDouble(yytext()))); }
{INT}			{ return new symbol(sym.INTCONST, new Integer(Integer.parseInt(yytext()))); }
">="			{ return new symbol(sym.GE); }
"<="			{ return new symbol(sym.LE); }
">"				{ return new symbol(sym.GT); }
"<"				{ return new symbol(sym.LT); }
"<>"			{ return new symbol(sym.UNEQ); }	
"="				{ return new symbol(sym.ASSIGN); }
"=="			{ return new symbol(sym.EQUAL); }		
"+"				{ return new symbol(sym.ADD); }
"-"				{ return new symbol(sym.MINUS); }
"*"				{ return new symbol(sym.MULTI); }
"/"				{ return new symbol(sym.DIV); }
\r\n|\n			{ ++yyline; }
[\ ]			{  }