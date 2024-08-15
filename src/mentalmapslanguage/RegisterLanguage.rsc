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
module mentalmaps


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

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "LevelTemplate", "lt", "Main", "LTContributions")
			);
	
	println("IDE loaded.");
}
