%{
using namespace std;

#include <string>
#include <iostream>
#include <fstream>


%}

%start start

%union {
	char * STR;
	int INT;
	float FLOAT;
	
};

%token VAR FUNCTION WHILE FOR IF ELSE CLASS RETURN BREAK CONTINUE
%token<STR> COMPARISON STRING BOOL ARITH_OPR LOGIC_OPR COARITH_OPR 
%token SQ_BR_LEFT SQ_BR_RIGHT BR_LEFT BR_RIGHT LBR_LEFT LBR_RIGHT ASSIGN
%token<INT> INTEGER
%token<FLOAT> FLOAT
%token<STR> ID
%token COMMA ENDLINE NEWLINE PROPERTY

%nonassoc BR_RIGHT
%nonassoc ELSE
%right ASSIGN COARITH_OPR
%left "or"
%left "and"
%nonassoc COMPARISON
%left "-" "+"
%left "*" "/" "%"
%right "^"
%nonassoc UMINUS "not"
%nonassoc SQ_BR_LEFT SQ_BR_RIGHT

%%


%%

int main(int argc, char* argv[]) {

}
