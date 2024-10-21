module compiler::Translator

import compiler::Build;
import compiler::Pregenerator;
import compiler::Generator;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//PROVIDE THE SOURSE LOCATION OF YOUR MENTAL MAP HERE:
loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/newLevel.mm|;

//PARSE AND IMPLODE MENTAL MAP
Level level = parseAndImplodeProject(myFile);

//BUILD ANNOTATIONS
void buildFunctions() { 
    builder(level);
}

//RUN PRE-GENERATOR
void preGenerator() { 
    generateCode(level); 
}
 
//RUN GENERATOR
str Generator() { 
    return translator(level, "Level");
}

//build function - create Functions (run once) traverse(FM) run on the typedef 
//generateCode() - pre-generator (generate generator) in Util run on the decl - everytime a new level is made
//translator() 


