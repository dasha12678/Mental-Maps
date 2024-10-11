module mentalmapslanguage::Preprocessor

import IO;
import Type;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;

//tree rewriting 
//source-to-source transformation
//Takes a variant (eg "a") -> writes variants to file 

Level preprocessor(str variant, Level level) =
    visit(level){
    case list[Declaration] _ : [*Declaration pre, Declaration ifelse : ifElse(_, _, _, _), *Declaration post] 
    => pre + preprocessor(variant, ifelse) + post
};

list[Declaration] preprocessor(str variant, Declaration ifelse : ifElse(variable, myValue, declsIf, declsElse)){
    if (myValue == variant){
        return declsIf;
    //TO DO: add case for if without else 
    //TO DO: write to file

    }
    return [];
}

//TO DISPLAY THE VARIANT

//OPTIONAL;
//prettyprint(if ..)=
//    "if(<prettyprint(c))";