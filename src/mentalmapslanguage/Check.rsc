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

alias Env3 = map[str, list[str]]; //enums and their values eg. Size [small, medium, large]

tuple[Env, set[Message]] collect(Level level) {
  Env env = ();
  set[Message] messages = {};

  for (TypeDef typedef <- level.typedefs){
        //Checking ERROR: typedef uniqueness
        if (typedef.name.name in env) {
          messages += { error("Type <typedef.name.name> is already defined", typedef.name.src) }; // TO DO: add defined at <loc>
        }
    env[typedef.name.name] = typedef;

      // visit(typedef) { //TO DO: FOR LOCALLY SCOPED TYPES - write cases enum, struct, ... 
      //   case typeDef(typedef1): {
      //     env[typedef1.name.name] = typedef1;
      //   }
      // }
  }
  return <env, messages>;
}

tuple[Env1, set[Message]] collect1(Level level) {
    Env1 env = ();
    set[Message] messages = {};

    visit(level){
      case TypeDef typedef:
          switch(typedef){
            case structDef(_, _, name, members): {
               env += collectStruct(typedef)[0];
               messages += collectStruct(typedef)[1];
            }
          }
    }
    return <env, messages>;
}


//for a struct AND ITS CHILDREN, collects its members 
tuple[Env1, set[Message]] collectStruct (TypeDef structdef) {
  Env1 env = ();
  set[Message] messages = {};
  env[structdef.name.name] = [];
  for (Member member <- structdef.members) {
    visit(member){
      case MemberDecl memberDecl: {
        switch (memberDecl) {
            case typeDef(typedef): {
                switch (typedef) {
                    case enumDef(Mod _, ID enumname, list[Value] values): {
                        if (enumname.name in env[structdef.name.name]) {
                            messages += { error("Type <enumname.name> is already used in the struct <structdef.name.name>", enumname.src) }; 
                        }
                        env[structdef.name.name] += enumname.name;
                    }
                    case structDef(bool _, Mod _, ID structname, list[Member] members): {
                        if (structname.name in env[structdef.name.name]) {
                            messages += { error("Type <structname.name> is already used in the struct <structdef.name.name>", structname.src) }; 
                        }
                        env[structdef.name.name] += structname.name;
                    }
                    default: {
                        // Checking Error: member uniqueness
                        if (typedef.name.name in env[structdef.name.name]) {
                            messages += { error("Type <typedef.name.name> is already used in the struct <structdef.name.name>", typedef.name.src) }; 
                        }
                        env[structdef.name.name] += typedef.name.name;
                    }
                }
            }
            case memberDecl(_, _, name1): {
                // Checking Error: member uniqueness
                if (name1.name in env[structdef.name.name]) {
                    messages += { error("Identifier <name1.name> is already used in the struct <structdef.name.name>", name1.src) }; 
                }
                env[structdef.name.name] += name1.name;
            }
        }
    }
}
}
return <env, messages>;
}

set[Message] check(Level level){
  set[Message] messages = {};

    for (Declaration decl <- level.declarations){
    messages += check(decl, "Level", collect1(level)[0]); //visit first level of nodes

    // switch (decl) {
    //   case declStruct(_, declarations): {
    //   messages += {*check(nesteddecl, capitalize(decl.name.name), collect1(level)[0]) | Declaration nesteddecl <- declarations};   
    //   }
    // }
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

///////DECLARATION///////
set[Message] check(Declaration decl, str parent, Env1 env){
  set[Message] messages = {}; 
  //Checking ERROR: type mismatch error (same as use does not have a def?)
  switch(decl){
   case ifElse(_, _, _, _): { 
    println("");
    }
  case declBasic(_, chosenValue): {
    if ("<decl.name.name>" notin env[parent]){
    messages += { error("Expected fields <env[parent]> for <parent>, but found <decl.name.name>", decl.name.src) }; //TO DO: display expected in nicer format
  }
  }
  case declList(name, listValues): {
    if ("<decl.name.name>" notin env[parent]){
    messages += { error("Expected fields <env[parent]> for <parent>, but found <decl.name.name>", decl.name.src) }; //TO DO: display expected in nicer format
  }
  }
  case declSet(name, setValues): {
    if ("<decl.name.name>" notin env[parent]){
    messages += { error("Expected fields <env[parent]> for <parent>, but found <decl.name.name>", decl.name.src) }; //TO DO: display expected in nicer format
  }
  }
  case declStruct(name, declarations): {
    if ("<decl.name.name>" notin env[parent]){
    messages += { error("Expected fields <env[parent]> for <parent>, but found <decl.name.name>", decl.name.src) }; //TO DO: display expected in nicer format
    }
    for (Declaration newdecl <- declarations){
    messages += check(newdecl, capitalize(name.name), env);
  }
  }
  }
  return messages;
}

 //////TYPEDEF////////
set[Message] check(TypeDef typedef, Env env) {
  set[Message] messages = {};

  // if ("<decl.name.name>" notin env) { 
  //   messages += { warning("Unused type", typedef.name.src) };
  // }

  //Checking ERROR: Use of custom type does not have a def
  visit (typedef) {
  case MemberDecl member: {
    switch (member) {
      case memberDecl(_, typeOf, _): {
        if (typeOf.name notin env) { 
          messages += { error("Undefined type", typeOf.src) }; 
        }
      }
    }
  }
}
  return messages;
}



