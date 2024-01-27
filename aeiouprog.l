%{
#undef yywrap
#define yywrap() 1
#include <stdio.h>
#include <string.h>
int aCount = 0, eCount = 0, iCount = 0, oCount = 0, uCount = 0;
%}

%%

.*[.*aeiouAEIOU.*]{5}.* {
    int len = strlen(yytext);
    for (int i = 0; i < len; i++) {
        char c = yytext[i];
        switch (c) {
            case 'a':
            case 'A':
                aCount++;
                break;
            case 'e':
            case 'E':
                eCount++;
                break;
            case 'i':
            case 'I':
                iCount++;
                break;
            case 'o':
            case 'O':
                oCount++;
                break;
            case 'u':
            case 'U':
                uCount++;
                break;
        }
    }

    if (aCount == 1 && eCount == 1 && iCount == 1 && oCount == 1 && uCount == 1) {
        printf("Yes\n");
    } else {
        printf("No\n");
    }

    // Reset counts for the next match
    aCount = eCount = iCount = oCount = uCount = 0;
}

.* {
    printf("No\n");
}

%%

int main(void) {
    yylex();
    return 0;
}
