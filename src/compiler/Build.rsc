module compiler::Build

import IO;
import String;
import ParseTree;
import List;
import Type;

import compiler::AST;
import compiler::Parser;
import compiler::Function2;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//fm = FM_parse_implode();
//ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|);

//BUILD
void traverseFM(FeatureModel fm) { 
    loc myAnnotations = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Functions.rsc|;
    str annotations = "module compiler::Functions" + "\n";

    visit(fm) {
        case Feature feature: 
            if (feature.typeOf == "root") { 
                annotations += genLevel(feature.id.name); 
            } 
            else if (feature.typeOf == "place") { 
                annotations += genPlace(feature.id.name); 
            } 
            else { 
                annotations += genDecl(feature.id.name); 
            }
    }
    writeFile(myAnnotations, annotations);
}

str genLevel(str functionName){
    return "
    str <functionName>(list[str] places){
        return \"//place your annotation here\";}" + "\n";
}

str genDecl(str functionName){
    return "
    str <functionName>(str chosenValue){
        return \"//place your annotation here\";}" + "\n";
}

str genPlace(str functionName){
    return "
    str <functionName>(list[str] declarations){
        return \"//place your annotation here\";}" + "\n";
}