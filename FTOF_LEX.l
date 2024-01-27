%{
#include <stdio.h>
void yyerror(char *);
%}
letter						[A-Za-z]
digit						[0-9]
sign                        [+-]
identifier					{letter}({letter}|{digit})*
int_stmt					{sign}?{digit}+
int_type                    int
bool_type                   bool
void_type					void
bool_true                   true|1
bool_false                  false|0
mission                     mission
ammo                        ammo
end_stmt					\;
left_cb						\{
right_cb					\}
left_p				        \(
right_p				        \)
left_sq                     \[
right_sq                    \]
wave                        \~
fire					    fire
stop                        stop
if_stmt						if
elsif_stmt                  elsif
else_stmt					else
while_stmt					while
for_stmt					for
assign_op				    \=
return						return
or_op   					\|\|
and_op  					\&\&
smaller_op  				\<
greater_op			    	\>
smaller_or_equal_op			\<\=
greater_or_equal_op			\>\=
equal_op					\=\=
not_equal_op				!\=
add_op					    \+
sub_op				        \-
mult_op			            \*
div_op					    \/
mod_op					    \%
expo_op                     \^
comma                       \,
comment				        \~([^~])*\~
input						input
output						out
other						\"(.)*\"
newline						\n

%option yylineno
%%
{int_type}                  return INTEGER;
{bool_type}                 return BOOLEAN;
{void_type}					return VOID;
{bool_true}                 return TRUE;
{bool_false}                return FALSE;
{end_stmt}					return END_STMT;
{mission}                   return MISSION;
{ammo}                      return AMMO;
{fire}				        return FIRE;
{stop}						return STOP;
{left_cb}					return LCB;
{right_cb}					return RCB;
{left_p}				    return LP;
{right_p}				    return RP;
{left_sq}                   return LSQ;
{right_sq}                  return RSQ;
{wave}                      return WAVE;
{int_stmt}					return INT_CONST;
{expo_op}                   return EXPO_OP;
{comma}                     return COMMA;
{if_stmt}					return IF;
{elsif_stmt}                return ELSIF;
{else_stmt}					return ELSE;
{while_stmt}				return WHILE;
{for_stmt}					return FOR;
{assign_op}				    return ASSIGN_OP;
{return}					return RETURN;
{or_op}				        return OR;
{and_op}				    return AND;
{smaller_op}				return ST_OP;
{greater_op}				return GT_OP;
{smaller_or_equal_op}		return STE_OP;
{greater_or_equal_op}		return GTE_OP;
{equal_op}				    return EQ_OP;
{not_equal_op}				return NOT_EQ_OP;
{add_op}				    return ADD_OP;
{sub_op}			        return SUB_OP;
{mult_op}			        return MULT_OP;
{div_op}				    return DIV_OP;
{mod_op}					return MODULO_OP;
{comment}				    return COMMENT;
{input}						return INPUT;
{output}					return OUTPUT;
{identifier}				return IDENTIFIER;
{newline}       			;
{other}						;
[ \t]						;
%%

int yywrap(void){
	return 1;
}