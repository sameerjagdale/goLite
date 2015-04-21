%{
#include<stdio.h>
#include<iostream>
int lineno = 1;
std::string str;
%}
%x STR_LITERAL
%x RAW_STR_LITERAL
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
fallthrough printf("fallthrough");
for printf("for");
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
[0-9]"."[0-9] printf("%s",yytext);
 /*Raw String*/
"`" {BEGIN(RAW_STR_LITERAL);}
<RAW_STR_LITERAL>"`" {BEGIN(INITIAL);printf("\"%s\"",str.c_str());}
<RAW_STR_LITERAL>\a {str+= "\\a";}
<RAW_STR_LITERAL>\t {str+= "\\t";}
<RAW_STR_LITERAL>\\t {str+= "\\\\t";}
<RAW_STR_LITERAL>\\f {str+= "\\\\"; str+="f";}
<RAW_STR_LITERAL>\\r {str+= "\\\\"; str+="r";}
<RAW_STR_LITERAL>\\b {str+= "\\\\"; str+="b";}
<RAW_STR_LITERAL>\\v {str+= "\\\\"; str+="v";}
<RAW_STR_LITERAL>"\\""n" {str+="\\\\n";}
<RAW_STR_LITERAL>\n {str += "\\n";}
\" {BEGIN(STR_LITERAL); str ="";}
<STR_LITERAL>\" { printf("\"%s\"",str.c_str()); BEGIN(INITIAL);}
<STR_LITERAL>"\\n" {str+="\\n";}
<STR_LITERAL>\n {printf("ERROR strings have to be on a single line\n");exit(0); }
<STR_LITERAL>(\\a|\a) {str+= "\\a";}
<STR_LITERAL>(\\t|"\t") {str+= "\\t";}
<STR_LITERAL>(\\f|\f) {str+= "\\f";}
<STR_LITERAL>(\\r|\r) {str+= "\\r";}
<STR_LITERAL>(\\b|\b) {str+= "\\b";}
<STR_LITERAL>(\\v|\v) {str+= "\\v";}
<STR_LITERAL>"\\" {str+= "\\";}
<STR_LITERAL>"\'" {str+= "\\"; str+="\'";}
<STR_LITERAL,RAW_STR_LITERAL><<EOF>> {printf("End of File\n"); exit(0);}
<STR_LITERAL,RAW_STR_LITERAL>. {str+=yytext;}
\'.\'  printf("%s", yytext); 
[a-zA-Z][a-zA-Z0-9]* printf("%s",yytext);
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
