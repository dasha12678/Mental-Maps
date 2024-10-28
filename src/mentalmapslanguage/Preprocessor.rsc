module mentalmapslanguage::Preprocessor

import IO;
import Type;
import List;
import String;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;
import mentalmapslanguage::Check;
import Set;

//tree rewriting 
//source-to-source transformation
//Takes a variant (eg "a") -> writes variants to file 

//PROVIDE THE SOURSE LOCATION OF YOUR MENTAL MAP HERE:
loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|;

//WRITE VARIANT TO FILE
void writeVariant(str variant, loc fileLoc) {
    project = preprocessor(variant, parseAndImplodeProject(fileLoc));
    fileLoc = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/Variant.mm|;
    writeFile(fileLoc, prettyprint(project));
}

//RUN THE PREPROCESSOR 
Level preprocessor(str variant, Level level) =
    preprocessor2(variant, preprocessor1(variant, level));

Level preprocessor1(str variant, Level level) =
    visit(level){
        case list[Declaration] _ : [*Declaration pre, Declaration ifelse : ifElse(_, _, _, _), *Declaration post] 
        => pre + preprocessor(variant, ifelse) + post
};

Level preprocessor2(str variant, Level level) = 
    visit(level){
        case list[Declaration] _ : [*Declaration pre, Declaration ifnoelse : ifNoElse(_, _, _), *Declaration post] 
        => pre + preprocessor(variant, ifnoelse) + post
};

list[Declaration] preprocessor(str variant, Declaration ifelse : ifElse(variable, myValue, declsIf, declsElse)){
    if (myValue == variant){
        return declsIf;
    }
    else {
        return declsElse;
    }
}

list[Declaration] preprocessor(str variant, Declaration ifelse : ifNoElse(variable, myValue, declsIf)){
    if (myValue == variant){
        return declsIf;
    }
    return [];
}

//TO DISPLAY THE VARIANT
//OPTIONAL;
str prettyprint(level(typedefs, name, declarations)) = 
    prettyprint(typedefs) + "\n\n" + "Level {\n" + prettyprint(declarations) + "}";

//DECLARATIONS
str prettyprint(list[Declaration] decls) {
    str annos = "";
    for (Declaration decl <- decls){
        switch(decl){
            case declStruct(name, declarations): annos += "\t<prettyprint(decl)>\n";
            default: annos += "\t\t<prettyprint(decl)>\n";
        }
    } 
    return annos;
}

str prettyprint(declBasic(name, chosenValue)) = 
    "<name.name> = <extractValue(chosenValue)>;";

str prettyprint(declList(name, listValues)) = 
    "<name.name> = <getValuesWithoutLocation(listValues)>;";
    //TO DO: expand to include lists of structs

str prettyprint(declSet(name, setValues)) = 
    "<name.name> = <getValuesWithoutLocation(toList(setValues))>;";
    //TO DO: expand to include sets of structs

str prettyprint(declStruct(name, declarations)) {
    return "<name.name> {\n<prettyprint(declarations)>}";
}

//TYPEDEFS
str prettyprint(list[TypeDef] typedefs) {
    str annos = "";
    annos += "typedefs {\n";
    for (TypeDef typedef <- typedefs){
        annos += prettyprint(typedef) + "\n\n";
    }
    annos += "}\n";
    return annos;
}

str prettyprint(enumDef(modif, name, values)) {
    a = toString(getValuesWithoutLocation(values));
    b = replaceAll(a, "[", "");
    c = replaceAll(b, "]", "");
    return solveModif(modif, "enum <name.name> {<c>};");
}

str prettyprint(structDef(isRoot, modif, name, members)) {
    if(isRoot){
        return "root " + solveModif(modif, "struct <name.name> {\n<prettyprint(members)>};");
    };
    return solveModif(modif, "struct <name.name> {\n<prettyprint(members)>};");
}

str prettyprint(listDef(modif, typeOf, name)) =
    solveModif(modif, "list[<(returnMyTypeOf(typeOf))>] <name.name>;");

str prettyprint(setDef(modif, typeOf, name)) =
    solveModif(modif, "set[<returnMyTypeOf(typeOf)>] <name.name>;");

str prettyprint(boolDef(modif, name)) =
    solveModif(modif, "bool <name.name>;");

str prettyprint(intDef(modif, name)) =
    solveModif(modif, "int <name.name>;");

str prettyprint(floatDef(modif, name)) =
    solveModif(modif, "float <name.name>;");

str prettyprint(strDef(modif, name)) =
    solveModif(modif, "str <name.name>;");

//MODIF
str solveModif(Mod modif, str input) {
    switch (modif) {
        case optional(): 
            return "opt " + "<input>";
        default:
            return input;
    }
}

//MEMBERS
str prettyprint(list[Member] members) {
    str annos = "";
    for (Member member <- members){
        annos += prettyprint(member) + "\n";
    }
    return annos;
}

str prettyprint(initMember(member)) =
    "   <prettyprint(member)>";

str prettyprint(initXor(mmbr1, mmbr2)) =
    "   <replaceAll(prettyprint(mmbr1), ";", "")> xor <replaceAll(prettyprint(mmbr2), ";", "")>;";

str prettyprint(memberDecl(modif, typeOf, name)) =
    solveModif(modif, "<typeOf.name> <name.name>;");

str prettyprint(typeDef(typedef)) =
    "<prettyprint(typedef)>";

