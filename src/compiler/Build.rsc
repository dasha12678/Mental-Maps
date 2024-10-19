module compiler::Build

import IO;
import mentalmapslanguage::AST;

//BUILD
void traverseFM(Level level) { 
    loc myAnnotations = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Functions.rsc|;
    str annotations = "module compiler::Functions" + "\n";

//If Typedef is basic, it takes a value 
//If TypeDef is list/set, it takes a list/set of values
//If TypeDef is struct, it takes a list of anno declarations 
//If TypeDef is enum, it takes a value

    visit(level) {
        case declBasic(name, _):
            annotations += genBasic(name.name); 
        case declList(name, _):
            annotations += genList(name.name); 
        case declSet(name, _):
            annotations += genSet(name.name);
        case declStruct(name, _):
            annotations += genStruct(name.name);
    }
    writeFile(myAnnotations, annotations);
}

str genBasic(str functionName){
    return "
    str <functionName>(value chosenValue){
        return \"//place your annotation here\";}" + "\n";
}

str genList(str functionName){
    return "
    str <functionName>(value chosenValue){ 
        return \"//place your annotation here\";}" + "\n";
}

str genSet(str functionName){
    return "
    str <functionName>(value chosenValue){ 
        return \"//place your annotation here\";}" + "\n";
}

str genStruct(str functionName){
    return "
    str <functionName>(value declarations){
        return \"//place your annotation here\";}" + "\n";
}