%{
#include<stdio.h>
#include"PARSER.tab.h"
int linenumber=1;
int lno;
int spaces=0;
extern yylval;

%}




DIGIT [0-9]
LETTER [A-Za-z]
KEYWORD BEGIN|END|if|else|do|while|for|in|break|continue|delete|next|nextfile|func|exit|print|printf
VARIABLE CONVFMT|FIELDWIDTHS|IGNORECASE|OFMT|SUBSEP|ARGV|ARGC|ARGIND|ENVIRON|ERRNO|FILENAME|FNR|RLENGTH|RSTART|RT|NR|NF|FS|RS|OFS|ORS
FUNCTION atan2|sqet|int|exp|log|sin|cos|rand|srand|index|length|match|split|sprinf|sub|gsub|gensub|substr|tolower|toupper|close|fflush|system|systime|strftime
AWK	awk|yawk|nawk


%%

\n 	{linenumber++;
yylval.ival=linenumber-1;
return EOL;}
[\s\t] {spaces++;}

${DIGIT}+ {lno=linenumber;
		yylval.sval=yytext;
		return FIELD;} 

[\"][^\"]*[\"] {lno=linenumber;
		yylval.sval=yytext;
		return LITERAL;} 

{AWK}	{lno=linenumber;
	yylval.sval=yytext;
	return MAIN;}


int|float|char return BUILTIN;

while   return WHILE;
if      return IF;
then    return THEN;
else    return ELSE;
for     return FOR;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"||"    return OR;
"&&"    return AND;


{KEYWORD} {lno=linenumber;
		yylval.sval=yytext;
		return KEYWORD;}

{FUNCTION}	{lno=linenumber;
		yylval.sval=yytext;
		return FUNCTION;}

{VARIABLE}	{lno=linenumber;
		yylval.sval=yytext;
		return VARIABLE;}




[a-zA-Z_]+[a-zA-Z0-9_]* {
		lno=linenumber;
		yylval.sval=yytext;
		return ID;}


[a-zA-Z_]+[a-zA-Z0-9_]*\-[a-zA-Z0-9_]*   {
		lno=linenumber;
		yylval.sval=yytext;
		return FILENAME;}




(<=|>=|==|<|>) {lno=linenumber;
		yylval.sval=yytext;
		return RELOP;}


((\+)|(\-)|(\*)|(\+\+)|(\/)|=|$) {lno=linenumber;
				yylval.sval=yytext;

				return OPERATORS;}
( return LP;
) return RP;	



{DIGIT}+ {lno=linenumber;
		yylval.ival=atoi(yytext);
		return INTEGER;}

[{}]   {lno=linenumber;
		yylval.sval=yytext;
	return BRACES;} 

[\(\)]    {lno=linenumber;
		yylval.sval=yytext;
	return PARENTHESIS;}  

"," return COMMA;
";" return SC;


[\.,;'"] {lno=linenumber;
	yylval.sval=yytext;
	return SYMBOL;}





[0-9]*\.[0-9]+ {lno=linenumber;
		yylval.fval=atof(yytext);
		return FLOAT;}




[a-zA-Z0-9_]+\.[a-zA-Z]+  {lno=linenumber;
				yylval.sval=yytext;
				return FILENAME;} 



[a-zA-Z0-9]+ 
"n" check();
	
"n" return NL;

%%



check(){
if(l!=r) printf("Syntax error!");
if(cbl-cbr!=0) printf("Syntax error!");
}

