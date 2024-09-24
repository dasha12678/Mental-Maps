module compiler::Util

list[Feature] getChildren(FeatureModel fm : model(list[Feature] features)) {
    list[Feature] children = [];

    for (Feature feature <- features){

        for (Edge edge <- feature.edges){ 
            println(typeOf(edge.child));
        }
    }

    return children;
}

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


//===========================================================================

// module compiler::Function
// import mentalmapslanguage::AST;
// import IO;
// import List;

// //UnexploredLevel
// str annoUnexploredLevel (level(name, typedefs, places, connections)){ 
	
//     str output = "";

//     output += annoUnexploredLevelName(name);

//     for (Place place <- places) {
//          output += annoPlace(place); // Call the overloaded version for Place
//     }

//     return output;
// }

// str annoUnexploredLevelName(str name){
//     return "encounter(name=<name>)" + "\n";
// }

// //Place
// str annoPlace (place(typeOfPlace, name, declarations, subPlaces)){  

//     str output = "";

//     output += annoPlaceName(name);

//     for (Place subplace <- subPlaces) {

//         if (subplace.name == "site"){ // if its a place
//             output += annoPlace(place); // Call the overloaded version for Place
//         }

//         if (subplace.name == "structure"){
//             output += annoPlaceStructure(subplace.declarations);
//         }
//     }

// 	return output;
// }

// str annoPlaceName(str name){
//     return "addLocation(name=<name>)" + "\n";
// }

// str annoPlaceStructure([Declaration] declarations){
//     return output += "addLocation(structure=<intercalate("|", [provideAnnotation(decl) | Declaration decl <- declarations])>)" + "\n"; 
// }

// //Declaration
// str annoStructureSize (Declaration decl){ // Declaration

//     str output = "";

//     switch(decl){
	
//         case declarationSingle(chosenType, name, chosenValue):{

//             if (name == "size"){
//                 output += "<chosenValue>";
//             }

//             if (name == "location"){
//                 output += "PlaceIs<chosenValue>";
//             }

//         }
//     }  

//     return output;
// }


// UnexploredLevelnameAnno
// PlaceAnno
// StructureAnno
// SizeAnno
// LocationAnno