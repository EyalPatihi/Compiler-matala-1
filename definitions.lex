%option noyywrap

%{
%}

ALPHA 			[A-Za-z]
DIGIT 			[1-6]

OPENER			<
CLOSER			>

CHAR_C			c
CHAR_H			h

STARTML			oubegin
ENDML			ouend

BEGIN_BOLD		bold
END_BOLD		/bold

BEGIN_HEADER	h
END_HEADER		/h

NEW_LINE		nl

BEGIN_COMMENT	!! 
END_COMMENT		 !!

COLOR			text color=("black" | "blue" | "red") 

B_BULLET		bl
E_BULLET		/bl

//STRING			{ALPHA}+

%%

{OPENER}{STARTML}{CLOSER}		fprintf(yyout, "StartML", yytext);
{OPENER}{NEW_LINE}{CLOSER}		fprintf(yyout, "\n",yytext);
{OPENER}{CHAR_C}{CLOSER}		fprintf(yyout, "%20s\n",yytext);
{OPENER}{BEGIN_HEADER}{DIGIT}	fprintf(yyout, "h"+DIGIT, yytext);		
//{STRING}						fprintf(yyout, STRING, yytext);
//{OPENER}{BEGIN_BOLD}{CLOSER}	
//{OPENER}{COLOR}{CLOSER}			

%%

int main(int argc, char **argv ){
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
yyin = fopen( argv[0], "r" );
else
yyin = stdin;


if ( argc > 1 )
yyout = fopen( argv[1], "w" );
else
yyout = stdout;
yylex();
}





