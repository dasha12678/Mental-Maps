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

// void traverseEdges(Feature feature, list[EnumCall] declarations){

//     str result = "";  // Initialize an empty string to store the final result
//     str a = feature.annotation;
//     bool newline = feature.newline == "true";

//     for (Edge edge <- feature.edges) { 

//         // Handle "mandatory" edge
//         if (edge.relationship == "mandatory") {
//             traverseEdges(edge.name);
//         }
        
//         // Handle "optional" edge
//         if (edge.relationship == "optional") {
//             // Check if the edge target is in declarations
//             if (edge.name in [decl.name | decl <- declarations]) {
//                 traverseEdges(edge.name, );
//             }
//         }
//     }
    
//     return result; 
// }

// str isNewLine(Edge edge, str annotation){

//     str output = "";
//     str a = feature.annotation;
//     bool newline = feature.newline == "true";

//     if (!newline){
//         a = replaceAll(a, "x", "<annotation>") + "\n"; 
//     }

//     if(newline){
//         str b = edge.annotation;
//     }

//     return output + "\n";

// }


//gen for level initiation
str translator(FeatureModel fm : model(list[Feature] features), Level ast : level(name, typedefs, places, connections)){

    str output = "";

    for (Feature feature <- features){

        //initiate level
        if (feature.mapping == "\"Level\""){ // TODO remove quotation from parsed mapping string
            str a = feature.annotation;

            for (Edge edge <- feature.edges){ 

                //name
                if (edge.target == "\"name\""){
                    a = replaceAll(a, "x", "<name>") + "\n"; 
                    output += a + "\n";
                }
                else {
                    throw "You have not provided a name for the level";
                }

            }
        }
    }

    //places
    // for (Place place <- places) {
    //     output += translator(fm, place, annotation);  // Call the overloaded version for Place
    // }

    return output;
}

//gen for places
str translator(FeatureModel fm : model(list[Feature] features), Place ast : place(typeOfPlace, name, enumCalls, subPlaces)){

    str output = "";

    for (Feature feature <- features){
        if (feature.mapping == "\"Place\""){ 
            str a = feature.annotation;  

            //for (Edge edge <- feature.edges){ 
            //if (edge.name == "\"name\""){
                
            //}
            //}
        }
    }

    //search feature for place annotation
    for (EnumCall enumCall <- enumCalls) {
        str y = translator(fm, enumCall);
    }

    return output;
}

//gen for traversing enum calls
str translator(FeatureModel fm : model(list[Feature] features), EnumCall ast){

    str output = "";

     switch(ast){	
                 case enumCallSingle(chosenType, name, chosenValue):{
                     
                    println();
                 }
    }  
    return output;
}


list[Feature] getChildren(FeatureModel fm : model(list[Feature] features)) {
    list[Feature] children = [];

    for (Feature feature <- features){

        for (Edge edge <- feature.edges){ 
            println(typeOf(edge.child));
        }
    }

    return children;
}