module compiler::Check

import IO;
import Type;
import compiler::Parser;
//import compiler::SyntaxDefinition;
import compiler::AST;
import Message; 
import ParseTree;
import Set;
import List;
import String;
import Map;

alias Env1 = map[Feature features, list[ID] values];
Env1 collect1(FeatureModel fm) 
= (
  feature : [edge.target | Edge edge <- feature.edges] |  Feature feature <- fm.features
  );



alias Env = map[ID keys, list[ID] values]; //map of defs of functions and the uses of functions

Env collect(FeatureModel fm) 
= (
  feature.id : [edge.target | Edge edge <- feature.edges] |  Feature feature <- fm.features
  );

/*
 * Checking feature models 
*/

set[Message] check(FeatureModel fm)
  = { 
    *check(feature, env),
    *check(edge, env)
      | Feature feature <- fm.features,
        Edge edge <- feature.edges
    }  
  when Env env := collect(fm);

// /*
//  * Error messages
// */

// by default, there are no errors
default set[Message] check(Edge _, Env _) = {};

//Checking ERROR: Use of enum does not have a def
set[Message] check(Edge edge, Env env) {
  if (edge.target.name notin {feature.name | ID feature <- env.keys}){
    return { error("Feature has not been defined", edge.target.src) };
  }
  return {};
}

// //Checking WARNING: Def does not have a use
// set[Message] check(Feature feature, Env env) {
//   println("Im here");
//   // if (feature.isRoot){
//   //   return {};
//   //  }
//   if (feature.id.name notin {edge.name | list[ID] edges <- env.values, ID edge <- edges}) { 
//     println("here");
//     return {error("Unused feature", feature.id.src)};
//   }
//   return {};
// }

//Checking ERROR: object composition
set[Message] check(Feature feature, Env env) {
  for (Edge edge <- feature.edges) {
      splitEdge = split(".", edge.target.name);
      splitFeature = split(".", feature.id.name);
      if (splitEdge[0] != splitFeature[1]) {
        return {error("<splitEdge[1]> must be a subfeature of <splitFeature[1]>", edge.target.src)};
      }
  }
  return {};
}

// // Checking ERROR: name uniqueness
// set[Message] check(Feature feature, Env env) {
//     return {};
// }

//Checking ERROR: uniqueness - if a feature gets used twice in the same edge




//store/retrieve?
//think about the needs of the generator 


void wetest(FeatureModel fm){
Feature feature = getOneFrom(collect1(fm));
println(feature);
check(feature, collect(fm));
}

bool wetest1(FeatureModel fm){
ID name = id("UnexploredLevel.Enemy", src=|file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/examples/FeatureModelSmallAnnotated.fm|(145,20,<3,8>,<3,28>));
return name in collect(fm).keys;
}