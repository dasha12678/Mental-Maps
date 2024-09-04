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

str retrieveAnnotation(){
}


//gen for level initiation
str translator(FeatureModel fm : model(list[Feature] features), Level ast : level(name, typedefs, places, connections)){

    str output = "";

    for (Feature feature <- features) {
        output += "annotation \n"; 
    }

    for (Place place <- places) {
        output += translator(fm, place);  // Call the overloaded version for Place
    }
    return output;
}


//gen for places
str translator(FeatureModel fm : FeatureModel, Place ast : place(typeOfPlace, name, enumCalls, subPlaces)){

    str output = "";
    output += "addlocation(id=<name>) \n";

    str x = "";

    for (EnumCall enumCall <- enumCalls) {
        x += translator(fm, enumCall);
    }

    output += "addlocation(features=RoomIs<capitalize(typeOfPlace)>, <x>) \n";
            
            // Recursively handle subPlaces if they exist
            //for (Place subPlace <- subPlaces) {
            //    output += translator(fm, subPlace);
            //}
    return output;
}

//gen for traversing enum calls
str translator(FeatureModel fm : FeatureModel, EnumCall ast : enumCallSingle(chosenType, name, chosenValue) ){

    str output = "";
     switch(ast){	
                 case enumCallSingle(chosenType, name, chosenValue):{

                    if (name == "location") {
                        output += "placeIs<chosenValue>";
                    }

                    else if (name == "size") {
                        output += "<chosenValue>";
                    }
                    // Handle other cases if necessary
                }
    }  
    return output;
}

//str translator(FeatureModel fm : FeatureModel, Level ast : EnumCall){

    //Level ast = parseAndImplodeProject(|file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/mineAnnotated.mm|);
    //str output = "";

    //    switch(ast){	
    //        case enumCallSingle(chosenType, name, chosenValue):{

    //            if (name == "location") {
    //                output += "placeIs<chosenValue>";
    //            }

    //            else if (name == "size") {
    //                output += "<chosenValue>";
    //            }
    //        }
            
            // case enumCallMultiple(chosenType, name, chosenValues): {

            //     if (name == "location") {
            //         output += "placeIs<chosenValue>";
            //     }

            //     if (name == "size") {
            //         output += "<chosenValue>";
            //     }
            //     break;
            //}

            //case enumCallChoose(chosenType, name, chosenValue1, chosenValue2): {

            //     if (name == "location") {
            //         output += "placeIs<chosenValue>";
            //     }

            //     if (name == "size") {
            //         output += "<chosenValue>";
            //     }
            //     break;
            //}
        //}
    //return output;
//}

/*

function overloaded with different parameters

lists of children 

speciialization  - use language but without all of its features

traversing the feature model: as leading
two cursors

more nesting is not wanted!!
-> easier for traversal 

rascal:
good for dsls
rapid prototyping
templating


online generators for feature models


lisa programmed class diagrams using plantUml 
*/


