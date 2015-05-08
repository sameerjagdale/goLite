%{
#include <stdio.h>
#include <stdlib.h>
#include<iostream>


extern char *yytext;
extern int yylineno;
extern FILE* yyin;
extern std::string str;
extern int yylex();
void yyerror(char const *s) {fprintf(stderr, "Error: (line %d) %s\n", yylineno, s); }
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
TOPLEVELDECL: DECL|FUNCDECL;
DECL: VARDECL|TYPEDECL;
FUNCDECL: tFUNC FUNCNAME FUNCTION | tFUNC FUNCNAME SIGN
FUNCNAME : tIDENTIFIER
FUNCTION : SIGN FUNCBODY
FUNCBODY: BLOCK
BLOCK:  BLOCKWOSEMI ';'
BLOCKWOSEMI:'{' STMTLIST '}' 
SIGN : PARAMS | PARAMS RESULT
RESULT : TYPE
PARAMS: '(' PARAMLIST ')' | '(' ')' 
PARAMLIST : PARAMLIST ',' PARAM  | PARAM
PARAM:  IDENTIFIERLIST TYPE  
VARDECL : tVAR VARSPEC ';'
			| tVAR '(' VARSPECLIST ')'';';
TYPEDECL: tTYPE TYPESPEC ';' | tTYPE '(' TYPESPECLIST ')' ';'
TYPESPECLIST:  TYPESPECLIST TYPESPEC ';'|;
TYPESPEC: tIDENTIFIER TYPE;
VARSPECLIST:  |VARSPECLIST VARSPEC ';'
VARSPEC : IDENTIFIERLIST TYPE '=' OPERAND |  
			IDENTIFIERLIST TYPE ;
IDENTIFIERLIST: tIDENTIFIER| IDENTIFIERLIST ',' tIDENTIFIER;
TYPE: BASICTYPE | SLICETYPE | ARRAYTYPE|STRUCTTYPE; 
BASICTYPE: tINT| tRUNE|tFLOAT| tBOOL | tSTRING;
SLICETYPE: '[' ']' TYPE;
ARRAYTYPE: '[' tINTCONST ']' TYPE;
STRUCTTYPE: tSTRUCT '{' FIELDDECLLIST '}' 
FIELDDECLLIST: FIELDDECLLIST FIELDDECL ';' |
FIELDDECL: IDENTIFIERLIST TYPE
/* Statements*/
STMTLIST:/*empty*/ |STMTLIST STMT
STMT : ';' | EXPRSTMT; 
EXPRSTMT: EXPR ';'
 /* Expressions */ 
EXPRLIST : EXPR | EXPRLIST ',' EXPR 
OPERAND: '(' EXPR ')' |
		OPERANDNAME|
		LITERAL;
OPERANDNAME: tIDENTIFIER
LITERAL: tFLOATCONST | tRUNECONST | tINTCONST | tSTRINGCONST | tRAWSTRINGCONST;
EXPR: PRIMARYEXPR |
	  EXPR '*' EXPR |
	  EXPR '/' EXPR |
	  EXPR '-' EXPR | 
	  EXPR '+' EXPR | 
	  FUNCALLEXPR |
	  UNOP EXPR %prec tUNOP 
UNOP : '+' | '-' | tBANG | '^'
FUNCALLEXPR: tIDENTIFIER '(' EXPRLIST ')'
PRIMARYEXPR : OPERAND 
			 |CONVERSION
			 | PRIMARYEXPR SELECTOR 
			 |PRIMARYEXPR INDEX
			 |PRIMARYEXPR SLICE
SELECTOR : '.' tIDENTIFIER
CONVERSION : TYPE '(' EXPR ')'
INDEX : '[' EXPR ']'
SLICE : '[' EXPR ':' EXPR ']'
		| '[' ':' EXPR ']'
		| '[' EXPR ':' ']'
		| '[' ':' ']'
		| '[' EXPR ':' EXPR ':' EXPR ']'
		| '[' ':' EXPR ':' EXPR ']'  
%%

