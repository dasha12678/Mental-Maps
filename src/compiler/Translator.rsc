module compiler::Translator

import IO;
import String;
import ParseTree;
import List;
import Type;

import compiler::AST;
import compiler::Parser;
import compiler::Functions;
import compiler::Generator;
import compiler::Util;

import mentalmapslanguage::AST;
import mentalmapslanguage::Parser;

//PROVIDE THE SOURSE LOCATION OF YOUR FEATURE MODEL HERE:
loc myFeatureModel = |file:///|;

//PROVIDE THE SOURSE LOCATION OF YOUR MENTAL MAP HERE:
loc myFile = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|;

//RUN PRE-GENERATOR
void preGenerator() { 
    generateCode(); 
}

//RUN GENERATOR
str Generator() { 
    Level level = parseAndImplodeProject(myFile);
    return translator(level);
}



