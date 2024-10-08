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
module mentalmapslanguage::IDE

import util::LanguageServer;
import util::Reflective;
import IO;
import ParseTree;

import mentalmapslanguage::Check;
import mentalmapslanguage::SyntaxDefinition;
import mentalmapslanguage::AST;

set[LanguageService] MMContributions() = {
    parser(Tree(str txt, loc src) {
      return parse(#start[Level], txt, src);
    }),
      
     outliner(list[DocumentSymbol] (start[Level] input) {
        c = [symbol("<input.src.path>", DocumentSymbolKind::\file(), input.src, children=
            [ symbol("<typedef>", \method(), typedef.src) | /TypeDef typedef := input.top ])];
        return c;
     }),

     summarizer(mySummarizer
        , providesDocumentation = true
        , providesDefinitions = true
        , providesReferences = false
        , providesImplementations = false)
 };

Summary mySummarizer(loc origin, start[Level] input) {
  imploded = implode(#Level, input);
  return summary(origin, messages = {<m.at, m> | Message m <- check(imploded) });
}

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "MentalMaps", "mm", "mentalmapslanguage::IDE", "MMContributions")
			);
	
	println("IDE loaded.");
}