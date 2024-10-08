module mentalmapslanguage::Check

import IO;
import Type;
import Map;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;
import Message; 
import ParseTree;

alias Env = map[str, TypeDef]; 

Env collect(Level level){
  Env env = ();
  visit(level){
    case TypeDef typedef: env["<typedef.name.name>"] = typedef; 
  }
  println(domain(env));
  return env;
}

set[Message] check(Level level){
  set[Message] messages = {};

    messages += {
    *{*check(decl, collect(level)) | Declaration decl <- level.declarations},
    *{*check(typedef, collect(level)) | TypeDef typedef <- level.typedefs}
    };

  return messages;
}

// by default, there are no errors
default set[Message] check(Declaration _, Env _) = {};

// //Checking ERROR: Use of custom type does not have a def
set[Message] check(Declaration decl, Env env)
  = { error("Undefined type", decl.name.src) }
  when "<decl.name.name>" notin env;

 //Checking WARNING: Def does not have a use
set[Message] check(TypeDef typedef, Env env) {
  set[Message] messages = {};

  // if ("<decl.name.name>" notin env) { 
  //   messages += { warning("Unused type", typedef.name.src) };
  // }

visit (typedef) {
  case MemberDecl member: 
    switch (member) {
      case memberDecl(_, typeOf, _): {
        if ("<typeOf.name>" notin domain(env)) { 
          messages += { error("Undefined type", typeOf.src) }; 
        }
      }
    }
}
  return messages;
}

void wetest(Level level){
  visit (level) {
  case MemberDecl member: 
    switch (member) {
      case memberDecl(_, typeOf, _): {
        println("<typeOf>");
      }
    }
}
}



