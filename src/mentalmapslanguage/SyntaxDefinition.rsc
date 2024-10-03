module mentalmapslanguage::SyntaxDefinition

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

lexical BOOLEAN
	= @category="Boolean" "true" | "false";

keyword Keywords = "enum" | "struct" | "if" | "true" | "false" | "from" | "to" | "or" | "and";

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
  Struct+ structs
  Connection* connections
  "}"
  ;
syntax Struct
= struct: ID name "{"
  Declaration* declarations
  Struct* subStructs
  "}"
  ;
  
syntax Declaration 
  = declarationSingle: ID? chosenType ID name "=" ID chosenValue ";"
  | declarationMultiple: ID? chosenType ID name "=" "[" {ID ","}* chosenValues "]" ";"
  > declarationChoose: ID? chosenType ID name "=" ID chosenValue1 "or" ID chosenValue2 ";"
  ;

syntax Connection 
  = connection: "connection" "{"
  Declaration* declarations
  "}"
  ;
syntax CollectionType
  	= lists: "list"
    | sets: "set"
    ;

syntax BasicType
    = boolean: "bool"
    | string: "str"
    | integer: "int"
    | float: "float"
    ;

syntax TypeDef
    = // basic: Mod mod BasicType basicType ID name ";" //basic - bool, str, int, float
    | enum: Mod mod "enum" ID name "{" {Value ","}* values "}" ";" //enums
    | struct: Annotation anno Mod mod "struct" ID name "{" {ID ","}* members "}" //structs
    | collections: Mod mod CollectionType collectionType "[" ID typeParam "]" ID name ";" // lists, sets
    ;

syntax Mod //variability
  = optional: "opt" 
  | required:  //if its empty, it is required
  | or: "or" 
  | xor: "xor" 
  ;

syntax Annotation 
  = root: "root" 
  | place: "place"
  | other: //empty alternative
  ;
syntax Value
    = boolValue: BOOLEAN boolValue
    | intValue: INTEGER intValue
    | floatValue: FLOAT floatValue
    | stringValue: STRING stringValue
    | declValue: ID declValue //enum value, no lookup
    | listValue: "[" {Value ","}* listValues "]"
    | setValue:"{" {Value ","}* setValues "}"
    ;
