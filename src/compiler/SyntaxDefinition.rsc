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
  = id: [a-zA-Z*#^@$%&=*+]+ !>> [a-zA-Z*#^@$%&=*+] \ Keywords;

lexical String 
= "\"" ![\n\"]* "\"";
//![\"]*;

start syntax FeatureModel
  = model: Feature* features;

syntax Feature
  = feature: "root"? feature "feature" QualifiedID id Mod mod "{" Edge* edges ExtraEdge* extraEdges "}" String mapping ID? newline String annotation
  ;

syntax Mod
  = xor: "xor" //alternative
  | or: "or"  //inclusive or
  | or:       //empty alternative
  ;

syntax Edge
  = mandatory: "--." QualifiedID target
  | optional: "--o" QualifiedID target
  | subfeature: "--"  QualifiedID target;

syntax QualifiedID
= qualifiedID: ID parent "." ID subfeature;
  
syntax ExtraEdge
	= excludes: "-.-." ID target
	| requires: "_._." ID target;
	
keyword Keywords
	= "feature" | "root";
	  