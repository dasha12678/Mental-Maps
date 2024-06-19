

module Main

// import util::IDE;
// import vis::Figure;
import util::LanguageServer;
import util::IDEServices;
import util::Reflective;
import IO;

import parsing::Parser;
import parsing::TemplateSyntax;
import parsing::AST;
import ParseTree;

set[LanguageService] LTContributions() = {
    parser(parser(#start[Template], allowAmbiguity=true, hasSideEffects=true)), // register the parser function for the level template language
     outliner(templateOutliner)
  };

list[DocumentSymbol] templateOutliner(start[Template] input) {
  c = [symbol("<input.src>", DocumentSymbolKind::\file(), input.src, children=
      [ symbol("<stmt.src>", \method(), stmt.src) | /Statement stmt := input]
      )];
      println(c);
      return c;
}

//symbol("<functionName.src>", \function(), input.src) 

void wetest(start[Template] t) {
   t = \t.top;
   top-down-break visit(t) {
    case (Statement) `<NAME _> (<{Parameter ","}* _>)`:
    println("Statement");
  }
}

//funcCall(NAME _,list[Parameter]_) := input

// void wetestmore(start[Template] t) {
//    t = \t.top;
//     if (/funcCall(NAME _) := t) {
//     println("Statement");
//    }
//   }

// list[DocumentSymbol] myOutliner(start[Template] input) {
//   return [symbol("<input.src>", DocumentSymbolKind::\file(), input.src, children=[
//       *[outlineStatement(stmt) | /Statement stmt := input]
//   ])];
// }

// DocumentSymbol outlineStatement(Statement stmt) {
//   switch (stmt) {
//     case (Statement) `<NAME functionName> "(" {<Parameter parameters> ","}* ")"`:
//       return symbol("<functionName>", \function(), functionName.src);
//     case (Statement) ` "if" "(" <Parameter parameter> ")" {<Statement statementsif>}* "else()" {<Statement statementselse>}* "endIf()"`:
//       return symbol("<parameter>", \method(), parameter.src);
//     case (Statement) ` "#include" <LOCATION location>`:
//       return symbol("<location>", \module(), location.src);
//     default:
//       return symbol("unknown", \variable(), stmt.src); // handle unknown statements
//   }  
// }

public str LDName = "LevelTemplate";  //language name
public str LDExtension  = "lt" ;           //file extension
public str LDMainModule  = "Main" ;         //main module
public str LDMainFunction = "LTContributions";     //main function
PathConfig LDpcfg = pathConfig(srcs=[|project://my-dsl/src|]);

public void main(){

	registerLanguage(
		language(
			LDpcfg, LDName, LDExtension, LDMainModule, LDMainFunction)
			);
	
	println("IDE loaded.");
}
