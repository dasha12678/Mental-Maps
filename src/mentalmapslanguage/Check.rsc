module mentalmapslanguage::Check

import IO;
import Type;
import Map;
import String;
import List;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;
import Message; 
import ParseTree;

alias Env = map[str, TypeDef]; // types and their typedefs (RIGHT NOW ONLY GLOBAL)
alias Env1 = map[str, list[str]]; //struct and its members eg. Place [typeOf, name, structure]
alias Env2 = map[str, str]; //use def  - type and how it's initiated eg. Place place ; str name
alias Env3 = map[str, list[Value]]; //enums and their values eg. Size [small, medium, large]

// collect types and their typedefs
tuple[Env, set[Message]] collect(Level level) {
  Env env = ();
  set[Message] messages = {};

  for (TypeDef typedef <- level.typedefs) {
    if (typedef.name.name in env) {
      messages += { error("Type <typedef.name.name> is already defined", typedef.name.src) }; // TO DO: add defined at <loc>
    }
    env[typedef.name.name] = typedef;

    // visit(typedef) { // TO DO: FOR LOCALLY SCOPED TYPES - write cases enum, struct, ... 
    //   case typeDef(typedef1): {
    //     env[typedef1.name.name] = typedef1;
    //   }
    // }
  }
  return <env, messages>;
}

// Collect struct and its members
tuple[Env1, set[Message]] collect1(Level level) {
  Env1 env = ();
  set[Message] messages = {};

  visit(level) {
    case TypeDef structdef : structDef(_, _, _, _) : {
      env += collectStruct(structdef)[0];
      messages += collectStruct(structdef)[1];
    }
  }
  return <env, messages>;
}

// For a struct AND ITS CHILDREN, collects its members 
tuple[Env1, set[Message]] collectStruct(TypeDef structdef) {
  Env1 env = ();
  set[Message] messages = {};
  env[structdef.name.name] = [];

  visit(structdef) {
    case typeDef(typedef): {
      if (typedef.name.name in env[structdef.name.name]) {
        messages += { error( "Type <typedef.name.name> is already used in the struct <structdef.name.name>", typedef.name.src) }; 
      }
    env[structdef.name.name] += typedef.name.name;
    }

    case memberDecl(_, typeOf, name) : {
      if (name.name in env[structdef.name.name]) {
        messages += { error( "Type <name.name> is already used in the struct <structdef.name.name>", name.src) }; 
      }
    env[structdef.name.name] += name.name; 
    }
  }
  return <env, messages>;
}

// Collect use def  - type and how it's initiated eg. Place place ; str name
map[str, str] collect2(Level level) {
  Env2 env = ();

  visit(level) {
    case memberDecl(_, typeOf, name): {
      env[typeOf.name] = name.name;
    }
  } 
  return env;
}

//Auxiliary lookup function for collect2
str lookup(str name, Env2 env){
  for (str key <- env) {
    if (env[key] == name) {
      return key;
    }
  }
  return "<name> not found";
}

// Collect enums and their values
tuple[Env3, set[Message]] collect3(Level level) {
  Env3 env = ();
  set[Message] messages = {};

  visit(level) {
    case enumDef(_, name, values): {
      env[name.name] = values;
    }
  }
  return <env, messages>;
}

//auxiliary function for adt Value
str getValueAsString(Value v) {
  switch (v) {
    case boolValue(_): return "<v.boolValue>";
    case intValue(_): return "<v.intValue>";
    case floatValue(_): return "<v.floatValue>";
    case stringValue(_): return "<v.stringValue>";
    case declValue(_): return "<v.nameValue>";
  }
  return "unknown";
}

//auxiliary function for creating a nice list of values
list[value] getValuesWithoutLocation(list[Value] values) {
  return [extractValue(v) | v <- values];
}

value extractValue(Value v) {
  switch (v) {
    case boolValue(boolVal): return boolVal;
    case intValue(intVal): return intVal;
    case floatValue(floatVal): return floatVal;
    case stringValue(strVal): return strVal;
    case declValue(nameVal): return nameVal;
  }
  return "unknown";
}

//////////////////////// CHECKERS //////////////////////////////////////////////////

set[Message] check(Level level) {
  set[Message] messages = {};

  for (Declaration decl <- level.declarations) {
    messages += check(decl, "Level", collect1(level)[0], collect2(level), collect3(level)[0]); 
  }

  for (TypeDef typedef <- level.typedefs) {
    messages += check(typedef, collect(level)[0]);
  }

  messages += collect(level)[1];
  messages += collect1(level)[1];

  return messages;
}

// by default, there are no errors
default set[Message] check(Declaration _, str _, Env1 _) = {};

/////// DECLARATION ///////
set[Message] check(Declaration decl, str parent, Env1 env, Env2 env2, Env3 env3) {
  set[Message] messages = {}; 

  switch(decl) {
    case ifElse(_, _, _, _): { 
      println("");
    }
  
    default: {
      if (decl.name.name notin env[parent]) {
        messages += { error("Expected fields <env[parent]> for <parent>, but found <decl.name.name>", decl.name.src) }; // TO DO: display expected in nicer format
      }

      //for enums
      if (lookup(decl.name.name, env2) in env3) { 
        if (decl.chosenValue notin env3[lookup(decl.name.name, env2)]) {
          messages += { error("Expected fields for enum <getValuesWithoutLocation(env3[lookup(decl.name.name, env2)])>, but found <getValueAsString(decl.chosenValue)>", decl.chosenValue.src) }; //TO DO: display in a nicer format 
        } //TO DO: add lists/sets of enums also
      }

      //for structs
      if (lookup(decl.name.name, env2) in env){
        for (Declaration newdecl <- decl.declarations) {
          messages += check(newdecl, lookup(decl.name.name, env2), env, env2, env3);
        }
      }
    }
  }

  return messages;
}

 ////// TYPEDEF ////////
set[Message] check(TypeDef typedef, Env env) {
  set[Message] messages = {};

  visit(typedef) {

    case memberDecl(_, typeOf, name): {
      if (typeOf.name notin env) { 
        messages += { error("Undefined type", typeOf.src) }; 
      }
    } 
  }
  return messages;
}
