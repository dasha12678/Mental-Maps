module compiler::Function2
import mentalmapslanguage::AST;
import IO;
import List;

// str annoUnexploredLevel (str name, list[str] places){ 
//     str level = "";
//     level += name;
//     for (str place <- places) {
//         level += place;
//     }
//     return level;
// }

str annoUnexploredLevel (str name, list[str] places){
  return "encounter(name=<name>)" + "\n" + "<places>";
}

// str annoUnexploredLevelName (str name){
//     return "encounter(name=<name>)" + "\n";
// }

str annoUnexploredLevelPlace (str name, list[str] declarations){  
	return "addLocation(name=<name>)" + "\n" +
   "addLocation(structure=<intercalate("|", declarations)>)" + "\n";
}

// str annoPlaceStructure (list[str] parameters){
//     return "addLocation(structure=<intercalate("|", parameters)>)" + "\n"; 
// }

str annoStructureSize (str chosenValue){ 
  return "<chosenValue>";
}

str annoStructureLocation (str chosenValue){ 
  return "PlaceIs<chosenValue>";
}

// annoUnexploredLevel
// annoUnexploredLevelName
// annoUnexploredLevelPlace
// annoPlaceName
// annoPlaceStructure
// annoStructureSize
// annoStructureLocation
 