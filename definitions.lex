%option noyywrap

%{
%}

ALPHA 			[A-Za-z]
DIGIT 			[1-6]

OPENER			<
CLOSER			>

STARTML			oubegin
ENDML			  ouend

NEW_LINE		("nl") | ("NL") | ("Nl") | ("nL")

STRING			([^<>])+       ??????????????

BEGIN_HEADING_MARK  ("h" | "H")	
END_HEADING_MARK    ("/h" | "/H")		

BEGIN_BOLD		("bold") | ("BOLD") | ("") | ("")    ?????????
END_BOLD		  /bold                                ?????????

BEGIN_ITALICS ("it") | ("IT") | ("It") | ("iT")
END_ITALICS   ("/it") | ("/IT") | ("/It") | ("/iT")

BEGIN_COMMENT	<!!
END_COMMENT   !!>


START_CENTER		("c" | "C")
END_CENTER      ("/c" | "/C")

COLOR			text color=("black" | "blue" | "red") 



BEGIN_NUMBER_BULLET		("bln") | ("BLN") | ("bL") | ("Bl")   ???????????
END_NUMBER_BULLET		/bl                                     ???????????

BEGIN_REGULAR_BULLET      ("bl") | ("BL") | ("bL") | ("Bl")
END_REGULAR_BULLET        ("bl") | ("BL") | ("bL") | ("Bl")

%%

{OPENER}{STARTML}{CLOSER}		            fprintf(yyout, "startML", yytext);
{OPENER}{ENDML}{CLOSER}                 fprintf(yyout, "endML", yytext);

{OPENER}{NEW_LINE}{CLOSER}	          	fprintf(yyout, "NEWLINE",yytext);
//{STRING}					                   	fprintf(yyout, STRING, yytext);

{OPENER}{START_CENTER}{CLOSER}	        fprintf(yyout, "START_CENTER\n",yytext);
{OPENER}{END_CENTER}{CLOSER}	          fprintf(yyout, "END_CENTER\n",yytext);

{OPENER}{BEGIN_HEADER}{DIGIT}	          fprintf(yyout, "BEGIN_HEADING_MARK" "h%c", yytext[2]);	
{OPENER}{END_HEADER}{DIGIT}	            fprintf(yyout, "END_HEADING_MARK" "h%c", yytext[2]);

//{OPENER}{BEGIN_BOLD}{CLOSER}          fprintf(yyout, "BEGIN_BOLD_MARK", yytext);    ???????
//{OPENER}{END_BOLD}{CLOSER}	          fprintf(yyout, "END_BOLD_MARK", yytext);    ???????

//{OPENER}{COLOR}{CLOSER}			
{OPENER}{BEGIN_ITALICS}{CLOSER}         //fprintf(yyout, ????????????????
{OPENER}{END_ITALICS}{CLOSER}           //fprintf(yyout, ????????????????

{BEGIN_COMMENT}{STRING}{END_COMMENT}    //fprintf(yyout, "Comment:%s", yytext);
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





