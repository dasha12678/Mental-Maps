//The AST used for parsing Joris Dormans' template files ().txt.
//This file contains the data structure needed for imploding a parsed .txt tree.

//Imploding = transforming a detailed and often verbose parse tree into abstract syntax tree (AST).

//////////////////////////////////////////////////////////////////////////////
//
// Part of Mental Maps DSL
// @brief   The AST used for parsing Ludoscope Mini files ().lm. 
//			This file contains the data structure needed for imploding
//			a parsed .lm tree.
// @author  Georgia Samaritaki - samaritakigeorgia@gmail.com
// @date    10-10-2021
//
//////////////////////////////////////////////////////////////////////////////
module parsing::Parser

import IO;
import ParseTree;
import parsing::TemplateSyntax;
import parsing::AST;

alias AbstractPipeline = parsing::AST::Template;

////////////////////////////////////////////////
// PARSE
////////////////////////////////////////////////

public &T<:Tree parseProject(loc location) {
    //println("Parse is called on: <projectFile>");
    parseTree = parse(#start[Template], location); 
    return parseTree;
}

////////////////////////////////////////////////
// PARSE AND IMPLODE
////////////////////////////////////////////////

public void parseAndImplodeProject(loc location) {
    //println("Parse is called on: <projectFile>");
    parseTree = parse(#start[Template], location); 
    impl = implode(#AbstractPipeline, parseTree);
    iprintln(impl);
}

public start[Template] parseProject() = 
  parse(#start[Template], |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/mineAnnotated.mm|);

public void parseAndImplodeProject() {
    parseTree = parseProject(); 
    implode(#AbstractPipeline, parseTree);
}