module compiler::AST

data FeatureModel
  = model(list[Feature] features);

data Feature
  = feature(bool isRoot, QualifiedID id, Mod modifier, list[Edge] edges, list[ExtraEdge] extraEdges, str mapping, str newline, str annotation)
  ;
	
data Mod
  = xor()
  | or()
  ;
  
data Edge
  = mandatory(QualifiedID target)
  | optional(QualifiedID target)
  | subfeature(QualifiedID target)
  ;

data QualifiedID
= qualifiedID(str parent, str subfeature);

data ExtraEdge
	= excludes(str target)
	| requires(str target)
	;
	