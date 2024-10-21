module compiler::Generator

import IO;
import compiler::Functions;
import mentalmapslanguage::Check;
import mentalmapslanguage::AST;

str littlegen(Declaration decl, value parameter, str parent) { 

if (parent == "Level") { 
    if (decl.name.name == "name") { 
        return LevelName(parameter);
    }
    if (decl.name.name == "place") { 
        return LevelPlace(parameter);
    }
}

if (parent == "structure") { 
    if (decl.name.name == "location") { 
        return StructureLocation(parameter);
    }
    if (decl.name.name == "size") { 
        return StructureSize(parameter);
    }
}

if (parent == "place") { 
    if (decl.name.name == "name") { 
        return PlaceName(parameter);
    }
    if (decl.name.name == "structure") { 
        return PlaceStructure(parameter);
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

