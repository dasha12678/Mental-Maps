module compiler::AST

data FeatureModel
  = model(list[Feature] features);

data Feature
  = feature(bool isRoot, str id, Mod modifier, list[Edge] edges, list[ExtraEdge] extraEdges)
  ;
	
data Mod
  = xor()
  | or()
  ;
  
data Edge
  = mandatory(str target)
  | optional(str target)
  | subfeature(str target)
  ;

data ExtraEdge
	= excludes(str target)
	| requires(str target)
	;
	