module compiler::Util

import IO;
import compiler::Functions;
import mentalmapslanguage::AST;

str littlegen(Declaration decl) {

    if (decl.name.name == "name") { 
        return name(decl.chosenValue);
    }
    if (decl.name.name == "size") { 
        return size(decl.chosenValue);
    }
    if (decl.name.name == "name") { 
        return name(decl.chosenValue);
    }
    if (decl.name.name == "location") { 
        return location(decl.chosenValue);
    }
    if (decl.name.name == "size") { 
        return size(decl.chosenValue);
    }
    if (decl.name.name == "structure") { 
        return structure(decl.chosenValue);
    }
    if (decl.name.name == "place") { 
        return place(decl.chosenValue);
    }
    return "Unhandled declaration type";
}

str translator(Level level) {
    list[str] annos = [translator(decl) | Declaration decl <- level.declarations];
    return Level(annos);
}

str translator(Declaration decl : declStruct(name, declarations)) {
    list[str] annos = [translator(decl) | Declaration decl <- declarations];
    return littlegen(decl);
}

str translator(Declaration decl : declBasic(name, _)) {
    return littlegen(decl);
}

str translator(Declaration decl : declList(name, _)) {
    return littlegen(decl);
}

str translator(Declaration decl : declSet(name, _)) {
    return littlegen(decl);
}

