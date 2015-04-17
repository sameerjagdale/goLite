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
break printf("break\n");
case printf("case\n");
chan printf("chan\n");
const printf("const\n");
continue printf("continue\n");
default printf("default\n");
defer printf("defer\n");
else printf("else\n");
fallthrough printf("for\n");
func printf("func\n");
go printf("go\n");
goto printf("goto\n");
if printf("if\n");
import printf("import\n");
interface printf("interface\n");
map printf("map\n");
package printf("package\n");
range printf("range\n");
return printf("return\n");
select printf("select\n");
struct printf("struct\n");
switch printf("switch\n");
type printf("type\n");
var printf("var\n");
int printf("int\n");
float64 printf("float64");
bool printf("bool\n");
rune printf("rune \n");
string printf("string\n");
print printf("print\n");
println printf("println\n");
append printf("append\n");
 /* operators */
"+" printf("plus\n");
"-" printf("minus\n");
"*" printf("mult\n");
"/" printf("div\n");
"%" printf("modulo\n");
"|" printf("bitwise or\n");
"^" printf("bitwise xor\n");
"<<" printf("left shift\n");
">>" printf("right shift\n");
"&^" printf("bit clear (AND NOT)");
"+=" printf("plus equals\n");
"-=" printf("minus equals\n");
"*=" printf("mult equals\n");
"/=" printf("div equals\n");
"%=" printf("modulo equals\n");
"&=" printf("and equals\n");
"|=" printf("or equals\n");
"^=" printf("xor equals\n");
"<<=" printf("left shift equals\n");
">>=" printf("right shift equals\n");
"&^=" printf("and not equals\n");
"&&" printf("short circuit and\n");
"||" printf("short circuit or\n");
"<-" printf("left arrow\n");
"++" printf("increment\n");
"--" printf("decrement\n");
"==" printf("equals\n");
"<" printf("less than\n");
">" printf("greater than\n");
"=" printf("assignment\n");
"!" printf("not\n");
"!=" printf("not equals\n");
"<=" printf("less than equals\n");
">=" printf("greater than equals\n");
":=" printf("short assignment\n");
"..." printf("ellipsis\n");
"(" printf("left paren\n");
")" printf("right paren\n");
"[" printf("left box bracket\n");
"]" printf("right box bracket\n");
"{" printf("left brace\n");
"}" printf("right brace\n");
"," printf("comma\n");
"." printf("period\n");
";" printf("semicolon\n");
":" printf("colon\n");
[a-zA-z_][a-zA-z0-9_]* printf("ID %s\n",yytext);
[ \t]+ printf("Whitespace\n"); 
"\n" {printf("new line %d\n",lineno); lineno++;}
. ;
%%

int yywrap()
{
	return 1;
}

int main() {
	yylex();
}
