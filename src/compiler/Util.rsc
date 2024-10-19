module compiler::Util

import IO;
import compiler::Functions;
import mentalmapslanguage::AST;
import mentalmapslanguage::Check;

str littlegen(Declaration decl, value parameter, str parent) { //input either a decl or anno for struct 

if (parent == "Level"){
    if (decl.name.name == "name") { 
        return Levelname(parameter);
    }
    if (decl.name.name == "place") { 
        return Levelplace(parameter);
    }
}

if (parent == "place"){
    if (decl.name.name == "name") { 
        return Placename(parameter);
    }
    if (decl.name.name == "structure") { 
        return Placestructure(parameter);
    }
}

if (parent == "structure"){
    if (decl.name.name == "size") { 
        return Structuresize(parameter);
    }
    if (decl.name.name == "location") { 
        return Structurelocation(parameter);
    }
}
    return "Unhandled declaration type";
}


str translator(Level level, str parent) {
    list[str] annos = [translator(decl, "Level") | Declaration decl <- level.declarations];
    return Level(annos);
}

str translator(Declaration decl : declStruct(name, declarations), str parent) {
    list[str] annos = [translator(decl, name.name) | Declaration decl <- declarations];
    return littlegen(decl, annos, parent);
}

str translator(Declaration decl : declBasic(name, _), str parent) {
    return littlegen(decl, getValueAsString(decl.chosenValue), parent);
}

