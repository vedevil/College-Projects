%{
#include<stdio.h>
#include<string.h>
%}

%token <sval> FIELD
%token <sval> LITERAL
%token <sval> MAIN
%token <sval> KEYWORD
%token <sval> FUNCTION
%token <sval> VARIABLE
%token <sval> ID
%token <sval> FILENAME
%token <sval> RELOP
%token <sval> OPERATORS
%token <ival> INTEGER
%token <sval> PARENTHESIS
%token <sval> SYMBOL
%token <fval> FLOAT
%token <ival> EOL
%token <sval> BRACES

%start exp

%union{
	char* sval;
	int ival;
	float fval;
}
%%
exp: 
|MAIN SYMBOL pattern BRACES action BRACES SYMBOL files EOL {}
   ;

files:
|files FILENAME
;
pattern:
|FIELD RELOP INTEGER {}
       ;
action:
|pexp
;
pexp:KEYWORD argument {int c; c=strcmp( $1,"print"); if(c!=0){yyerror();}}
;
argument:
|operations
;
operations:
|f
|f OPERATORS f
|operations SYMBOL multiplef 
;
multiplef:f
|f OPERATORS f
;
f:FIELD
|VARIABLE {int c1;
c1=strcmp($1,"NF");
int c2;
c2=strcmp($1,"NR");
if(c1 != 0 && c2 !=0)
{yyerror();}}
;
 

%%

int main(){
yyparse();
return 0;
}
yyerror(char* s){
fprintf(stderr,"Error:%s\n",s);
}
