module compiler::SyntaxDefinition

//multiplicity
//mandatory, optional 

//import lang::std::Layout;

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

lexical ID
  = id: [a-zA-Z*#^@$%&=.*+]+ !>> [a-zA-Z*#^@$%&=.*+] \ Keywords;
lexical String = ![\"]* ;

start syntax FeatureModel
  = model: Feature*;

syntax Feature
  = feature: "root"? "feature" ID Mod "{" Edge* ExtraEdge*"}" Mapping Annotation;

syntax Annotation
  = annotation: "annotation:" String ("(" String ")")?;

syntax Mapping
  = mapping: "mapping:" ID;

syntax Mod
  = xor: "xor" //alternative
  | or: "or"  //inclusive or
  | or:       //empty alternative
  ;

syntax Edge
  = mandatory: "--." ID
  | optional: "--o" ID
  | subfeature: "--" ID
  ;
  
syntax ExtraEdge
	= excludes: "-.-." ID
	| requires: "_._." ID;
	
keyword Keywords
	= "RULES" | "OBJECTS" | "LEGEND" | "COLLISIONLAYERS" 
	| "WINCONDITIONS" | "LEVELS" | "title" | "author" 
	| "homepage" | "or" | "\<" | "\>" | "^" | "v" | "Some"
	| "All" | "No"|"on" | "message" | "and" | "...";
	  