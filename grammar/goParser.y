%{
#include <stdio.h>
#include <stdlib.h>
#include<iostream>


extern char *yytext;
extern int yylineno;
extern FILE* yyin;
extern std::string str;
extern int yylex();
void yyerror(char const *s) { fprintf(stderr, "Error: (line %d) %s\n", yylineno, s); }
%}
%token tBREAK tCASE tCHAN tCONST tCONTINUE tDEFAULT tDEFER tELSE tFALLTHROUGH tFOR tFUNC tGO tGOTO tIF tIMPORT tINTERFACE tMAP tPACKAGE tRANGE tRETURN tSELECT tSTRUCT tSWITCH tTYPE tVAR
%token tINT tFLOAT tBOOL tRUNE tSTRING tPRINT tPRINTLN tAPPEND
%token tINTCONST tFLOATCONST tSTRINGCONST tRUNECONST tIDENTIFIER tRAWSTRINGCONST

%token tUNOP tRELOP tADDOP tMULOP  
%token '+' '-' '*' '/' '%'
%token '&' '|' '^' tSHL tSHR tANDNOT
%token tADDASSIGN tSUBASSIGN tMULASSIGN tDIVASSIGN tREMASSIGN
%token tANDASSIGN tORASSIGN tXORASSIGN tSHLASSIGN tSHRASSIGN tANDNOTASSIGN
%token tLAND tLOR tARROW tINC tDEC
%token tEQUALS '<' '>' '=' tBANG
%token tNEQ tLEQ tGEQ tDEFINE tELLIPSIS
%token '(' ')' '[' ']' '{' '}' ';' ':' ',' '.'
%left tLOR
%left tLAND
%left tRELOP tEQUALS tNEQ '<' '>' tLEQ tGEQ
%left tADDOP '+' '-' '|' '^'
%left tMULOP '*' '/' '%' tSHL tSHR '&' tANDNOT
%left tUNOP

%error-verbose
%locations
%%
PROGRAM: PACKAGECLAUSE ';' TOPLEVELDECLLIST ;
PACKAGECLAUSE: tPACKAGE tIDENTIFIER
TOPLEVELDECLLIST : | TOPLEVELDECL TOPLEVELDECLLIST ;
TOPLEVELDECL: DECL;
DECL: VARDECL;
VARDECL : tVAR VARSPEC;
VARSPEC : /*IDENTIFIERLIST TYPE '=' EXPRESSIONLIST | 
		IDENTIFIERLIST '=' EXPRESSIONLIST | */
		IDENTIFIERLIST TYPE ;
IDENTIFIERLIST: | IDENTIFIERLIST tIDENTIFIER;
TYPE: BASICTYPE | SLICETYPE | ARRAYTYPE;
BASICTYPE: tINT| tRUNE|tFLOAT| tBOOL | tSTRING;
SLICETYPE: '[' ']' TYPE;
ARRAYTYPE: '[' tINTCONST ']' TYPE;
%%
int main(int argc, char* argv[]) {
	yyin = fopen(argv[1], "r");	
	yyparse();
}
