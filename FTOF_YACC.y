%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token INTEGER
%token BOOLEAN
%token VOID
%token TRUE
%token FALSE
%token END_STMT
%token MISSION
%token AMMO
%token FIRE
%token STOP
%token LCB
%token RCB
%token LP
%token RP
%token LSQ
%token RSQ
%token WAVE
%token INT_CONST
%token EXPO_OP
%token COMMA
%token IF
%token ELSIF
%token ELSE
%token WHILE
%token FOR
%token ASSIGN_OP
%token RETURN
%token OR
%token AND
%token ST_OP
%token GT_OP
%token STE_OP
%token GTE_OP
%token EQ_OP
%token NOT_EQ_OP
%token ADD_OP
%token SUB_OP
%token MULT_OP
%token DIV_OP
%token MODULO_OP
%token COMMENT
%token INPUT
%token OUTPUT
%token IDENTIFIER

%start program

%%

program:
    FIRE stmts

stmts:
    stmt 
    |stmts stmt

stmt:
    decl stmt
    |init stmt
    |decl_n_init stmt
    |math_exp stmt
    |loop_stmt stmt
    |input_stmt stmt
    |output_stmt stmt
    |ammo stmt
    |func_def stmt
    |func_call stmt
    |comment_stmt stmt
    |ammos_assignElement stmt
    |conditional_stmt stmt
    |return_stmt
    |end_stmt
    |STOP

end_stmt:
    END_STMT

//Variable Declaration
var_name:
    IDENTIFIER

rhs_val:
    math_exp 
    |func_call

decl:
    type_identifier var_name

init:
    var_name ASSIGN_OP rhs_val

decl_n_init:
    type_identifier var_name ASSIGN_OP rhs_val

//Types&Constants
type_identifier:
    BOOLEAN 
    |INTEGER

type:
    boolean_type 
    |int_type

int_type:
    INT_CONST
    |ammo_element

boolean_type:
    TRUE 
    |FALSE

//Operations
math_exp:
    math_exp ADD_OP term
    |math_exp SUB_OP term
    |term

term:
    term MULT_OP factor
    |term DIV_OP factor
    |factor

factor:
    factor MODULO_OP expo
    |expo

expo:
    type EXPO_OP type
    |var_name EXPO_OP type
    |type EXPO_OP var_name
    |var_name EXPO_OP var_name
    |type
    |var_name

//Expressions
logic_exp:
    or_exp

or_exp:
    or_exp OR and_exp
    |and_exp

and_exp:
    and_exp AND equality_exp
    |equality_exp

equality_exp:
    equality_exp EQ_OP relational_exp
    |equality_exp NOT_EQ_OP relational_exp
    |relational_exp

relational_exp:
    relational_exp GT_OP primary_exp
    |relational_exp ST_OP primary_exp
    |relational_exp GTE_OP primary_exp
    |relational_exp STE_OP primary_exp
    |primary_exp

primary_exp:
    logic_type
    |LP logic_exp RP

logic_type:
    int_type
    |boolean_type
    |IDENTIFIER

//Loop Statements
loop_stmt:
    while_loop
    |for_loop

while_loop:
    WHILE LP logic_exp RP LCB stmts RCB

for_loop:
    FOR LP forloop_init end_stmt logic_exp end_stmt init RP LCB stmts RCB

forloop_init:
    decl_n_init
    |init

//Conditionals
conditional_stmt:
    IF LP logic_exp RP LCB stmts RCB
    |IF LP logic_exp RP LCB stmts RCB ELSIF LP logic_exp RP LCB stmts RCB
    |IF LP logic_exp RP LCB stmts RCB ELSIF LP logic_exp RP LCB stmts RCB ELSE LCB stmts RCB
    |IF LP logic_exp RP LCB stmts RCB ELSE LCB stmts RCB

//Input/Output
input_stmt:
    INPUT LP input_body RP

input_body:
    var_name

output_stmt:
    OUTPUT LP output_body RP

output_body:
    math_exp | func_call

//Arrays(Ammo)
ammo_name:
    IDENTIFIER

ammos:
    int_type COMMA ammos
    |var_name COMMA ammos
    |int_type
    |var_name
    |LSQ ammos RSQ COMMA ammos
    |LSQ ammos RSQ

ammo_element:
    var_name LSQ bullet RSQ

ammos_assignElement:
    ammo_element ASSIGN_OP bullet

bullet:
    math_exp

ammo:
    AMMO ammo_name ASSIGN_OP LSQ ammos RSQ

//Functions(Missions)

func_types:
    type_identifier | VOID

func_name:
    IDENTIFIER

params:
    params COMMA type_identifier IDENTIFIER
    |type_identifier IDENTIFIER
    |

call_params:
    type COMMA call_params
    |var_name COMMA call_params
    |var_name
    |int_type
    |boolean_type
    |

func_def:
    func_types MISSION func_name LP params RP LCB stmts RCB

func_call:
    MISSION func_name LP call_params RP

return_stmt:
    RETURN math_exp end_stmt

//Comments
comment_stmt:
    COMMENT

%%
#include "lex.yy.c"
void yyerror(char *s) {
	fprintf(stdout, "Syntax error on line %d!\n", yylineno,s);
}
int main(void){
 yyparse();
if(yynerrs < 1){
		printf("Input program is valid\n");
	}
 return 0;
}