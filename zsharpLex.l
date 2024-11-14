%{
#include <stdio.h>
%}

IDENTIFIER    [a-zA-Z_][a-zA-Z0-9_]*
VSTRING       \`([^`\$]|(\$\{[a-zA-Z_][a-zA-Z0-9_]*\}))*\`
STRING        \"[^\"]*\" 
FLOAT         [0-9]+\.[0-9]+
INTEGER       [0-9]+
OPERATOR      [-+*/=<>!&|] 
DELIMITER     [,\(\)\[\]\{\}\\]
SLC           "//".*   
MLC           "/*"([^*]|\*+[^*/])*\*+"/"       

%%

[ \t\n]+

{SLC}             { printf("SINGLE_LINE_COMMENT-> %s\n", yytext); }
{MLC}             { printf("MULTI_LINE_COMMENT-> %s\n", yytext); }
"bet"             { printf("VARIABLE    -> %s\n", yytext); }
"fr"              { printf("CONST       -> %s\n", yytext); }
"era"             { printf("FUNCTION    -> %s\n", yytext); }
"vibeCheck"       { printf("IF          -> %s\n", yytext); }
"aint"            { printf("ELSE_IF     -> %s\n", yytext); }
"meh"             { printf("ELSE        -> %s\n", yytext); }
"reps"            { printf("FOR         -> %s\n", yytext); }
"loopin"          { printf("WHILE       -> %s\n", yytext); }
"yeet"            { printf("RETURN      -> %s\n", yytext); }
"spill_tea"       { printf("PRINT       -> %s\n", yytext); }
"noCap"           { printf("TRUE        -> %s\n", yytext); }
"cap"             { printf("FALSE       -> %s\n", yytext); }
"squad"           { printf("ARRAY       -> %s\n", yytext); }
"ghost"           { printf("BREAK       -> %s\n", yytext); }
"skip"            { printf("CONTINUE    -> %s\n", yytext); }
"slidein"         { printf("INCLUDE     -> %s\n", yytext); }
"clout"           { printf("CLASS       -> %s\n", yytext); }
"levelUp"         { printf("EXTENDS     -> %s\n", yytext); }
"npc"             { printf("NULL        -> %s\n", yytext); }
"test"            { printf("TRY         -> %s\n", yytext); }
"caughtIn4k"      { printf("CATCH       -> %s\n", yytext); }
"slay"            { printf("SUCCESS     -> %s\n", yytext); }
"lowkey"          { printf("PRIVATE     -> %s\n", yytext); }
"highkey"         { printf("PUBLIC      -> %s\n", yytext); }
"main_character"  { printf("MAIN        -> %s\n", yytext); }
"ratio"           { printf("EXCEPTION   -> %s\n", yytext); }
"checkIt"         { printf("SCANF       -> %s\n", yytext); }
{FLOAT}           { printf("FLOAT       -> %s\n", yytext); }
{INTEGER}         { printf("INTEGER     -> %s\n", yytext); }
{STRING}          { printf("STRING      -> %s\n", yytext); }
{VSTRING}         { printf("vSTRING     -> %s\n", yytext); }
{IDENTIFIER}      { printf("IDENTIFIER  -> %s\n", yytext); }
{OPERATOR}        { printf("OPERATOR    -> %s\n", yytext); }
{DELIMITER}       { printf("DELIMITER   -> %s\n", yytext); }
.                 { printf("ERROR: UNKNOWN KEYWORD -> %s\n", yytext); }

%%

int yywrap() {
    return 1;
}


int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <input-file>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        return 1;
    }

    char outfile[256];
    snprintf(outfile, sizeof(outfile), "%s.out", argv[1]);
    freopen(outfile, "w", stdout);

    yyin = file;
    yylex();

    fclose(file);
    fclose(stdout); 

    return 0;
}
