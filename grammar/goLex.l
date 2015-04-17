%{
#include<stdio.h>
int lineno = 1;
%}
%x C_COMMENT
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
break printf("break");
case printf("case");
chan printf("chan");
const printf("const");
continue printf("continue");
default printf("default");
defer printf("defer");
else printf("else");
fallthrough printf("for");
func printf("func");
go printf("go");
goto printf("goto");
if printf("if");
import printf("import");
interface printf("interface");
map printf("map");
package printf("package");
range printf("range");
return printf("return");
select printf("select");
struct printf("struct");
switch printf("switch");
type printf("type");
var printf("var");
int printf("int");
float64 printf("float64");
bool printf("bool");
rune printf("rune ");
string printf("string");
print printf("print");
println printf("println");
append printf("append");
 /* operators */
"+" printf("+");
"-" printf("-");
"*" printf("*");
"/" printf("/");
"%" printf("%");
"|" printf("|");
"^" printf("^");
"<<" printf("<<");
">>" printf(">>");
"&^" printf("&^");
"+=" printf("+=");
"-=" printf("-=");
"*=" printf("*=");
"/=" printf("/=");
"%=" printf("%=");
"&=" printf("&=");
"|=" printf("|=");
"^=" printf("^=");
"<<=" printf("<<=");
">>=" printf(">>=");
"&^=" printf("&^=");
"&&" printf("&&");
"||" printf("||");
"<-" printf("<-");
"++" printf("++");
"--" printf("--");
"==" printf("==");
"<" printf("<");
">" printf(">");
"=" printf("=");
"!" printf("!");
"!=" printf("!=");
"<=" printf("<=");
">=" printf(">=");
":=" printf(":=");
"..." printf("...");
"(" printf("(");
")" printf(")");
"[" printf("[");
"]" printf("]");
"{" printf("{");
"}" printf("}");
"," printf(",");
"." printf(".");
";" printf(";");
":" printf(":");
 /* Literals */
[0-9]+ printf("%s",yytext);
[0-9]"."[0-9]
[a-zA-z_][a-zA-z0-9_]* printf("ID %s",yytext);
[ \t]+ printf("%s",yytext); 
"\n" {printf("\n"); lineno++;}
. ;
%%

int yywrap()
{
	return 1;
}

int main(int argc, char*argv[]) {
	yyin = fopen(argv[1], "r");	
	yylex();
	return 0;
}
