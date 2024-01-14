/* Definition Section */
%{
#include <stdio.h>
/* Global variables */
int tchar = 0, tword = 0, tspace = 0,linec=0;
%}

/* Rule Section */
%%

[\n] {linec++;tword++;}
[" "] {tspace++; tword++;}
[\t] {tword++;}
[a-zA-Z0-9] {tchar++;}

%%

/* Call the yywrap function */
int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("file.txt", "r");

    if (yyin == NULL)
    {
        fprintf(stderr, "Error opening file.\n");
        return 1;
    }

    
    yylex();
    if(tchar>0)
    {
        linec++;
    }

    printf("Number of characters: %d\nNumber of words: %d\nNumber of spaces: %d\nNumber of lines: %d\n", tchar, tword+1, tspace,linec);

    fclose(yyin);
    return 0;
}
