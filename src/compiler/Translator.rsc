module compiler::Translator

import IO;
import String;
import ParseTree;
import List;
import Type;

import compiler::AST;
import compiler::Parser;
import compiler::Function2;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//fm = FM_parse_implode();
//ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|);

str genLevel(str functionName, str levelName, list[str] places){
    return "
    str anno<functionName>(str <levelName>, list[str] <places>){
        return //place your annotation here";
}

str genDecl(str functionName, str chosenValue){
    return "
    str anno<functionName>(str <chosenValue>){
        return //place your annotation here";
}

str genPlace(str functionName, str placeName, list[str] declarations){
    return "
    str anno<functionName>(str <placeName>, list[str] <declarations>){
        return //place your annotation here";
}


str biGgen(){

return "

str translator(Place place){
    list[str] annoDecls = [translator(decl) | Declaration decl <- place.declarations];
    return genPlace("place", place.name, annoDecls); 
}

str translator(Declaration decl){
    return genDecl(decl.name, decl.chosenValue);
}

str translator (Level level){
    list[str] annoPlaces = [translator(place) | Place place <- level.places];
    return genLevel("level", level.name, annoPlaces);
}

"
}


