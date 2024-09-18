module compiler::Parser

import ParseTree;
import compiler::AST;
import compiler::SyntaxDefinition;

alias AbstractPipeline = compiler::AST::FeatureModel;

public start[FeatureModel] FM_parse() = 
  parse(#start[FeatureModel], |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/examples/FeatureModelSmallAnnotated.fm|);

public start[FeatureModel] FM_parse1(){
  parseTree = parse(#start[FeatureModel], |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/examples/FeatureModelSmallAnnotated.fm|);
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
