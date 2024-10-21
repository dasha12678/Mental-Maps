module mentalmapslanguage::SyntaxDefinition

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

lexical BOOLEAN
	= @category="Boolean" "true" | "false";

keyword Keywords = "if" | "else" | "true" | "false" 
| "from" | "to" | "or" | "and" | "enum" | "struct" | "str" | "bool" | "int" | "float" | "list" | "set" | "typedefs";

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
  (TypeDef ";")* typedefs
  "}"
  ID name "{" 
  Declaration* declarations
  "}"
    ;
  
syntax TypeDef
    = enumDef: Mod modif "enum" ID name "{" {Value ","}* values "}" //enums
    | structDef: "root"? Mod modif "struct" ID name "{" Member* members "}" //structs
    | listDef: Mod modif "list" "[" Value typeOf "]" ID name  // lists  
    | setDef: Mod modif "set" "[" Value typeOf "]" ID name  // sets
    | boolDef: Mod modif "bool" ID name   // bools
    | intDef: Mod modif "int" ID name  // ints
    | floatDef: Mod modif "float" ID name  // floats
    | strDef: Mod modif "str" ID name  // strings
    ;

syntax Declaration 
  = declBasic: ID name "=" Value chosenValue ";"
  | declList: ID name "=" "[" {Value ","}* listValues "]" ";"
  | declSet: ID name "=" "{" {Value ","}* setValues "}" ";"
  | declStruct: ID name "{" Declaration* declarations "}"
  | ifElse: "if" "(" ID variable "==" Value myValue ")" "{" Declaration* declsIf "}" "else" "{" Declaration* declsElse "}" 
  | ifNoElse: "if" "(" ID variable "==" Value myValue ")" "{" Declaration* declsIf "}"
    ;

syntax MemberDecl
  = memberDecl: Mod modif ID typeOf ID name //initialize struct, enum, collection
  | typeDef: TypeDef typedef
  ;

syntax Member
  = initMember: MemberDecl member ";"
  | initXor: MemberDecl mmbr1 "xor" MemberDecl mmbr2 ";" //xor 
    ;

syntax Mod //variability
  = optional: "opt" 
  | required: //if its empty, it is required
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


  