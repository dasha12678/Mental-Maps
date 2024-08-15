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
keyword Keywords = DIRECTION | SIZE | TypeOfPlace | "enum" | "if" | "true" | "false" | "from" | "to" | "in" | "direction";

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
  = @category="Size" tiny: "tiny" | small: "small" | medium: "medium" | large: "large";

//direction
lexical DIRECTION
  = @category="Direction" north: "North" | east: "East" | south: "South" | west: "West" | northeast: "Northeast" | northwest: "Northwest" | southeast: "Southeast" | southwest: "Southwest";

syntax TypeOfPlace
  = @category="Place" site: "site" | room: "room" | path: "path" | entrance: "entrance" | environment: "environment";

//Level has at least one Place and zero or more Connections
start syntax Level
  = level: "level" NAME name "{" 
    TypeDef* typedefs
    Annotation* annotations
    Place+ places
    Connection* connections
    "}"
    ;

//Place block consists of statements
syntax Place
= place: TypeOfPlace typeOfPlace NAME? name "{"
  Statement* statements
  Place* subPlaces
  "}"
  ;

//Types of statements
syntax Statement
  = annotation: Annotation annotation
  | location: "location" DIRECTION location";"
  | size: "size" SIZE size ";"
  | isGoal: "isGoal" ";"
  | antechamber: "antechamber" ";"
  | lock: "lock" NAME lock ";"
  | key: "key" NAME key";"
  | style: "style" NAME style ";" 
  | item: "item" NAME item ";"
  | direction: "direction" DIRECTION direction ";"
  | encounter: "encounter" NAME encounter ";"
  | storyElement: "storyElement" NAME storyElement ";"
  ;

syntax Annotation
    = annotation: "extra" "{"
    EnumCall* enumCalls
    "}"
    ;

syntax EnumCall 
  = enumCallSingle: Type chosenType NAME name "=" NAME chosenValue ";"
  |enumCallMultiple: Type chosenType NAME name "=" "[" {NAME ","}* chosenValues "]" ";"
  ;

//Connection
syntax Connection 
  = connection: "connection" "from" NAME site1 "to" NAME site2 "in" "direction" DIRECTION direction
  ;

//Type checking 
syntax Type
    = boolean: "bool"
    | string: "string"
    | integer: "int"
    | float: "float"
    | customType: NAME
    ;

syntax TypeDef
    = typedef: "enum" NAME name "=" "[" {Value ","}* values "]" ";"
    ;

syntax Value 
    = boolValue: BOOLEAN
    | intValue: INTEGER
    | floatValue: FLOAT
    | stringValue: STRING
    | enumValue: NAME //enum value, no lookup
    | listValue: "[" {Value ","}* "]"
    | setValue:"{" {Value ","}* "}"
    ;

