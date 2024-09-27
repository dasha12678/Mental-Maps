module compiler::Util

import IO;
import String;
import List;
import ParseTree;
import Type;

import compiler::AST;
import compiler::Parser;
import compiler::Functions;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

str littlegen(Declaration decl) {

    if (decl.name == "location") { 
        return location(decl.chosenValue);
    }
    if (decl.name == "size") { 
        return size(decl.chosenValue);
    }
    return "Unhandled declaration type";
}

str translator(Level level) {
    list[str] annoPlaces = [translator(place) | Place place <- level.places];
    return UnexploredLevel(annoPlaces);
}

str translator(Place place) {
    list[str] annoDecls = [translator(decl) | Declaration decl <- place.declarations];
    return Place(annoDecls);
}

str translator(Declaration decl) {
    return littlegen(decl);
}
