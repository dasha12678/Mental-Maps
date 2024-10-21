module compiler::Pregenerator

import IO;
import String;
import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

void generateCode(Level level) {
    loc fileLoc = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Generator.rsc|;
    writeFile(fileLoc, "module compiler::Generator\n\n");

    str imports = 
    "import IO;\n" +
    "import compiler::Functions;\n" +
    "import mentalmapslanguage::Check;\n" +
    "import mentalmapslanguage::AST;\n\n";

    appendToFile(fileLoc, imports);

    appendToFile(fileLoc, "str littlegen(Declaration decl, value parameter, str parent) { \n\n");

    appendToFile(fileLoc, "if (parent == \"" + "Level" + "\") { \n");
    for (Declaration decl <- level.declarations){
    appendToFile(fileLoc, "    if (decl.name.name == \"" + decl.name.name + "\") { \n");
    appendToFile(fileLoc, "        return " + "Level" + capitalize(decl.name.name) + "(parameter);\n");
    appendToFile(fileLoc, "    }\n");
    };
    appendToFile(fileLoc, "}\n\n");

    visit(level){
        case Declaration decl : {
            switch(decl){
                case declStruct(name, declarations) : {
                    appendToFile(fileLoc, "if (parent == \"" + name.name + "\") { \n");
                    for (Declaration decl1 <- declarations){
                            appendToFile(fileLoc, "    if (decl.name.name == \"" + decl1.name.name + "\") { \n");
                            appendToFile(fileLoc, "        return " + capitalize(name.name) + capitalize(decl1.name.name) + "(parameter);\n");
                            appendToFile(fileLoc, "    }\n");
                    }
                    appendToFile(fileLoc, "}\n\n");
                }
            }
        }
    }
    appendToFile(fileLoc, "    return \"Unhandled declaration type\";\n");
    appendToFile(fileLoc, "}\n\n");

    str translatorFunctions =
    "str translator(Level level, str parent) {\n" +
    "    list[str] annos = [translator(decl, parent) | Declaration decl \<- level.declarations];\n" +
    "    return Level(annos);\n" +
    "}\n\n" +

    "str translator(Declaration decl : declStruct(name, declarations), str parent) {\n" +
    "    list[str] annos = [translator(decl, name.name) | Declaration decl \<- declarations];\n" +
    "    return littlegen(decl, annos, parent);\n" +
    "}\n\n" +
    
    "str translator(Declaration decl : declBasic(name, _), str parent) {\n" +
    "    return littlegen(decl, getValueAsString(decl.chosenValue), parent);\n" +
    "}\n\n";

    appendToFile(fileLoc, translatorFunctions);
}



