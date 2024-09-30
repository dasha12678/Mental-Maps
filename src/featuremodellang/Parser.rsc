module featuremodellang::Parser

import ParseTree;
import featuremodellang::AST;
import featuremodellang::SyntaxDefinition;

alias AbstractPipeline = featuremodellang::AST::FeatureModel;

public start[FeatureModel] FM_parse() = 
  parse(#start[FeatureModel], |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/examples/FeatureModelSmall.fm|);

public start[FeatureModel] FM_parse1(){
  parseTree = parse(#start[FeatureModel], |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/examples/FeatureModelSmall.fm|);
  return parseTree;
}

public start[FeatureModel] FM_parse(str src, loc file) = 
  parse(#start[FeatureModel], src, file);
  
public start[FeatureModel] FM_parse(loc file) = parse(#start[FeatureModel], file); 

public FeatureModel FM_implode(Tree tree)
  = implode(#FeatureModel, tree);

public FeatureModel FM_parse_implode(){
    parseTree = FM_parse(); 
    impl = implode(#AbstractPipeline, parseTree);
    return impl;
}
