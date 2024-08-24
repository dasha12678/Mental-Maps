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
import mentalmapslanguage::Check;
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

Summary mySummarizer(loc origin, start[Level] input) {
  messages = {<m.at, m> | Message m <- check(input)};
  println(messages);
  return summary(origin, messages);
}

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "MentalMaps", "mm", "mentalmapslanguage::RegisterLanguage", "MMContributions")
			);
	
	println("IDE loaded.");
}