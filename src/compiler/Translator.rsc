module compiler::Translator

import IO;
import String;
import ParseTree;

import compiler::AST;
import compiler::Parser;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//fm = FM_parse_implode();
//ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|);

list[tuple[str, str]] myNewestList = [
    <"name", "encounter(name=x)">,
    <"id", "addLocation(id=x)">,
    <"structure", "addLocation(structure=x)">,
    <"location", "placeIsx">,
    <"size", "x">
    ];

//gen for level initiation
str translator(FeatureModel fm : model(list[Feature] features), Level ast : level(name, typedefs, places, connections), list[tuple[str, str]] myList){

    str output = "";

    for (tuple[str, str] t <- myList) {
        if (t[0] == "name"){
            output += replaceAll(t[1], "x", "<name>") + "\n";
        }
    }

    for (Place place <- places) {
        output += translator(fm, place, myList);  // Call the overloaded version for Place
    }
    return output;
}


//gen for places
str translator(FeatureModel fm : FeatureModel, Place ast : place(typeOfPlace, name, enumCalls, subPlaces), list[tuple[str, str]] myList){

    str output = "";

    for (EnumCall enumCall <- enumCalls) {
        str y = translator(fm, enumCall, myList);
    }

    for (tuple[str, str] t <- myList) {
        if (t[0] == "id"){
            output += replaceAll(t[1], "x", "<name>") + "\n";
        }
        if(t[0] == "structure") {
            output += replaceAll(t[1], "x", y) + "\n";
        }
    }

    return output;
}

//gen for traversing enum calls
str translator(FeatureModel fm : model(list[Feature] features), EnumCall ast : enumCallSingle(chosenType, name, chosenValue), list[tuple[str, str]] myList){

    str output = "";
     switch(ast){	
                 case enumCallSingle(chosenType, name, chosenValue):{
                     
                    for (tuple[str, str] t <- myList) {
                        if (t[0] == name){
                            output += replaceAll(t[1], "x", "<chosenValue>") + "\n";
                        }
                    }
                 }
    }  
    return output;
}

str commaSeparate(str input) {
    // Split the input string by spaces
    list[str] parts = split(input, " ");

    str result = "";

    // Join the parts with commas

    return result;
}

