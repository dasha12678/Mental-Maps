module compiler::AST

data FeatureModel
  = model(list[Feature] features);

data Feature
  = feature(str typeOf, ID id, Mod modifier, list[Edge] edges, list[ExtraEdge] extraEdges, str mapping, str newline, str annotation, loc src =  |unknown:///|)
  ;
	
data Mod
  = xor()
  | or()
  ;
  
data Edge
  = mandatory(ID target, loc src =  |unknown:///|)
  | optional(ID target, loc src =  |unknown:///|)
  | subfeature(ID target, loc src =  |unknown:///|)
  ;

data ExtraEdge
	= excludes(ID target, loc src =  |unknown:///|)
	| requires(ID target, loc src =  |unknown:///|)
	;

data ID
  = id(str name, loc src = |unknown:///|);

	