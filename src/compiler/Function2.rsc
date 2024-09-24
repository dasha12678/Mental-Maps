module compiler::Function2
import mentalmapslanguage::AST;
import IO;
import List;

str annoUnexploredLevel (Level level){ 

    str output = "";

    output += annoUnexploredLevelName(level.name);
    for (Place place <- level.places) {
         output += annoUnexploredLevelPlace(place); // Call the overloaded version for Place
    }
    return output;
}

str annoUnexploredLevelName(str name){
    return "encounter(name=<name>)" + "\n";
}

str annoUnexploredLevelPlace (str name){  

    str output = "";
    output += annoPlaceName(name);
        if (subplace.name == "site"){ // if its a place
            output += annoUnexploredLevelPlace(name);
        }
        if (subplace.name == "structure"){
            output += annoPlaceStructure(subplace.declarations);
        }
    }

	return output;
}

str annoPlaceName (str name){
    return "addLocation(name=<name>)" + "\n";
}

str annoPlaceStructure (str size, str location){
    results = [size, location];
    return "addLocation(structure=<intercalate("|", results)>)" + "\n"; 
}

str annoStructureSize (chosenValue){ 
  return "<chosenValue>";
}

str annoStructureLocation (chosenValue){ 
  return "PlaceIs<chosenValue>";
}

// annoUnexploredLevel
// annoUnexploredLevelName
// annoUnexploredLevelPlace
// annoPlaceStructure
// annoStructureSize
// annoStructureLocation
 