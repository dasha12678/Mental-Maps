module mentalmapslanguage::Check

import IO;
import Type;
import mentalmapslanguage::Parser;
import mentalmapslanguage::SyntaxDefinition;
//import mentalmapslanguage::AST;
import Message; 

alias Env = map[str, list[Value]];

//build an Enum Environment (Env) for a level
//Collect all the enum definitions  - name and values it's allowed to take
// Env collect(start[Level] level) 
//   = ( "<name>": values | /(TypeDef) `enum <ID name> = [<{Value ","}* values>];` := level );

Env collect(start[Level] level) {
  Level topLevel = level.top;
  return (
    "<name>": values | /(TypeDef) `enum <ID name> = [<{Value ","}* values>];` := topLevel
  );
}

void wetest(start[Level] level) {
   level = \level.top;
   top-down-break visit(level) {
    case (TypeDef) `enum <ID _> = [<{Value ","}* values>];`: 
    println(values);
  }
}

/*
 * Checking level templates
 EnumCalls are either stored in places or statements
 */

// set[Message] check(start[Level] level)
//   = { *check(ec, env) 
//       | Place place <- level.top.places, // match each place
//         Statement statement <- (place.statements),  // statements within each place
//         EnumCall ec <- (statement.enumCalls)  // check enumCall within each statement
//     }
//   when Env env := collect(level);

/*
 * Checking enum calls
*/

// by default, there are no errors
// default set[Message] check(EnumCall _, Env _) = {};

// //Checking ERROR: Use does not have a def
// set[Message] check((EnumCall)`<ID chosenType> _;`, Env env)
//     = { error("Undefined enum instance", chosenType.src)}
//     when "<chosenType>" notin env;


//Checking WARNING: Def does not have a use
//set[Message] check((TypeDef)`enum <ID name> = [*<ID t>];`, TEnv env)
//    = { error("Def does not have a use", name.src) | t := name }; 

//Checking ERROR: Unrecognized value for the enum use
//set[Message] check((TypeDef)`enum <ID name> = [*<ID t>];`, TEnv env)
//    = { error("Unrecognized value for the enum use", name.src) | t := name }; 

/* 

THINGS TO CHECK:
*Every use is contained in the enum def
*Every use has a def 
*Every def has a use 

*/

void printEnv(Env env) {
    for (str x <- env) {
        println("<x>: <env[x]>");
    }
}

void checkSnippets() {
    start[Level] lvl = parseProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/mineAnnotated.mm|);
    printEnv(collect(lvl));
}
 