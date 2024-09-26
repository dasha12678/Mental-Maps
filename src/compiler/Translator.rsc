module compiler::Translator

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

//FUNCTION CALL GEN
str genLevel1(){
    return "UnexploredLevel(list[str] level.places)" + "\n";
}

str genDecl1(str declName){
    return "<declName>(str chosenValues)" + "\n";
}

str genPlace1(){
    return "Place(list[str] declarations)" + "\n";
}
//instead this FUNCTION THAT TRAVERSES AND GIVES GEN

//YAY 
str yay(Level ast){
    list[str] annoDecls = [];
    list[str] annoPlaces = [];
    str annoLevel = "";

    bottom-up visit (ast) {
        case Declaration decl : annoDecls += translator(decl);
         case Place place : annoPlaces += translator(place);
         case Level level : annoLevel += translator(level);
    }
    return annoLevel;
}

//TRANSLATOR
str translator(Level level){
list[str] annoPlaces = [translator(place) | Place place <- level.places];
    return genLevel1();
}

str translator(Place place){
list[str] annoDecls = [translator(decl) | Declaration decl <- place.declarations];
return genPlace1();
}

str translator(Declaration decl){
return genDecl1(decl.name);
}
    
str startGenerator(loc file){
Level level = parseAndImplodeProject(file);
return yay(level);
    }

//FINAL
void writeGenerator() { 
    loc myGenerator = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Generator.rsc|;
    loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|;
    str code = "module compiler::Generator" + "\n" + "import compiler::Translator" + "\n" + "import mentalmapslanguage::Parser" + "\n" + "import mentalmapslanguage::AST" + "\n";

    code += 
    "
    <startGenerator(myFile)>
    ";

    writeFile(myGenerator, code);
}
