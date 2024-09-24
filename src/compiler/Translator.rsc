module compiler::Translator

import IO;
import String;
import ParseTree;
import List;

import compiler::AST;
import compiler::Parser;
import compiler::Function2;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//fm = FM_parse_implode();
//ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|);

alias Mapping = tuple[str feature, str (&T) annotation];

Mapping level = <"UnexploredLevel", annoUnexploredLevel>;
Mapping levelName = <"level.name", annoUnexploredLevelName>;

map[str, list[Mapping]] mapping = (
//    "Level"       : [<"UnexploredLevel", annoUnexploredLevel>],
    "Level.name"  : [<"level.name", annoUnexploredLevelName>],
    // "Place"      : [<"place", annoUnexploredLevelPlace>, <"structure", annoPlaceStructure>],
    "Place.name"  : [<"place.name", annoPlaceName>],
    "Declaration" : [<"size", annoStructureSize>, <"location", annoStructureLocation>]
);

//gen for level initiation
str generator(Level ast, map[str, list[Mapping]] mapping){

    list[str] annoDecl = [];
    str annoPlace = "";
    str annoLevel = "";

    bottom-up visit (ast) {
        case Declaration decl : annoDecl += translator(decl, mapping);
        case Place place : annoPlace += translator(place, annoDecl);
        case Level level : annoLevel += translator(level, annoPlace);
    }
    return annoLevel;
}

//gen for places
str translator(Place ast : place(typeOfPlace, name, enumCalls, subPlaces), list[str] an){

    str name = annoPlaceName(name);
    str structure = annoPlaceStructure(an);

return annoUnexploredLevelPlace(name, structure);

}

//gen for declarations
str translator(Declaration decl, map[str, list[Mapping]] mapping){

str annoDecl = "";

    for (mappingTuple <- mapping["Declaration"]) {
        if (decl.name == "<mappingTuple.feature>"){
            annoDecl += mappingTuple.annotation(decl.chosenValue); 
        }
    }

return annoDecl;
}

str translator (level(name, typedefs, places, connections), str annoPlace){

    str name = annoUnexploredLevelName(name);

    return annoUnexploredLevel(name, annoPlace);
}


