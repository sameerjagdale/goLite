%{
#include<stdio.h>
%}

%%
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
[a-zA-z_][a-zA-z0-9_]* printf("ID %s\n",yytext);
[ \t\n]+ printf("Whitespace\n"); 
. ;
%%

int yywrap()
{
	return 1;
}

int main() {
	yylex();
}
