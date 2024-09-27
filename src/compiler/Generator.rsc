module compiler::Generator

import IO;
import String;
import ParseTree;
import List;
import Type;

import compiler::AST;
import compiler::Parser;
import compiler::Functions;
import compiler::Util;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

void generateCode() {
    loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|;
    Level level = parseAndImplodeProject(myFile);

    loc fileLoc = |file:///C:/Users/dasha/Thesis/mental-maps/src/compiler/Util.rsc|;

    writeFile(fileLoc, "module compiler::Util;\n\n");

    str imports = 
    "import IO;\n" +
    "import String;\n" +
    "import List;\n" +
    "import ParseTree;\n" +
    "import Type;\n" +
    "\n" +
    "import compiler::AST;\n" +
    "import compiler::Parser;\n" +
    "import compiler::Functions;\n" +
    "\n" +
    "import mentalmapslanguage::AST;\n" +
    "import mentalmapslanguage::Parser;\n\n";

    appendToFile(fileLoc, imports);

    appendToFile(fileLoc, "str littlegen(Declaration decl) {\n\n");

    for (Place place <- level.places) {
        for (Declaration decl <- place.declarations) {
            appendToFile(fileLoc, "    if (decl.name == \"" + decl.name + "\") { \n");
            appendToFile(fileLoc, "        return " + decl.name + "(decl.chosenValue);\n");
            appendToFile(fileLoc, "    }\n");
        }
    }

    appendToFile(fileLoc, "    return \"Unhandled declaration type\";\n");
    appendToFile(fileLoc, "}\n\n");

    str translatorFunctions =
    "str translator(Level level) {\n" +
    "    list[str] annoPlaces = [translator(place) | Place place \<- level.places];\n" +
    "    return UnexploredLevel(annoPlaces);\n" +
    "}\n\n" +
    
    "str translator(Place place) {\n" +
    "    list[str] annoDecls = [translator(decl) | Declaration decl \<- place.declarations];\n" +
    "    return Place(annoDecls);\n" +
    "}\n\n" +
    
    "str translator(Declaration decl) {\n" +
    "    return littlegen(decl);\n" +
    "}\n";

    appendToFile(fileLoc, translatorFunctions);
}




