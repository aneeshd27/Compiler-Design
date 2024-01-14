%{
#include<stdio.h>
#include<string.h>
#undef yywrap
#define yywrap() 1
int wordc = 0, ccount = 0, linec = 0;
%}

%%
[^\n]+ {
    linec++;
}
[a-zA-Z0-9]+ {
    ccount++;
}
[^ \t\n]+ {
    wordc++;
}

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *yyin = fopen("file.txt", "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error opening file.\n");
        return 1;
    }

    yylex();

    printf("The number of characters is %d \n", ccount);
    printf("The number of words is %d \n", wordc);
    printf("The number of lines in the file is %d\n", linec);

    fclose(yyin);
    return 0;
}
