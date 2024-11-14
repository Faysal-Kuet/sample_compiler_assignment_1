%{
#include <stdio.h>

int keyword_count = 0;
int identifier_count = 0;
int integer_count = 0;
int float_count = 0;
int string_count = 0;
int vstring_count = 0;
int operator_count = 0;
int delimiter_count = 0;
int error_count = 0;

const char* keywords[] = {
    "bet", "fr", "era", "vibeCheck", "aint", "meh", "reps",
    "loopin", "yeet", "spill_tea", "noCap", "cap", "squad",
    "ghost", "skip", "slidein", "clout", "levelUp", "npc",
    "ick", "caughtIn4k", "slay", "lowkey", "highkey",
    "main_character", "ratio", "checkIt"
};
#define NUM_KEYWORDS (sizeof(keywords)/sizeof(keywords[0]))

%}

IDENTIFIER    [a-zA-Z_][a-zA-Z0-9_]*
VSTRING       \`([^`\$]|(\$\{[a-zA-Z_][a-zA-Z0-9_]*\}))*\`
STRING        \"[^\"]*\" 
FLOAT         [0-9]+\.[0-9]+
INTEGER       [0-9]+
OPERATOR      [-+*/=<>!&|] 
DELIMITER     [,\(\)\[\]\{\}\\]

%%
[ \t\n]+             

"bet"|"fr"|"era"|"vibeCheck"|"aint"|"meh"|"reps"|"loopin"|"yeet"|"spill_tea"|"noCap"|"cap"|"squad"|"ghost"|"skip"|"slidein"|"clout""levelUp"|"npc"|"test"|"caughtIn4k"|"slay"|"lowkey"|"highkey"|"main_character"|"ratio"|"checkIt"   { keyword_count++; }


{FLOAT}               { float_count++; }
{INTEGER}             { integer_count++; }
{STRING}              { string_count++; }
{VSTRING}             { vstring_count++; }
{IDENTIFIER}          { identifier_count++; }
{OPERATOR}            { operator_count++; }
{DELIMITER}           { delimiter_count++; }
.                     { error_count++; }

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

    yyin = file;
    yylex();
    fclose(file);

    printf("Keywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Integers: %d\n", integer_count);
    printf("Floats: %d\n", float_count);
    printf("Strings: %d\n", string_count);
    printf("VStrings: %d\n", vstring_count);
    printf("Operators: %d\n", operator_count);
    printf("Delimiters: %d\n", delimiter_count);
    printf("Errors: %d\n", error_count);

    return 0;
}
