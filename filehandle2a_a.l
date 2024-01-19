%{
#include<stdio.h>
#include<string.h>
%}

%%

^[aA].*[aA]$ { 
    printf("%s\n", yytext);
    fprintf(yyout, "%s\n", yytext);
}

^[aA]$ {
    printf("%s\n", yytext);
    fprintf(yyout, "%s\n", yytext);
}

.|\n { /* Ignore other lines */ }

%%

int yywrap() {
    return 1;
}

int main() {
    FILE *input_file = fopen("file1.txt", "r");
    if (input_file == NULL) {
        fprintf(stderr, "Error opening input file.\n");
        return 1;
    }

    FILE *output_file = fopen("temp_output.txt", "w");
    if (output_file == NULL) {
        fprintf(stderr, "Error opening output file.\n");
        fclose(input_file);
        return 1;
    }

    yyin = input_file;
    yyout = output_file;

    yylex();

    fclose(input_file);
    fclose(output_file);

    // Rename temp_output.txt to file1.txt
    if (remove("file1.txt") != 0) {
        perror("Error removing original file");
        return 1;
    }

    if (rename("temp_output.txt", "file1.txt") != 0) {
        perror("Error renaming file");
        return 1;
    }

    return 0;
}
