module compiler::Functions
import List;
import util::Eval;

    str UnexploredLevel(list[str] places){
        return "<places>";}

    str name(str chosenValue){
        return "//place your annotation here";}

    str Place(list[str] declarations){
        return "addLocation(structure=<intercalate("|", declarations)>)" + "\n";}

    str id(str chosenValue){
        return "//place your annotation here";}

    str structure(str chosenValue){
        return "//place your annotation here";}

    str size(str chosenValue){
        return "<chosenValue>";}

    str location(str chosenValue){
        return "PlaceIs<chosenValue>";}
