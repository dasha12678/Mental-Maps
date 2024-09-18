module compiler::Check

import IO;
import Type;
import compiler::Parser;
import compiler::SyntaxDefinition;
//import compiler::AST;
import Message; 
import ParseTree;
import Set;
import List;
import String;

alias Env = map[str keys, list[str] values]; //map of defs of functions and the uses of functions

Env collect(start[FeatureModel] fm) 
= (
  "<feature.id>" : ["<edge.target>" | Edge edge <- feature.edges] |  Feature feature <- fm.top.features
  );

/*
 * Checking feature models 
*/

set[Message] check(start[FeatureModel] fm)
  = { 
    *check(feature, env),
    *check(edge, env)
      | Feature feature <- fm.top.features,
        Edge edge <- feature.edges
    }  
  when Env env := collect(fm);

// /*
//  * Error messages
// */

// by default, there are no errors
default set[Message] check(Edge _, Env _) = {};

//Checking ERROR: Use of enum does not have a def
set[Message] check(Edge edge, Env env)
  = { error("Feature has not been defined", edge.target.src) }
  when "<edge.target>" notin env;

//Checking WARNING: Def does not have a use
set[Message] check(Feature feature, Env env) {
  for (feature(isRoot, _, _, _, _, _, _, _) := feature) {
   if (isRoot == true){
   return {};
   }
  if ("<feature.id>" notin toSet(concat(toList(env.values)))) { 
    return {error("Unused feature", feature.id.src)};
  }
  }
    return {};
}

//Checking ERROR: object composition
set[Message] check(Feature feature, Env env) {
  for (Edge edge <- feature.edges) {
    for (mandatory(target) := edge, optional(target) := edge, subfeature(target) := edge) {
      if (target.parent != feature.id.subfeature) {
        return {error("<edge.target> must be a subfeature of <feature.id>", edge.target.src)};
      }
    }
  }
  return {};
}

// Checking ERROR: name uniqueness
set[Message] check(Feature feature, Env env) {
    return {};
}

//Checking ERROR: uniqueness - if a feature gets used twice in the same edge




//store/retrieve?
//think about the needs of the generator 