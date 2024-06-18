//////////////////////////////////////////////////////////////////////////////
//
// Part of Mental Maps DSL
// @brief   Syntax definition (grammar) for Joris Dormans .txt files.
// @author  Daria Protsenko - daria.protsenkoo@gmail.com
// @date    04-06-2024
//
//////////////////////////////////////////////////////////////////////////////

//Whitespace and comment taken from Pico syntax: 
//https://www.rascal-mpl.org/docs/Recipes/demo/lang/Pico/Syntax/#demo-lang-Pico-Syntax-WhitespaceAndComment

module parsing::TemplateSyntax
import ParseTree;
import vis::Text;

//Elements of the syntax:
//whitespace
//single-line comments
//boolean
//reserved keywords 
//integer
//float
//keywords (name)
//location
//string

//Whitespace and single-line comments
lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

//boolean
lexical BOOLEAN
	= @category="Boolean" "true" | "false";

//reserved keywords 
keyword Keywords = 'include' | 'if' | 'else' | 'endIf' | "true" | "false";

//integer
lexical INTEGER
  = @category="Integer" [0-9]* !>> [0-9];
  
//float
lexical FLOAT
  = INTEGER ([.][0-9]+?)?;

//keywords
lexical NAME
  = @category="Name" name: 
  ([a-zA-Z_$] [a-zA-Z0-9_$]* !>> [a-zA-Z0-9_$]) \ Keywords ;

//location
lexical LOCATION
  = @category="Location" location: 
  [a-zA-Z0-9_]([a-zA-Z0-9_]|("/"[a-zA-Z0-9_]))*;

//string
lexical STRING
  = @category="String" "\"" ![\n\"]* "\"";

start syntax Template
	= template: Statement* statement;

syntax Statement 
	=   funcCall: NAME functionName "(" {Parameter ","}* parameters")"
	|	ifElse: "if" "(" Parameter parameter ")" Statement* statementsif "else()" Statement* statementselse "endIf()" 
	|	include: "#include" LOCATION location
	;

// syntax Include
// 	= include: "#include" LOCATION location
// 	;

// syntax FuncCall
// 	= funcCall: NAME functionName "(" Arguments arguments ")"
// 	;

syntax Parameter 
	= parameter: NAME name "=" Option option
	| parameterWithListContent: NAME name "=" "[" {Option ","}* options "]"
	;

// syntax Arguments =
// 	  Parameter parameter "," Arguments arguments
// 	| Parameter parameter
// 	;	
// Written recurcisely as not to match func(arg1=2 arg2=3) -> syntax error!

// syntax ListContent
// 	= listContent: "[" Option option ("," Option)* options "]"
// 	;

syntax Option
	= optionName: NAME name
	| optionBoolean: BOOLEAN boolean
	| optionInteger: INTEGER integer
	| optionFloat: FLOAT float "f"
	| optionString: STRING string
	;

// syntax IfElse
// 	= ifElse: "if" "(" Parameter parameter ")" Statement+ statementsif "else()" Statement+ statementselse "endIf()" 
// 	;

// syntax Condition
// 	= condition: NAME name "=" Option option
// 	;
//Condition in a conditional statement - to be expanded

//////////////////////////////////////////////////	
//LD parsers
//////////////////////////////////////////////////

 public start[Template] LD_parse(str src) = 
   parse(#start[Template], src);

 public start[Template] LD_parse(str src, loc file) = 
   parse(#start[Template], src, file);
  
public start[Template] LD_parse(loc file) =
  parse(#start[Template], file);

loc template = |file:///C:/Users/dasha/Thesis/my-dsl/src/tests/mine.lt|;

//println(prettyTree(t)); to pretty print the parse tree