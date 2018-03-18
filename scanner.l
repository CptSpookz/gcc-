
%{
#include <stdio.h>
#include <string.h>

int errors = 0;
%}

NUM [0-9]+
ID [a-zA-Z]+
 
%%

int { printf("%s INT\n", yytext); }
void { printf("%s VOID\n", yytext); }
if { printf("%s IF\n", yytext); }
else { printf("%s ELSE\n", yytext); }
while { printf("%s WHILE\n", yytext); }
return { printf("%s RETURN\n", yytext); }
input { printf("%s INPUT\n", yytext); }
output { printf("%s OUTPUT\n", yytext); }

"+" { printf("%s SOMA\n", yytext); }
"-" { printf("%s SUB\n", yytext); }
"*" { printf("%s MUL\n", yytext); }
"/" { printf("%s DIV\n", yytext); }
"<" { printf("%s MENOR\n", yytext); }
"<=" { printf("%s MEIGUAL\n", yytext); }
">" { printf("%s MAIOR\n", yytext); }
">=" { printf("%s MAIGUAL\n", yytext); }
"==" { printf("%s IGUAL\n", yytext); }
"!=" { printf("%s DIF\n", yytext); }
"=" { printf("%s ATRIB\n", yytext); }
";" { printf("%s PV\n", yytext); }
"," { printf("%s V\n", yytext); }
"(" { printf("%s AP\n", yytext); }
")" { printf("%s FP\n", yytext); }
"[" { printf("%s ACO\n", yytext); }
"]" { printf("%s FCO\n", yytext); }
"{" { printf("%s ACH\n", yytext); }
"}" { printf("%s FCH\n", yytext); }

{ID} { printf("%s ID\n", yytext); }
{NUM} { printf("%s NUM\n", yytext); }

[ \t\n]+ 

"/*" {
	char c;
	while(1) {

		while ((c = input()) != '*' && c != EOF);
		if (c == '*'){
			while ((c = input()) == '*');
			if (c == '/') break;
		}
		if (c == EOF){
			printf("Fim de arquivo inesperado. \n");
			break;
		}
	}
}

. { printf("%s ERRO\n", yytext); errors++; }

%%

int main(int argc, char** argv){
	if (argc > 0){
		char* extension;
		if ((extension = strchr(argv[1], '.')) != NULL && strcmp(extension, ".c-") == 0){
			yyin = fopen(argv[1], "r");
		}
		else{
			printf("Tipo de arquivo invalido. \n");
			exit(1);
		}
	}
	yylex();
}
