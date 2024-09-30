module featuremodellang::Check

import IO;
import Type;
import featuremodellang::Parser;
//import compiler::SyntaxDefinition;
import featuremodellang::AST;
import Message; 
import ParseTree;
import Set;
import List;
import String;
import Map;

alias Env = map[ID keys, list[ID] values]; //map of defs of functions and the uses of functions

tuple[Env, set[Message]] collect(FeatureModel fm) {
  Env env = ();
  set[Message] messages = {};

  for (Feature feature <- fm.features) {
    if (feature.id.name in {key.name | ID key <- domain(env)}) {
      messages += { error("Feature already exists", feature.id.src) }; // Checking ERROR: name uniqueness
    }
    env[feature.id] = [];

    for (Edge edge <- feature.edges){
      if (edge.target.name in {edge.name | ID edge <- env[feature.id]}) {
        messages += { error("Subfeature already exists", edge.target.src)}; //Checking ERROR: uniqueness - if a feature gets used twice in the same edge
      }
    env[feature.id] += edge.target;
    }
  }

  return <env, messages>;
}

/*
 * Checking feature models 
*/

set[Message] check(FeatureModel fm){
  set[Message] messages = {};

  for (Env env := collect(fm)[0]){
  messages += {
    *{*check(feature, env) | Feature feature <- fm.features},
    *{*check(edge, env) | Feature feature <- fm.features, Edge edge <- feature.edges}
  };

  messages += collect(fm)[1];
  }

return messages;
}

// /*
//  * Error messages
// */

// by default, there are no errors
default set[Message] check(Edge _, Env _) = {};

//Checking edges
set[Message] check(Edge edge, Env env) {

  if (edge.target.name notin {feature.name | ID feature <- env.keys}){
    return { error("Feature has not been defined", edge.target.src) }; //Checking ERROR: Use of enum does not have a def
  }
  return {};
}

//Checking features
set[Message] check(Feature feature, Env env) {

  set[Message] messages = {};

  //Checker 1
  if (feature.isRoot == false){
    if (feature.id.name notin {edge.name | list[ID] edges <- env.values, ID edge <- edges}) { 
      messages += {warning("Unused feature", feature.id.src)}; //Checking WARNING: Def does not have a use
    }
  }

  //Checker 2
  for (Edge edge <- feature.edges) {
    splitEdge = split(".", edge.target.name);
    splitFeature = split(".", feature.id.name);
    if (splitEdge[0] != splitFeature[1]) {
      messages += {error("<splitEdge[1]> must be a subfeature of <splitFeature[1]>", edge.target.src)}; //Checking ERROR: object composition
    }
  }

  return messages;
}


