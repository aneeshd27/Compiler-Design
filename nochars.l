%{
#include <stdio.h>
#include <string.h>
#undef yywrap
#define yywrap() 1
int wordCount = 0;
%}

%option noyywrap

%%

[^ \t\n]+ {
    wordCount++;
}

\n {
    printf("Number of words: %d\n", wordCount);
    wordCount = 0; // Reset word count for the next input
}

. {
    // Ignore any other characters
}

%%

int main()
{
    printf("Enter a string (press Enter to display the number of words):\n");
    yylex(); // calling the rules section
    return 0;
}