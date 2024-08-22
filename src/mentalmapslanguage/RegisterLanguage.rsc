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
module mentalmapslanguage::RegisterLanguage

import util::LanguageServer;
import util::Reflective;
import IO;
import ParseTree;

import mentalmapslanguage::AST;
import mentalmapslanguage::Resolve;
import mentalmapslanguage::Check;
import mentalmapslanguage::CST2AST;
import mentalmapslanguage::SyntaxDefinition;

set[LanguageService] MMContributions() = {
    parser(Tree(str txt, loc src) {
      return parse(#start[Level], txt, src);
    }),
      
     outliner(list[DocumentSymbol] (start[Level] input) {
        c = [symbol("<input.src.path>", DocumentSymbolKind::\file(), input.src, children=
            [ symbol("<plc>", \method(), plc.src) | /Place plc := input.top ])];
        return c;
     }),
     summarizer(mySummarizer
        , providesDocumentation = true
        , providesDefinitions = true
        , providesReferences = false
        , providesImplementations = false)
  };

str type2str(tint()) = "integer";
str type2str(tbool()) = "boolean";
str type2str(tstr()) = "string";
str type2str(tunknown()) = "unknown";


Summary mySummarizer(loc origin, start[Level] input) {
  Level ast = cst2ast(input);
  RefGraph g = resolve(ast);
  TEnv tenv = collect(ast);
  set[Message] msgs = check(ast, tenv, g.useDef);

  rel[loc, Message] msgMap = {< m.at, m> | Message m <- msgs };
  
  rel[loc, str] docs = { <u, "Type: <type2str(t)>"> | <loc u, loc d> <- g.useDef, <d, _, _, Type t> <- tenv };
  return summary(origin, messages = msgMap, definitions = g.useDef, documentation = docs);
}

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "MentalMaps", "mm", "Main", "MMContributions")
			);
	
	println("IDE loaded.");
}