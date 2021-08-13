%{
#include<stdio.h>
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
%token <sval> BUILTIN 
%token <sval> SC 
%token <sval> NL
%token <sval> COMMA 
%token <sval> RP 
%token <sval> LP
%token <sval> IF 
%token <sval> THEN
%token <sval> LE
%token <sval> GE
%token <sval> EQ
%token <sval> NE
%token <sval> OR
%token <sval> AND
%token <sval> ELSE
%token <sval> FOR
%left '+' '-'                                           
%left '*' '/'
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%right UMINUS
%left '!'

%start exp

%union{
	char* sval;
	int ival;
	float fval;
}
%%



expr:|SU
     |SS 
     |S
     |start
     |var
     |expr '+' expr                                        
     |expr '-' expr
     |expr '*' expr
     |expr '/' expr
     |'-'INTEGER
     |'-'ID
     |'('expr')'
     |INTEGER
     |ID
     |FLOAT	
     ;


start:BUILTIN varlist SC NL 
|
varlist:varlist COMMA ID|ID;


var:datatype varlis LP FUNCT RP SC NL 
|
datatype: BUILTIN;
|
varlis: ID;
|
FUNCT: FUNCT COMMA ID|FUNCT COMMA BUILTIN|BUILTIN|ID;




S      : ST 
ST    : IF '(' E2 ')' THEN ST1';' ELSE ST1';'
        | IF '(' E2 ')' THEN ST1';'
        ;
ST1  : ST
        | E
        ;
E    : ID'='E
      | E'+'E
      | E'-'E
      | E'*'E
      | E'/'E
      | E'<'E
      | E'>'E
      | E LE E
      | E GE E
      | E EQ E
      | E NE E
      | E OR E
      | E AND E
      | ID
      | INTEGER
      ;
E2  : E'<'E
      | E'>'E
      | E LE E
      | E GE E
      | E EQ E
      | E NE E
      | E OR E
      | E AND E
      | ID
      | INTEGER
      ;






SS         : SB 
SB       : FOR '(' F ';' F2 ';' F ')' DEF
           ;
DEF    : '{' BODY '}'
           | F';'
           | SB
           |
           ;
BODY  : BODY BODY
           | F ';'       
           | SB
           |            
           ;
       
F        : ID '=' F
          | F '+' F
          | F '-' F
          | F '*' F
          | F '/' F
          | F '<' F
          | F '>' F
          | F LE F
          | F GE F
          | F EQ F
          | F NE F
          | F OR F
          | F AND F
          | F '+' '+'
          | F '-' '-'
          | ID 
          | INTEGER
          ;

   
F2       : F'<'F
         | F'>'F
         | F LE F
         | F GE F
         | F EQ F
         | F NE F
         | F OR F
         | F AND F
         ;   









SU        : ST9 
ST9    :    WHILE'(' E8 ')' '{' STS '}'
STS      :     STS STS
          | X';'
          ;
X       : ID'='X
          | X'+'X
          | X'-'X
          | X'*'X
          | X'/'X
          | X'<'X
          | X'>'X
          | X LE X
          | X GE X
          | X EQ X
          | X NE X
          | X OR X
          | X AND X
          | ID
          | INTEGER
          ;
E8     : X'<'X
          | X'>'X
          | X LE X
          | X GE X
          | X EQ X
          | X NE X
          | X OR X
          | X AND X
          | ID
          | INTEGER
          ;




exp: 
|MAIN SYMBOL pattern BRACES action BRACES SYMBOL FILENAME EOL {}
   ;

pattern:
|INTEGER RELOP INTEGER {}
       ;
action:
|KEYWORD action {}
|FIELD {}
|FIELD SYMBOL action {}
     ;


%%

int main(){
yyparse();
return 0;
}


int yyerror(char *s)
{
printf("\nExpression is invalid");
exit(0);
}