module compiler::Function2
import mentalmapslanguage::AST;
import IO;
import List;

str annoUnexploredLevel (str name, str place){ 
    return name + place;
}

str annoUnexploredLevelName (str name){
    return "encounter(name=<name>)" + "\n";
}

str annoUnexploredLevelPlace (str name, str structure){  
	return name + structure;
}

str annoPlaceName (str name){
    return "addLocation(name=<name>)" + "\n";
}

str annoPlaceStructure (list[str] parameters){
    return "addLocation(structure=<intercalate("|", parameters)>)" + "\n"; 
}

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
 