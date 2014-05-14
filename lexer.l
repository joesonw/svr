%{
using namespace std;

#include <iostream>
#include <fstream>
#include <string>
#include "parser.tab.h"

extern int yylex();
extern int yyline;
extern void yyerror(string);

unsigned yycol = 0;
string yybuffer;

#define YY_USER_ACTION yycol += yyleng;
%}

%option yylineno nounput
%x COMMENT

VARIABLE 			var
COMPARISON			"=="|"!="|"<"|">"|"<="|">="

SQ_BR_LEFT			"["
SQ_BR_RIGHT			"]"
BR_LEFT				"("
BR_RIGHT			")"
LBR_LEFT			"{"
LBR_RIGHT			"}"


STRING 				\"([^"]|\\[nt\\"])*\"
FAIL_STRING 		\"([^"\\\n]|\\[nt\\"])*
INTEGER				[0-9]+
FLOAT				[0-9]*"."[0-9]+
BOOL				"true" | "false"

ARITH_OPR			"-" | "+" | "/" | "*" | "%" | "^"
LOGIC_OPR			and | or | not 
ASSIGN		     	"="
COARITH_OPR			[\+\/\*\-\%]=

FUNCTION			function
WHILE				while
FOR					for
IF					if
ELSE				else
CLASS				class
RETURN				return
BREAK				break
CONTINUE			continue

COMMA				,
ENDLINE				;
NEWLINE				\n
COMENT				#.*
PROPERTY			"."
IS					"is"



ID					_*[a-zA-Z][a-zA-Z0-9_]*

%%

{VAR}				{return VAR;}
{COMPARISON}		{yylval.STR = strdup(yytext); return COMPARISON;}

{SQ_BR_LEFT}		{return SQ_BR_LEFT;}
{SQ_BR_RIGHT}		{return SQ_BR_RIGHT;}
{BR_LEFT}			{return BR_LEFT;}
{BR_RIGHT}			{return BR_RIGHT;}
{LBR_LEFT}			{return LBR_LEFT;}
{LBR_RIGHT}			{return LBR_RIGHT;}

{STRING}			{yylval.STR = strdup(yytext); return STRING;}
{FAIL_STRING}		{cerr<<"ERROR(line " << yylineno << "): Unterminated string. "<<endl;EXIT(EXIT_FAILURE);}
{INTEGER}			{yylval.INT = atoi(yytext); return INTEGER;}
{FLOAT}				{yylval.FLOAT = atof(yytext); return FLOAT;}
{BOOL}				{yylval.STR = strdup(yytext); return BOOL;}

{ARITH_OPR}			{yylval.STR = strdup(yytext); return ARITH_OPR;}
{LOGIC_OPR}			{yylval.STR = strdup(yytext); return LOGIC_OPR;}
{ASSIGN}			{return ASSIGN;}
{COARITH_OPR}		{yylval.STR = strdup(yytext); return COARITH_OPR;}

{FUNCTION}			{return FUNCTION;}
{WHILE}				{return WHILE;}
{FOR}				{return FOR;}
{IF}				{return IF;}
{ELSE}				{return ELSE;}
{CLASS}				{return CLASS;}
{RETURN}			{return RETURN;}
{BREAK}				{return BREAK;}
{CONTINUE}			{return CONTINUE;}
{IS}				{return IS;}

{ID}		{yylval.STR = strdup(yytext); return ID;}

{COMMNA}			{return COMMA;}
{ENDLINE}			{return ENDLINE;}
{NEWLINE}			{return NEWLINE;}
{COMENT}			{}
{PROPERTY}			{return PROPERTY;}

{NEWLINE}			{yycol=0;yybuffer=yytext;yyless(1);}
.					{cerr<<"ERROR(line "<<yylineno<<"): Unknown token '"<<yytext<<"'."<<endl;exit(EXIT_FAILURE);}
