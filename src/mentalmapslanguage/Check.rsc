module mentalmapslanguage::Check

import IO;
import Type;
import mentalmapslanguage::Parser;
import mentalmapslanguage::SyntaxDefinition;
import Message; 
import ParseTree;

alias Env = map[str, list[str]]; //map of def names and the values that it takes

Env collect(start[Level] level) 
= (
  "<typedef.name>" : ["<v>" | Value v <- (typedef.values)] |  TypeDef typedef <- level.top.typedefs
  );

/*
 * Checking level
 */

set[Message] check(start[Level] level){
  set[Message] messages = {};

  for (Env env := collect(fm)[0]){
  messages += {
    *{*check(decl, env) | Struct struct <- level.top.places},
    *{*check(decl, env) | Declaration ec <- (place.declarations)}
  };

  messages += collect(level);
  }

return messages;
}

/*
 * Checking enum calls
*/

// by default, there are no errors
default set[Message] check(Declaration _, Env _) = {};

// //Checking ERROR: Use of enum does not have a def
set[Message] check(Declaration decl, Env env)
  = { 
    error("Undefined type", decl.chosenType.src)
    }
  when "<decl.chosenType>" notin env;

 //Checking WARNING: Def does not have a use
set[Message] check(Declaration decl, Env env)
  = { 
    warning("Undefined type", decl.chosenType.src)
    }
  when "<decl.chosenType>" notin env;


 //Checking WARNING: Def does not have a use
//set[Message] check((TypeDef)`enum <ID name> = [*<ID t>];`, TEnv env)
//    = { error("Def does not have a use", name.src) | t := name }; 

//Checking ERROR: Unrecognized value for the enum use
//set[Message] check((TypeDef)`enum <ID name> = [*<ID t>];`, TEnv env)
//    = { error("Unrecognized value for the enum use", name.src) | t := name }; 