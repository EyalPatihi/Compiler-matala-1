%option noyywrap

%{
%}

ALPHA 			[A-Za-z]
DIGIT 			[1-6]

OPENER			<
CLOSER			>

START_CENTER		("c" | "C")
END_CENTER      ("/c" | "/C")

STARTML			oubegin
ENDML			  ouend

BEGIN_BOLD		bold
END_BOLD		  /bold

BEGIN_HEADER  ("h" | "H")	
END_HEADER    ("/h" | "/H")		

NEW_LINE		("nl") | ("NL") | ("Nl") | ("nL")

COMMENT	!! 

COLOR			text color=("black" | "blue" | "red") 

B_BULLET		("bl") | ("BL") | ("bL") | ("Bl")
E_BULLET		/bl

BEGIN_ITALICS it
END_ITALICS   /it

//STRING			({ALPHA} | (DIGIT)}+

%%

{OPENER}{STARTML}{CLOSER}		            fprintf(yyout, "startML", yytext);
{OPENER}{ENDML}{CLOSER}                 fprintf(yyout, "endML", yytext);

{OPENER}{NEW_LINE}{CLOSER}	          	fprintf(yyout, "NEWLINE",yytext);
//{STRING}					                   	fprintf(yyout, STRING, yytext);

{OPENER}{START_CENTER}{CLOSER}	        fprintf(yyout, "START_CENTER\n",yytext);
{OPENER}{END_CENTER}{CLOSER}	          fprintf(yyout, "END_CENTER\n",yytext);

{OPENER}{BEGIN_HEADER}{DIGIT}	          fprintf(yyout, "BEGIN_HEADING_MARK" "h%c", yytext[2]);	
{OPENER}{END_HEADER}{DIGIT}	            fprintf(yyout, "END_HEADING_MARK" "%c", yytext[2]);

//{OPENER}{BEGIN_BOLD}{CLOSER}          fprintf(yyout, "BEGIN_BOLD_MARK", yytext);    ???????
//{OPENER}{END_BOLD}{CLOSER}	          fprintf(yyout, "END_BOLD_MARK", yytext);    ???????

//{OPENER}{COLOR}{CLOSER}			
{OPENER}{BEGIN_ITALICS}{CLOSER}         //fprintf(yyout, ????????????????
{OPENER}{END_ITALICS}{CLOSER}           //fprintf(yyout, ????????????????
{OPENER}{COMMENT}{STRING}{COMMENT}{CLOSER}         //fprintf
{STRING}{OPENER}

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





