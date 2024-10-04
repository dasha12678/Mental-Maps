module mentalmapslanguage::SyntaxDefinition

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

lexical BOOLEAN
	= @category="Boolean" "true" | "false";

keyword Keywords = "enum" | "struct" | "if" | "else" | "true" | "false" 
| "from" | "to" | "or" | "and" | "bool" | "str" | "int" | "float";

lexical INTEGER
  = @category="Integer" [\-]? [0-9]+ !>> [0-9];

lexical FLOAT
  = INTEGER ([.][0-9]+?)?;

lexical ID
  = @category="Identifier" id: 
  ([a-zA-Z_$] [a-zA-Z0-9_$]* !>> [a-zA-Z0-9_$]) \ Keywords ;

lexical STRING
  = @category="String" "\"" ![\n\"]* "\"";

start syntax Level
  = level: "typedefs" "{"
  TypeDef* typedefs
  "}"
  ID name "{" 
  Declaration* declarations
  "}"
    ;
  
syntax TypeDef
    = enum: Mod modif "enum" ID name "{" {Value ","}* values "}" ";" //enums
    | struct: "root"? Mod modif "struct" ID name "{" Member* members "}" //structs
    | listDef: Mod modif "list" "[" ID idtype "]" ID name ";" // lists  
    | setDef: Mod modif "set" "[" ID idtype "]" ID name ";" // sets
    | boolDef: Mod modif "bool" ID name  ";" // bools
    | intDef: Mod modif "int" ID name ";" // ints
    | floatDef: Mod modif "float" ID name ";" // floats
    | strDef: Mod modif "str" ID name ";" // strings
    ;

syntax Declaration 
  = decl: ID name "=" Value chosenValue ";"
  | declList: ID name "=" "[" {Value ","}* listValues "]" ";"
  | declSet: ID name "=" "{" {Value ","}* setValues "}" ";"
  | declStruct: ID name "{" Declaration* declarations"}"
  | ifElse: "if" "(" ID variable "==" Value myValue ")" "{" Declaration* declsIf "}" "else" "{" Declaration* declsElse "}" 
    ;

syntax MemberDecl
  = init: Mod modif ID typeCustom ID name //initialize struct, enum, collection
  | defBasic: Mod modif ID typeOf ID name //basic typedef
  ;

syntax Member
  = initMember: MemberDecl member ";"
  | initXor: MemberDecl mmbr1 "xor" MemberDecl mmbr2 ";" //xor 
    ;

syntax Mod //variability
  = optional: "opt" 
  | required:  //if its empty, it is required
  | or: "or" 
  | xor: "xor" 
  ;
syntax Value
    = boolValue: BOOLEAN boolValue
    | intValue: INTEGER intValue
    | floatValue: FLOAT floatValue
    | stringValue: STRING stringValue
    | declValue: ID nameValue //enum value, no lookup
    ;


  