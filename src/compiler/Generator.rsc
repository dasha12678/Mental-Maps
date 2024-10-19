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

    appendToFile(fileLoc, "str littlegen(Declaration decl, str parent) {\n\n");

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
    "str translator(Level level, str parent) {\n" +
    "    list[str] annos = [translator(decl, \"Level\") | Declaration decl \<- level.declarations];\n" +
    "    return Level(annos, \"Level\");\n" +
    "}\n\n" +

    "str translator(Declaration decl : declStruct(name, declarations), str parent) {\n" +
    "    list[str] annos = [translator(decl, name.name) | Declaration decl \<- declarations];\n" +
    "    return littlegen(decl, name.name);\n" +
    "}\n\n" +
    
    "str translator(Declaration decl : declBasic(name, _), str parent) {\n" +
    "    return littlegen(decl, parent);\n" +
    "}\n\n";

    // "str translator(Declaration decl : declList(name, _), str parent) {\n" +
    // "    return littlegen(decl, parent);\n" +
    // "}\n\n" +

    // "str translator(Declaration decl : declSet(name, _), str parent) {\n" +
    // "    return littlegen(decl, parent);\n" +
    // "}\n\n";

    appendToFile(fileLoc, translatorFunctions);
}



