module compiler::AST

data FeatureModel
  = model(list[Feature] features);

data Feature
  = feature(bool isRoot, ID id, Mod modifier, list[Edge] edges, list[ExtraEdge] extraEdges)
  ;
	
data Mod
  = xor()
  | or()
  ;
  
data Edge
  = mandatory(ID target)
  | optional(ID target)
  | subfeature(ID target)
  ;

data ExtraEdge
	= excludes(ID target)
	| requires(ID target)
	;
	
data ID
  = id(str name);
  