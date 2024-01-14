%{
	#undef yywrap
	#define yywrap() 1
%}
%%
[\n]
{
printf("%s",yytext);
}

%%
void main()
{
yylex();
}