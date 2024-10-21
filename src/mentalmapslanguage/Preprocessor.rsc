module mentalmapslanguage::Preprocessor

import IO;
import Type;
import List;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;
import mentalmapslanguage::Check;
import Set;

//tree rewriting 
//source-to-source transformation
//Takes a variant (eg "a") -> writes variants to file 

Level preprocessor(str variant, Level level) =
    visit(level){
    case list[Declaration] _ : [*Declaration pre, Declaration ifelse : ifElse(_, _, _, _), *Declaration post] 
    => pre + preprocessor(variant, ifelse) + post
};

list[Declaration] preprocessor(str variant, Declaration ifelse : ifElse(variable, myValue, declsIf, declsElse)){
    if (myValue == variant){
        return declsIf;
    //TO DO: add case for if without else 
    //TO DO: write to file

    }
    return [];
}

//TO DISPLAY THE VARIANT
//OPTIONAL;
str prettyprint(level(typedefs, name, declarations)) =
    prettyprint(typedefs) + "\n\n" + prettyprint(declarations);

//DECLARATIONS
str prettyprint(list[Declaration] decls) {
    str annos = "";
    for (Declaration decl <- decls){
        annos += prettyprint(decl) + "\n";
    } 
    return annos;
}

str prettyprint(declBasic(name, chosenValue)) = 
    "<name.name> = <extractValue(chosenValue)>;";

str prettyprint(declList(name, listValues)) = 
    "<name.name> = <getValuesWithoutLocation(listValues)>;";

str prettyprint(declSet(name, setValues)) = 
    "<name.name> = <getValuesWithoutLocation(toList(setValues))>;";

str prettyprint(declStruct(name, declarations)) = 
    "<name.name> {\n<prettyprint(declarations)>;\n};";

str prettyprint(ifElse(variable, myValue, declsIf, declsElse)) = 
    "if (<variable.name> = <myValue>) {
        <prettyprint(declsIf)>
    }
    else {
        <prettyprint(declsElse)>
    };";

str prettyprint(ifNoElse(variable, myValue, declsIf)) = 
    "if (<variable.name> = <myValue>) {
        <prettyprint(declsIf)>
    }";

//TYPEDEFS
str prettyprint(list[TypeDef] typedefs) {
    str annos = "";
    for (TypeDef typedef <- typedefs){
        annos += prettyprint(typedef) + "\n\n";
    }
    return annos;
}

str prettyprint(enumDef(modif, name, values)) = 
    solveModif(modif, "enum <name.name> {<getValuesWithoutLocation(values)>};");

str prettyprint(structDef(isRoot, modif, name, members)) {
    if(isRoot){
        return "root " + solveModif(modif, "struct <name.name> {\n<prettyprint(members)>}");
    };
    return solveModif(modif, "struct <name.name> {\n<prettyprint(members)>};");
}

str prettyprint(listDef(modif, typeOf, name)) =
    solveModif(modif, "list[<typeOf>] <name.name>;");

str prettyprint(setDef(modif, typeOf, name)) =
    solveModif(modif, "set[<typeOf>] <name.name>;");

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
    "<prettyprint(mmbr1)> xor <prettyprint(mmbr2)>;";

str prettyprint(memberDecl(modif, typeOf, name)) =
    solveModif(modif, "<typeOf.name> <name.name>;");

str prettyprint(typeDef(typedef)) =
    "<prettyprint(typedef)>";


void writeVariant(Level project) {
fileLoc = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/Variant.rsc|;
writeFile(fileLoc, "module mentalmapslanguage::Variant\n\n");
appendToFile(fileLoc, prettyprint(project));
}