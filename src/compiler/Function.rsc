module compiler::Function
import mentalmapslanguage::AST;
import IO;
import List;

//UnexploredLevel
str provideAnnotation (level(name, typedefs, places, connections)){ 
	
    str output = "";

    output += "encounter(name=<name>)" + "\n";

    for (Place place <- places) {
         output += provideAnnotation(place); // Call the overloaded version for Place
    }

    return output;
}

//Place
str provideAnnotation (place(typeOfPlace, name, declarations, subPlaces)){  

    str output = "";

    output += "addLocation(name=<name>)" + "\n";

    for (Place subplace <- subPlaces) {

        if (subplace.name == "site"){ // if its a place
            output += provideAnnotation(place); // Call the overloaded version for Place
        }

        if (subplace.name == "structure"){
            output += "addLocation(structure=<intercalate("|", [provideAnnotation(decl) | Declaration decl <- subplace.declarations])>)" + "\n"; 
        }
    }

	return output;
}

//Declaration
str provideAnnotation (Declaration decl){ // Declaration

    str output = "";

    switch(decl){
	
        case declarationSingle(chosenType, name, chosenValue):{

            if (name == "size"){
                output += "<chosenValue>";
            }

            if (name == "location"){
                output += "PlaceIs<chosenValue>";
            }

        }
    }  

    return output;
}


