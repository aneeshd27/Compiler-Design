%{
#include <stdio.h>

FILE *inputFile;
FILE *outputFile;
int inComment = 0; // Flag to track whether inside a comment
%}

%%
"/*"     { inComment = 1; } // Start of a comment
"*/"     { inComment = 0; } // End of a comment
[a-z]    { if (!inComment) fprintf(outputFile, "%c", 'A' + yytext[0] - 'a'); }
[A-Z]    { if (!inComment) fprintf(outputFile, "%c", 'a' + yytext[0] - 'A'); }
.        { if (!inComment) fprintf(outputFile, "%s", yytext); }

%%

int yywrap()
{
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s input_file output_file\n", argv[0]);
        return 1;
    }

    inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        perror("Error opening input file");
        return 1;
    }

    outputFile = fopen(argv[2], "w");
    if (!outputFile) {
        perror("Error opening output file");
        fclose(inputFile);
        return 1;
    }

    yyin = inputFile;
    yyout = outputFile;

    yylex();

    fclose(inputFile);
    fclose(outputFile);

    return 0;
}
