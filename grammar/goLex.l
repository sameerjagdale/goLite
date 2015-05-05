%{
#include<stdio.h>
#include<iostream>
#include<goParser.hpp>
std::string str;
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
int lastToken=0;
int saveAndReturn(int token) {
	lastToken = token;
	return token;
}
	
void copyToStr() {
	int i = 0;
	str = "";
	while(yytext[i] != '\0') {
		switch(yytext[i]) {
			case '\n' : 
				str +="\\n";
				break;
			case '\t' :
				str += "\\t";
				break;
			case '\a':
			case '\v':
			case '\f':
			case '\r':
				str += "\\a";
				break;
			case '\\' : 
				str += "\\\\";
				str += yytext[++i];
				break;
			default: 
				str += yytext[i];
				break;
			
		}
		i++;
	}
}
/* Function checks whether to insert a semicolon depending on last token. */
bool insertSemicolon() {
	return lastToken == tIDENTIFIER ||
	lastToken == tCONST || 
	lastToken == tINTCONST || 
	lastToken == tFLOATCONST ||
	lastToken == tRUNECONST ||
	lastToken == tFALLTHROUGH ||
	lastToken == tINC ||
	lastToken == tDEC ||
	lastToken == ')' ||
	lastToken == ']' ||
	lastToken == '}' ||
	lastToken == tRETURN|| 
	lastToken == tBREAK|| 
	lastToken == tCONTINUE;
}
%}
%x C_COMMENT
DIGIT [0-9]
OCTAL [0-7]
HEX [0-9A-Fa-f]
LETTER [A-Za-z_]
%option noinput
%option nounput
%option yylineno
%%
 /* comments */ 
 /* multi line comments*/
"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT><<EOF>> {printf("End of File reached\n"); exit(1);}
<C_COMMENT>.    { }
 /* single line comment*/
"//"[^\r\n]*[\r\n<<EOF>>] printf("comment %s\n",yytext +sizeof(char)*2);
 /* keywords */
break return saveAndReturn(tBREAK);
case return saveAndReturn(tCASE);
chan return saveAndReturn(tCHAN);
const return saveAndReturn(tCONST);
continue return saveAndReturn(tCONTINUE);
default return saveAndReturn(tDEFAULT);
defer return saveAndReturn(tDEFER);
else return saveAndReturn(tELSE);
fallthrough return saveAndReturn(tFALLTHROUGH);
for return saveAndReturn(tFOR);
func return saveAndReturn(tFUNC);
go return saveAndReturn(tGO);
goto return saveAndReturn(tGOTO);
if return saveAndReturn(tIF);
import return saveAndReturn(tIMPORT);
interface return saveAndReturn(tINTERFACE);
map return saveAndReturn(tMAP);
package return saveAndReturn(tPACKAGE);
range return saveAndReturn(tRANGE);
return return saveAndReturn(tRETURN);
select return saveAndReturn(tSELECT);
struct return saveAndReturn(tSTRUCT);
switch return saveAndReturn(tSWITCH);
type return saveAndReturn(tTYPE);
var return saveAndReturn(tVAR);
int return saveAndReturn(tINT);
float64 return saveAndReturn(tFLOAT);
bool return saveAndReturn(tBOOL);
rune return saveAndReturn(tRUNE);
string return saveAndReturn(tSTRING);
print return saveAndReturn(tPRINT);
println return saveAndReturn(tPRINTLN);
append return saveAndReturn(tAPPEND);
 /* operators */
"+" return saveAndReturn('+');
"-" return saveAndReturn('-');
"*" return saveAndReturn('*');
"/" return saveAndReturn('/');
"%" return saveAndReturn('%');
"|" return saveAndReturn('|');
"^" return saveAndReturn('^');
"<<" return saveAndReturn(tSHL);
">>" return saveAndReturn(tSHR);
"&^" return saveAndReturn(tANDNOT);
"+=" return saveAndReturn(tADDASSIGN);
"-=" return saveAndReturn(tSUBASSIGN);
"*=" return saveAndReturn(tMULASSIGN);
"/=" return saveAndReturn(tDIVASSIGN);
"%=" return saveAndReturn(tREMASSIGN);
"&=" return saveAndReturn(tANDASSIGN);
"|=" return saveAndReturn(tORASSIGN);
"^=" return saveAndReturn(tXORASSIGN);
"<<=" return saveAndReturn(tSHLASSIGN);
">>=" return saveAndReturn(tSHRASSIGN);
"&^=" return saveAndReturn(tANDNOTASSIGN);
"&&" return saveAndReturn(tLAND);
"||" return saveAndReturn(tLOR);
"<-" return saveAndReturn(tARROW);
"++" return saveAndReturn(tINC);
"--" return saveAndReturn(tDEC);
"==" return saveAndReturn(tEQUALS);
"<" return saveAndReturn('<');
">" return saveAndReturn('>');
"=" return saveAndReturn('=');
"!" return saveAndReturn(tBANG);
"!=" return saveAndReturn(tNEQ);
"<=" return saveAndReturn(tLEQ);
">=" return saveAndReturn(tGEQ);
":=" return saveAndReturn(tDEFINE);
"..." return saveAndReturn(tELLIPSIS);
"(" return saveAndReturn('(');
")" return saveAndReturn(')');
"[" return saveAndReturn('[');
"]" return saveAndReturn('[');
"{" return saveAndReturn('{');
"}" return saveAndReturn('}');
"," return saveAndReturn(',');
"." return saveAndReturn('.');
";" return saveAndReturn(';');
":" return saveAndReturn(':');
 /* Literals */
((0{OCTAL})|(0(x|X){HEX})|(0|[1-9]+)) return saveAndReturn(tINTCONST);
DIGIT"."DIGIT return saveAndReturn(tFLOATCONST);

 /*Raw String*/
`(\\.|[^`])*` {copyToStr(); return saveAndReturn(tRAWSTRINGCONST);}
 /* Interpreted string */
\"(\\.|[^\\"])*\" {return saveAndReturn(tSTRINGCONST);}
\'.\'  return saveAndReturn(tRUNECONST); 
LETTER(LETTER|DIGIT)* return saveAndReturn(tIDENTIFIER);
[ \t]+ ; 
\n return saveAndReturn(';');
. ;
%%

int yywrap()
{
	return 1;
}

/* int main(int argc, char*argv[]) { */
/* 	yyin = fopen(argv[1], "r"); */	
/* 	yylex(); */
/* 	return 0; */
/* } */
