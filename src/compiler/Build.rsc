module compiler::Build

import IO;
import String;
import mentalmapslanguage::AST;

//BUILD
void builder(Level level) { 
    loc myAnnotations = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Functions.rsc|;
    str annotations = "module compiler::Functions" + "\n";

    annotations += genBasic("Level", ""); 

    for (TypeDef typedef <- level.typedefs) {
        visit(typedef) {
            case MemberDecl memberdecl:
                visit(memberdecl) {
                    case memberDecl(_, _, name): {
                        annotations += genBasic(name.name, typedef.name.name); 
                    }
                    case typeDef(typedef1): {
                        annotations += genBasic(typedef1.name.name, typedef.name.name); 
                    }
                }
        }
    }

    writeFile(myAnnotations, annotations);
}

str genBasic(str functionName, str parent) {
    return "
    str <parent><capitalize(functionName)>(value parameter){
        return \"//place your annotation here\";}" + "\n";
}

// str genList(str functionName){
//     return "
//     str <functionName>(value chosenValue){ 
//         return \"//place your annotation here\";}" + "\n";
// }

// str genSet(str functionName){
//     return "
//     str <functionName>(value chosenValue){ 
//         return \"//place your annotation here\";}" + "\n";
// }

// str genStruct(str functionName){
//     return "
//     str <functionName>(value declarations){
//         return \"//place your annotation here\";}" + "\n";
// }