module mentalmapslanguage::Check

import IO;
import Type;
import mentalmapslanguage::Parser;
import mentalmapslanguage::SyntaxDefinition;
//import mentalmapslanguage::AST;
import Message; 

alias Env = map[str, list[str]];

//build an Enum Environment (Env) for a level
//Collect all the enum definitions  - name and values it's allowed to take
// Env collect(start[Level] level) 
//   = ( "<name>": values | /(TypeDef) `enum <ID name> = [<{Value ","}* values>];` := level );

// Env collect1(start[Level] level) {
//   Level topLevel = level.top;
//   return (
//     "<name>": values | /(TypeDef) `enum <ID name> = [<{Value ","}* values>];` := topLevel
//   );
// }

void wetest(start[Level] level) {
   level = \level.top;
   top-down-break visit(level) {
    case (TypeDef) `enum <ID _> = [<{Value ","}* values>];`: 
    println(values);
    //type: \iter-seps(sort("Value"),[layouts("Layout"),lit(","),layouts("Layout")])
  }
}

void wetest1(Level) {
  top-down-break visit(Level) {
    case typedef(name, values):  // /TypeDef typedef: descendant pattern
    println(values);
    //type: list(adt("Value",[]))
  }
}

// Env wetest2(Level level) {
//   Env result = ();
//   top-down-break visit(level) {
//     case typedef(name, values):
//       result["<name>"] = values;
//   }
//   return result;
// }

Env collect(start[Level] level) = (
  "<typedef.name>" : ["<v>" | Value v <- (typedef.values)] |  TypeDef typedef <- level.top.typedefs
              //Value v <- (typedef.values) //type: sort("Value")
);

void wetest4(start[Level] level) {
  list[Value] mylist = [];
  for (TypeDef typedef <- level.top.typedefs){
    for (Value v <- typedef.values){
      //println(typeOf(v)); 
      mylist = [v];
      println(mylist);
    }
  }
}

void wetest5(start[Level] level) {
  for (Place place <- level.top.places){
    for (Statement statement <- (place.statements)){
        println(statement); 
    }
  }
}

/*
 * Checking level templates
 EnumCalls are either stored in places or statements
 */

set[Message] check(start[Level] level)
  = { *check(ec, env) 
      | Place place <- level.top.places, // match each place
        Statement statement <- (place.statements),  // statements within each place
        EnumCall ec <- (statement.enumCalls)  // check enumCall within each statement
    }
  when Env env := collect(level);

/*
 * Checking enum calls
*/

// by default, there are no errors
default set[Message] check(EnumCall _, Env _) = {};

// //Checking ERROR: Use does not have a def
// set[Message] check(EnumCall ec, Env env)
//     = { error("Undefined enum instance", ec.chosenType.src)}
//     when "<ec.chosenType>" notin env;


void mySummarizer(start[Level] input) {
  messages = {<m.at, m> | Message m <- check(input)};
  println(messages);
}

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
 