//from Georgia's main 

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
  return [symbol("<input.src>", DocumentSymbolKind::\file(), input.src, children=[
      *[symbol("<fc.functionName>", \function(), fc.src) | /funcCall fc := input]
  ])];
}

void wetest(start[Template] t) {
  visit(t) {
    case (funcCall) fc: 
    println(fc );
  }
}

list[DocumentSymbol] myOutliner(start[Template] input) {
  return [symbol("<input.src>", DocumentSymbolKind::\file(), input.src, children=[
      *[outlineStatement(stmt) | /Statement stmt := input]
  ])];
}

DocumentSymbol outlineStatement(Statement stmt) {
  switch (stmt) {
    case funcCall fc:
      return symbol("<fc.functionName>", \function(), fc.src);
    case ifElse ie:
      return symbol("if-else", \method(), ie.src);
    case include incl:
      return symbol("include", \module(), incl.src);
    default:
      return symbol("unknown", \variable(), stmt.src); // handle unknown statements
  }	
}

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
