//////////////////////////////////////////////////////////////////////////////
//
// Mental Maps DSL - Parser
// @brief   This file contains the data structure needed for imploding
//			a parsed .lm tree.
// @author  Daria Protsenko - daria.protsenkoo@gmail.com
// @date    15-08-2024
//
//////////////////////////////////////////////////////////////////////////////
module mentalmapslanguage::Parser

import IO;
import ParseTree;
import mentalmapslanguage::SyntaxDefinition;
import mentalmapslanguage::AST;
import vis::Text;

alias AbstractPipeline = mentalmapslanguage::AST::Level;

//alias AbstractPipeline = mentalmapslanguage::AST::Template;

////////////////////////////////////////////////
// PARSE
////////////////////////////////////////////////

public &T<:Tree parseProject(loc location) {
    //println("Parse is called on: <projectFile>");
    parseTree = parse(#start[Level], location); 
    return parseTree;
}

////////////////////////////////////////////////
// PARSE AND IMPLODE
////////////////////////////////////////////////

public Level parseAndImplodeProject(loc location) {
    //println("Parse is called on: <projectFile>");
    parseTree = parse(#start[Level], location); 
    impl = implode(#AbstractPipeline, parseTree);
    //iprintln(impl);
    return impl;
}

//////////////////////////////////////////////////	
//Extra parsers
//////////////////////////////////////////////////

 public start[Level] LD_parse(str src) = 
   parse(#start[Level], src);

 public start[Level] LD_parse(str src, loc file) = 
   parse(#start[Level], src, file);
  
public start[Level] LD_parse(loc file) =
  parse(#start[Level], file);

loc level = |file:///C:/Users/dasha/Thesis/mental-maps/src/mentalmapslanguage/examples/reallysimplemine.mm|;

//println(prettyTree(t)); to pretty print the parse tree













