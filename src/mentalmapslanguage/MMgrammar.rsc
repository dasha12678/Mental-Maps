module mentalmapslanguage::MMgrammar

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

//boolean
lexical BOOLEAN
	= @category="Boolean" "true" | "false";

//reserved keywords 
keyword Keywords = "" | "if" | "else" | "endIf" | "true" | "false";

//integer
lexical INTEGER
  = @category="Integer" [\-]? [0-9]+ !>> [0-9];
  
//float
lexical FLOAT
  = INTEGER ([.][0-9]+?)?;

//keywords
lexical NAME
  = @category="Name" name: 
  ([a-zA-Z_$] [a-zA-Z0-9_$]* !>> [a-zA-Z0-9_$]) \ Keywords ;

//string
lexical STRING
  = @category="String" "\"" ![\n\"]* "\"";

//size
lexical SIZE
  = @category= "tiny" | "small" | "medium" | "large";

//direction
lexical DIRECTION
  = @category= "North" | "East" | "South" | "West" | "Northeast" | "Northwest" | "Southeast" | "Southwest";

start syntax Level
	= TypeDef
    | "level" NAME "{"

    "}";

//Site block consists of statements
syntax Site
= "site" NAME "{"
  [Statement]*
  "}"
  ;

//Types of statements
syntax Statement
  = Annotation
  | "location" DIRECTION
  "size" SIZE
  ;

syntax Annotation
    = "extra" "{"
    [Extra]*
    "}"
    ;

syntax EnumCall 
  = 
  TypeDef NAME "=" NAME
  |TypeDef NAME "=" "[" {NAME ","}* "]"
  ;

//Type checking 
syntax Type
    = "bool"
    | "string"
    | "int"
    | "float"
    | NAME
    ;

syntax TypeDef
    = typedef: "enum" NAME "=" "[" {Value ","}* "]"
    | 
    ;

syntax Value 
    = BOOLEAN
    | INTEGER
    | FLOAT
    | STRING
    | NAME //enum value, no lookup
    | "[" {Value ","}* "]"
    | "{" {Value ","}* "}"
    ;


