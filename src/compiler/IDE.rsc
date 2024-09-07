module compiler::IDE

import util::LanguageServer;
import util::Reflective;
import IO;
import ParseTree;

import compiler::SyntaxDefinition;

set[LanguageService] FMContributions() = {
    parser(Tree(str txt, loc src) {
      return parse(#start[FeatureModel], txt, src, allowAmbiguity=true);
    })
};

public void main(){

	registerLanguage(
		language(
			pathConfig(srcs=[|std:///|, |project://mental-maps/src|]), "FeatureModel", "fm", "compiler::IDE", "FMContributions")
			);

	println("IDE loaded.");
}