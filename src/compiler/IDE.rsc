module compiler::IDE

import compiler::Check;
import compiler::Parser;
import util::LanguageServer;
import util::Reflective;
import IO;
import ParseTree;
import compiler::SyntaxDefinition;

set[LanguageService] FMContributions() = {

    parser(Tree(str txt, loc src) {
      return parse(#start[FeatureModel], txt, src);
    }),

    summarizer(mySummarizer
    	, providesDocumentation = true
        , providesDefinitions = true
        , providesReferences = false
        , providesImplementations = false)
};

Summary mySummarizer(loc origin, start[FeatureModel] input) {
  return summary(origin, messages = {<m.at, m> | Message m <- check(FM_implode(input)) });
}

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "FeatureModel", "fm", "compiler::IDE", "FMContributions")
			);

	println("IDE loaded.");
}