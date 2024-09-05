module mentalmapslanguage::SyntaxDefinition

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

lexical BOOLEAN
	= @category="Boolean" "true" | "false";

keyword Keywords = "enum" | "if" | "true" | "false" | "from" | "to" | "or" | "and";

lexical INTEGER
  = @category="Integer" [\-]? [0-9]+ !>> [0-9];

lexical FLOAT
  = INTEGER ([.][0-9]+?)?;

lexical ID
  = @category="Identifier" id: 
  ([a-zA-Z_$] [a-zA-Z0-9_$]* !>> [a-zA-Z0-9_$]) \ Keywords ;

lexical STRING
  = @category="String" "\"" ![\n\"]* "\"";

// syntax TypeOfPlace
//   = @category="Place" site: "site" | room: "room" | path: "path" | entrance: "entrance" | environment: "environment";

start syntax Level
  = level: "level" ID levelName "{" 
    TypeDef* typedefs
    Place+ places
    Connection* connections
    "}"
    ;

syntax Place
= place: ID? typeOfPlace ID placeName "{"
  EnumCall* enumCalls
  Place* subPlaces
  "}"
  ;
  
syntax EnumCall 
  = enumCallSingle: ID? chosenType ID name "=" ID chosenValue ";"
  |enumCallMultiple: ID? chosenType ID name "=" "[" {ID ","}* chosenValues "]" ";"
  > enumCallChoose: ID? chosenType ID name "=" ID chosenValue1 "or" ID chosenValue2 ";"
  ;

syntax Connection 
  = connection: "connection" "from" ID place1 "to" ID place2 "in" "direction" Value direction
  ;

// syntax Type
//     = boolean: "bool"
//     | string: "string"
//     | integer: "int"
//     | float: "float"
//     | customType: ID
//     ;

syntax TypeDef
    = typedef: "enum" ID name "=" "[" {Value ","}* values "]" ";"
    ;

syntax Value
    = boolValue: BOOLEAN boolValue
    | intValue: INTEGER intValue
    | floatValue: FLOAT floatValue
    | stringValue: STRING stringValue
    | enumValue: ID nameValue //enum value, no lookup
    | listValue: "[" {Value ","}* listValues "]"
    | setValue:"{" {Value ","}* setValues "}"
    ;
