module compiler::Translator

import IO;
import String;
import ParseTree;
import List;

import compiler::AST;
import compiler::Parser;
import compiler::Function;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//fm = FM_parse_implode();
//ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|);

map[str, list[str]] mapping = (
    "Level": ["UnexploredLevel"],
    "levelName": ["name"],
    "Place": ["addLocation"],
    "placeName": ["id"],
    "Declaration": ["structure"],
    "declName": ["size", "location"]
);

list[tuple[str, str]] annotation = [
    <"UnexploredLevel", "encounter(x)">, 
    <"name", "name=x">,
    <"addLocation", "addLocation(x)">,
    <"id", "id=x">,
    <"structure", "addLocation(structure=x)">,
    <"location", "placeIsx">,
    <"size", "x">
    ];

//gen for level initiation
str translator(FeatureModel fm : model(list[Feature] features), Level ast : level(name, typedefs, places, connections)){

    return provideAnnotation(level(name, typedefs, places, connections));
}

// //gen for places
// str translator(FeatureModel fm : model(list[Feature] features), Place ast : place(typeOfPlace, name, enumCalls, subPlaces)){

// return "";

// }

// //gen for traversing enum calls
// str translator(FeatureModel fm : model(list[Feature] features), EnumCall ast){

// return "";

// }

