
%{
#include <stdio.h>
#include <string.h>

int errors = 0;
char* error_msg = "erro(s) encontrado(s)";
%}

NUM [0-9]+
ID [a-zA-Z]+
%x C_COMMENT
 
%%

int 		{ fprintf(yyout, "%s INT\n", yytext); }
"+" 		{ fprintf(yyout, "%s SOMA\n", yytext); }
"-" 		{ fprintf(yyout, "%s SUB\n", yytext); }
"*" 		{ fprintf(yyout, "%s MUL\n", yytext); }
"/" 		{ fprintf(yyout, "%s DIV\n", yytext); }
"<" 		{ fprintf(yyout, "%s MENOR\n", yytext); }
"<=" 		{ fprintf(yyout, "%s MEIGUAL\n", yytext); }
">" 		{ fprintf(yyout, "%s MAIOR\n", yytext); }
">=" 		{ fprintf(yyout, "%s MAIGUAL\n", yytext); }
"==" 		{ fprintf(yyout, "%s IGUAL\n", yytext); }
"!=" 		{ fprintf(yyout, "%s DIF\n", yytext); }
"=" 		{ fprintf(yyout, "%s ATRIB\n", yytext); }
";" 		{ fprintf(yyout, "%s PV\n", yytext); }
"," 		{ fprintf(yyout, "%s V\n", yytext); }
"(" 		{ fprintf(yyout, "%s AP\n", yytext); }
")" 		{ fprintf(yyout, "%s FP\n", yytext); }
"[" 		{ fprintf(yyout, "%s ACO\n", yytext); }
"]" 		{ fprintf(yyout, "%s FCO\n", yytext); }
"{" 		{ fprintf(yyout, "%s ACH\n", yytext); }
"}" 		{ fprintf(yyout, "%s FCH\n", yytext); }

{ID} 		{ fprintf(yyout, "%s ID\n", yytext); }
{NUM} 		{ fprintf(yyout, "%s NUM\n", yytext); }

[ \t\n]+	{ } 

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>.    { }
<C_COMMENT>\n   { }

. 		{ fprintf(yyout, "%s ERRO\n", yytext); errors++; }

<<EOF>> 	{ fseek(yyin, -1, SEEK_END);
		  fprintf(yyout,"\n%d %s\n", errors, error_msg); 
		  yyterminate(); }

%%

int main(int argc, char** argv){
	if (argc > 1){
		char* extension;
		if ((extension = strchr(argv[1], '.')) != NULL && strcmp(extension, ".c-") == 0){
			yyin = fopen(argv[1], "r");
			yyout = fopen("relatorio.txt", "w+");
		}
		else{
			printf("ERRO: Tipo de arquivo invalido. \n");
			return 1;
		}
	}
	else {
		printf("ERRO: Arquivo(s) de entrada nao encontrado(s). \n");
		return 1;
	}
	yylex();
	
	return 0;
}
