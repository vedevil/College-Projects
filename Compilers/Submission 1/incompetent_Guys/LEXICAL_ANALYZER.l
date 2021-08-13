%{
#include<stdio.h>
int linenumber=1;
int lno;
int spaces;

%}




DIGIT [0-9]
LETTER [A-Za-z]
KEYWORD BEGIN|END|if|else|do|whi;e|for|in|break|continue|delete|next|nextfile|func|exit|print
VARIABLE CONVFMT|FIELDWIDTHS|IGNORECASE|OFMT|SUBSEP|ARGV|ARGC|ARGIND|ENVIRON|ERRNO|FILENAME|FNR|RLENGTH|RSTART|RT|NR|NF|FS|RS|OFS|ORS
FUNCTION atan2|sqet|int|exp|log|sin|cos|rand|srand|index|length|match|split|sprinf|sub|gsub|gensub|substr|tolower|toupper|close|fflush|system|systime|strftime
AWK	awk|yawk|nawk
%%

\n 	{linenumber++;
	
	}

[\s\t] {spaces++;}
${DIGIT}+ {lno=linenumber;
printf("LINENUMBER=%d\n",lno);
printf("TOKENNAME=FIELD\n");
printf("TOKENVALUE=%s\n\n\n",yytext);

} 

[\"][^\"]*[\"] {lno=linenumber;

printf("LINENUMBER=%d\n",lno);
printf("TOKENNAME=LITERAL\n");
printf("TOKENVALUE=%s\n\n\n",yytext);

} 







{AWK}	{lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
	printf("TOKENNAME=MAIN\n");
	printf("TOKENVALUE=%s\n\n\n",yytext);
	}


{KEYWORD} {lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
	printf("TOKENNAME=%s\n\n\n",yytext);}

{FUNCTION}	{lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
	printf("TOKENNAME=FUNCTION\n");
	printf("TOKENVALUE=%s\n\n\n",yytext);
	}

{VARIABLE}	{lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
	printf("TOKENNAME=VARIABLE\n");
	printf("TOKENVALUE=%s\n\n\n",yytext);
	}

[a-zA-Z_]+[a-zA-Z0-9_]* {
lno=linenumber;
printf("LINENUMBER=%d\n",lno);
printf("TOKENNAME=ID\n");
printf("TOKENVALUE=%s\n\n\n",yytext);}


[a-zA-Z_]+[a-zA-Z0-9_]*\-[a-zA-Z0-9_]*   {
lno=linenumber;
printf("LINENUMBER=%d\n",lno);
printf("TOKENNAME=FILENAME\n");
printf("TOKENVALUE=%s\n\n\n",yytext);
}




(<=|>=|==|<|>) {lno=linenumber;
		printf("LINENUMBER=%d\n",lno);
		printf("TOKENNAME=RELOP_OP\n");
		printf("TOKENVALUE=%s\n\n\n",yytext);
		}


((\+)|(\-)|(\*)|(\+\+)|(\/)|=|$) {lno=linenumber;
			printf("LINENUMBER=%d\n",lno);
			printf("TOKENNAME=OPERATORS\n");
			printf("TOKENVALUE=%s\n\n\n",yytext);}
	



{DIGIT}+ {lno=linenumber;
		printf("LINENUMBER=%d\n",lno);
		printf("TOKENNAME=INTEGER\n");
		printf("TOKENVALUE=%s\n\n\n",yytext);}






[\(\){}]    {lno=linenumber;
			printf("LINENUMBER=%d\n",lno);
			printf("TOKENNAME=PARENTHESIS\n");
			printf("TOKENVALUE=%s\n\n\n",yytext);}  


[\.,;'"] 		{lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
			printf("TOKENNAME=%s\n\n\n",yytext);}



[0-9]*\.[0-9]+ {lno=linenumber;
		printf("LINENUMBER=%d\n",lno);
		printf("TOKENNAME=FLOAT\n");
		printf("TOKENVALUE=%s\n\n\n",yytext);}




[a-zA-Z0-9_]+\.[a-zA-Z]+  {lno=linenumber;
	printf("LINENUMBER=%d\n",lno);
	printf("TOKENNAME=FILENAME\n");
	printf("TOKENVALUE=%s\n\n\n",yytext);} 


	


%%



void main(int argc, char **argv)
{
  FILE *fh;
  if (argc == 2 && (fh = fopen(argv[1], "r"))) {
    yyin = fh;
  }
else if(argc == 1)
printf("Enter awk-script\n");
else
printf("Srry, you have entered more than one awk-script file\n");
  yylex();
}
