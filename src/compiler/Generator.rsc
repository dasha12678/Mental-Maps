module compiler::Generator

import IO;
import compiler::Functions;
import mentalmapslanguage::Check;
import mentalmapslanguage::AST;

str littlegen(Declaration decl, value parameter, str parent) { 

if (parent == "Level") { 
    if (decl.name.name == "levelName") { 
        return LevelLevelName(parameter);
    }
    if (decl.name.name == "dimensions") { 
        return LevelDimensions(parameter);
    }
    if (decl.name.name == "tiles") { 
        return LevelTiles(parameter);
    }
    if (decl.name.name == "entities") { 
        return LevelEntities(parameter);
    }
}

if (parent == "dimensions") { 
    if (decl.name.name == "width") { 
        return DimensionsWidth(parameter);
    }
    if (decl.name.name == "height") { 
        return DimensionsHeight(parameter);
    }
}

if (parent == "tile") { 
    if (decl.name.name == "type") { 
        return TileType(parameter);
    }
    if (decl.name.name == "count") { 
        return TileCount(parameter);
    }
}

if (parent == "tile") { 
    if (decl.name.name == "type") { 
        return TileType(parameter);
    }
    if (decl.name.name == "count") { 
        return TileCount(parameter);
    }
}

if (parent == "properties") { 
    if (decl.name.name == "health") { 
        return PropertiesHealth(parameter);
    }
}

if (parent == "position") { 
    if (decl.name.name == "x") { 
        return PositionX(parameter);
    }
    if (decl.name.name == "y") { 
        return PositionY(parameter);
    }
}

if (parent == "player") { 
    if (decl.name.name == "properties") { 
        return PlayerProperties(parameter);
    }
    if (decl.name.name == "position") { 
        return PlayerPosition(parameter);
    }
}

if (parent == "entity") { 
    if (decl.name.name == "player") { 
        return EntityPlayer(parameter);
    }
}

if (parent == "properties") { 
    if (decl.name.name == "health") { 
        return PropertiesHealth(parameter);
    }
}

if (parent == "enemy") { 
    if (decl.name.name == "enemyType") { 
        return EnemyEnemyType(parameter);
    }
    if (decl.name.name == "properties") { 
        return EnemyProperties(parameter);
    }
}

if (parent == "entity") { 
    if (decl.name.name == "enemy") { 
        return EntityEnemy(parameter);
    }
}

    return "Unhandled declaration type";
}

str translator(Level level, str parent) {
    list[str] annos = [translator(decl, parent) | Declaration decl <- level.declarations];
    return Level(annos);
}

str translator(Declaration decl : declStruct(name, declarations), str parent) {
    list[str] annos = [translator(decl, name.name) | Declaration decl <- declarations];
    return littlegen(decl, annos, parent);
}

str translator(Declaration decl : declBasic(name, _), str parent) {
    return littlegen(decl, getValueAsString(decl.chosenValue), parent);
}

