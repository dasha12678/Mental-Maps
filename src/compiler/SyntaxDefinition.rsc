module compiler::SyntaxDefinition

//multiplicity
//mandatory, optional 

//import lang::std::Layout;

lexical WhitespaceAndComment       
   = [\ \t\n\r]     
   | @category="Comment" ws3: "//" ![\n]* $       
   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r/];

// lexical ID
//   = id: [a-zA-Z*#^@$%&=*+.]+ !>> [a-zA-Z*#^@$%&=*+] \ Keywords;

lexical NAME
  = name: ([a-zA-Z_$] [a-zA-Z0-9_$]+ !>> [a-zA-Z0-9_$]) \ Keywords;

lexical String 
= "\"" ![\n\"]* "\"";

start syntax FeatureModel
  = model: Feature* features;

syntax Feature
  = feature: "root"? feature "feature" ID id Mod mod "{" Edge* edges ExtraEdge* extraEdges "}" String mapping NAME? newline String annotation
  ;

syntax Mod
  = xor: "xor" //alternative
  | or: "or"  //inclusive or
  | or:       //empty alternative
  ;

syntax Edge
  = mandatory: "--." ID target
  | optional: "--o" ID target
  | subfeature: "--"  ID target;
  
syntax ExtraEdge
	= excludes: "-.-." ID target
	| requires: "_._." ID target;
	
keyword Keywords
	= "feature" | "root";

syntax ID
  = id: (NAME "." NAME ) name;  // Matches qualified names like `UnexploredLevel.UnexploredLevel`
	  