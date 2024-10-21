module mentalmapslanguage::Preprocessor

import IO;
import Type;
import List;
import mentalmapslanguage::Parser;
import mentalmapslanguage::AST;

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
    prettyprint(typedefs) + prettyprint(declarations);

//DECLARATIONS
str prettyprint(list[Declaration] decls) = 
    toString([prettyprint(decl) + "\n" | Declaration decl <- decls]);

str prettyprint(declBasic(name, chosenValue)) = 
    "<name> = <chosenValue>;" + "\n";

str prettyprint(declList(name, listValues)) = 
    "<name> = <listValues>;" + "\n";

str prettyprint(declSet(name, setValues)) = 
    "<name> = <setValues>;" + "\n";

str prettyprint(declStruct(name, declarations)) = 
    "<name> { 
        <prettyprint(declarations)>; 
    };" + "\n";

str prettyprint(ifElse(variable, myValue, declsIf, declsElse)) = 
    "if (<variable> = <myValue>) {
        <prettyprint(declsIf)>
    }
    else {
        <prettyprint(declsElse)>
    };";

str prettyprint(ifNoElse(variable, myValue, declsIf)) = 
    "if (<variable> = <myValue>) {
        <prettyprint(declsIf)>
    }";

//TYPEDEFS
str prettyprint(list[TypeDef] typedefs) =
    toString([prettyprint(typedef) | TypeDef typedef <- typedefs]);

str prettyprint(enumDef(modif, name, values)) =
    "<modif> <name> = {<values>};";

str prettyprint(structDef(isRoot, modif, name, members)) =
    "<isRoot> <modif> <name> {
        <prettyprint(members)>
    };";

str prettyprint(listDef(modif, typeOf, name)) =
    "<modif> list[<typeOf>] <name>;";

str prettyprint(setDef(modif, typeOf, name)) =
    "<modif> set[<typeOf>] <name>;";

str prettyprint(boolDef(modif, name)) =
    "<modif> bool <name>;";

str prettyprint(intDef(modif, name)) =
    "<modif> int <name>;";

str prettyprint(floatDef(modif, name)) =
    "<modif> float <name>;";

str prettyprint(strDef(modif, name)) =
    "<modif> string <name>;";

//MEMBERS
str prettyprint(list[Member] members) =
    toString([prettyprint(member) | Member member <- members]);

str prettyprint(initMember(member)) =
    "<prettyprint(member)>";

str prettyprint(initXor(mmbr1, mmbr2)) =
    "<prettyprint(mmbr1)> xor <prettyprint(mmbr2)>;";

str prettyprint(memberDecl(modif, typeOf, name)) =
    "<modif> <typeOf> <name>;";

