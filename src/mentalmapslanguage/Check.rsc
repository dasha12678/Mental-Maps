module mentalmapslanguage::Check

import IO;
import Type;
import mentalmapslanguage::Parser;
import mentalmapslanguage::SyntaxDefinition;
import Message; 
import ParseTree;

alias Env = map[str, list[str]];

Env collect(start[Level] level) 
= (
  "<typedef.name>" : ["<v>" | Value v <- (typedef.values)] |  TypeDef typedef <- level.top.typedefs
  );

/*
 * Checking level templates
 EnumCalls are stored in places
 */

set[Message] check(start[Level] level)
  = { 
    *check(ec, env) 
      | Place place <- level.top.places, // match each place
        EnumCall ec <- (place.enumCalls) // enum calls within each place
    }  
  when Env env := collect(level);

/*
 * Checking enum calls
*/

// by default, there are no errors
default set[Message] check(EnumCall _, Env _) = {};

// //Checking ERROR: Use of enum does not have a def
set[Message] check(EnumCall ec, Env env)
  = { 
    error("Undefined type", ec.chosenType.src)
    }
  when "<ec.chosenType>" notin env;

 