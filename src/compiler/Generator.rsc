module compiler::Generator

import IO;
import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

void generateCode() {
    loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/newLevel.mm|;
    Level level = parseAndImplodeProject(myFile);

    loc fileLoc = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Util.rsc|;

    writeFile(fileLoc, "module compiler::Util\n\n");

    str imports = 
    "import IO;\n" +
    "import compiler::Functions;\n" +
    "import mentalmapslanguage::AST;\n\n";

    appendToFile(fileLoc, imports);

    appendToFile(fileLoc, "str littlegen(Declaration decl) {\n\n");

    visit(level){
    case Declaration decl : {
        appendToFile(fileLoc, "    if (decl.name.name == \"" + decl.name.name + "\") { \n");
        appendToFile(fileLoc, "        return " + decl.name.name + "(decl.chosenValue);\n");
        appendToFile(fileLoc, "    }\n");
    }
    }
    appendToFile(fileLoc, "    return \"Unhandled declaration type\";\n");
    appendToFile(fileLoc, "}\n\n");

    str translatorFunctions =
    "str translator(Level level) {\n" +
    "    list[str] annos = [translator(decl) | Declaration decl \<- level.declarations];\n" +
    "    return Level(annos);\n" +
    "}\n\n" +

    "str translator(Declaration decl : declStruct(name, declarations)) {\n" +
    "    list[str] annos = [translator(decl, name)) | Declaration decl \<- declarations];\n" +
    "    return littlegen(decl);\n" +
    "}\n\n" +
    
    "str translate(Declaration decl : declBasic(name, _), str parent) {\n" +
    "    return littlegen(decl);\n" +
    "}\n\n" +

    "str translate(Declaration decl : declList(name, _), str parent) {\n" +
    "    return littlegen(decl);\n" +
    "}\n\n" +

    "str translate(Declaration decl : declSet(name, _), str parent) {\n" +
    "    return littlegen(decl);\n" +
    "}\n\n";

    appendToFile(fileLoc, translatorFunctions);
}



