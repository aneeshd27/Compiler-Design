%{
    #undef yywrap
    #define yywrap() 1
%}
%%
[\n]
{
for(int i=1;i<=10;i++)
{
    printf("%d ",i);
}
}
.|\n {}
%%
void main()
{
    yylex();
}