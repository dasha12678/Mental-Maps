module compiler::Translator

import IO;
import String;
import ParseTree;
import List;

import compiler::AST;
import compiler::Parser;

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

//Start traversing:
//Step 1: Match Level to UnexploredLevel
//Step 2: Extract feature UnexploredLevel
//(Step 3: Check if its required, otherwise throw error)
//Step 4: Extract annotation for UnexploredLevel and add it to output 

//ALTERNATIVE
// Check if any features of UnexploredLevel are required. if yes, autofill them.
// Then, go to the feature of that name and fill it out 
//If any are not present, throw error. 

//gen for level initiation
str translator(FeatureModel fm : model(list[Feature] features), Level ast : level(name, typedefs, places, connections), list[tuple[str, str]] annotation, map[str, list[str]] mapping){

    str output = "";

    str initiate = head(mapping["Level"]); //UnexploredLevel

    for (Feature feature <- features) {
        if (feature.id == initiate){
            // check if its required, otherwise throw error 
           for (tuple[str, str] t <- annotation) {
                if (t[0] == initiate){
                    //output += replaceAll(t[1], "x", "<name>") + "\n";
                    output += t[1] + "\n";
                }
            }
        }
    }

    // for (Place place <- places) {
    //     output += translator(fm, place, annotation);  // Call the overloaded version for Place
    // }

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

