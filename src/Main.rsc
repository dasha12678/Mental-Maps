//////////////////////////////////////////////////////////////////////////////
//
// Part of Mental Maps DSL
// @brief   The AST used for parsing Ludoscope Mini files ().lm. 
//			This file contains the data structure needed for imploding
//			a parsed .lm tree.
// @author  Daria Protsenko - daria.protsenkoo@gmail.com
// @date    10-10-2021
//
//////////////////////////////////////////////////////////////////////////////
module Main


// import util::IDE;
// import vis::Figure;
import util::LanguageServer;
import util::Reflective;
import IO;

import parsing::TemplateSyntax;
import ParseTree;

set[LanguageService] LTContributions() = {
    parser(Tree(str txt, loc src) {
      return parse(#start[Template], txt, src, allowAmbiguity=true);
    }),
      
     outliner(list[DocumentSymbol] (start[Template] input) {
        c = [symbol("<input.src.path>", DocumentSymbolKind::\file(), input.src, children=
            [ symbol("<stmt>", \method(), stmt.src) | /Statement stmt := input.top ])];
        return c;
     })
  }; 


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

//I'm making a change 

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "LevelTemplate", "lt", "Main", "LTContributions")
			);
	
	println("IDE loaded.");
}
