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
module parsing::AST

import IO;
import ParseTree;
import parsing::TemplateSyntax;

public parsing::AST::Template implodePipeline(Tree tree)
  = implode(#parsing::AST::Template, tree);
  
public parsing::AST::Template parsePipelineToAST(loc location)
  = implodePipeline(LD_parse(location));

////////////////////////////////////////////////
// IMPLODE
////////////////////////////////////////////////

void testit(loc location) {
changes = parse(#start[Template], location);
impl = implode(#parsing::AST::Template, changes);
iprintln(impl);
}

////////////////////////////////////////////////
// AST
////////////////////////////////////////////////

//ADT that defines the abstract syntax of state machines.
//An algebraic data type (ADT) for describing state machine abstract syntax trees (ASTs).

data Template
    = template(list[Statement] statements);

data Statement
    = funcCall(NAME functionName, list[Parameter] parameters)
    | ifElse(Parameter parameter, list[Statement] statementsIf, list[Statement] statementsElse)
    | include(LOCATION location);

// data Include
//     = include(LOCATION location);

// data FuncCall
//     = funcCall(NAME functionName, list[Parameter] parameters);

data Parameter
    = parameter(NAME name, Option option)
    | parameterWithListContent(NAME name, list[Option] options);

// data Arguments
//     = arguments(list[Parameter] parameters);

// data ListContent
//     = listContent(list[Option] options);

data Option
    = optionName(NAME name)
    | optionBoolean(bool boolean)
    | optionInteger(int integer)
    | optionFloat(real float)
    | optionString(str string);

// data IfElse
//     = ifElse(Parameter parameter, list[Statement] statementsIf, list[Statement] statementsElse);

// data Condition
//     = condition(NAME name, Option option);

// data INTEGER
//     = integerValue(int val);

 data NAME
     = name(str val);

 data LOCATION
     = location(str val);

// data STRING
//     = stringValue(str val);

//  data FLOAT
//      = floatValue(real val);

// data Value
//  	= integer(int integer)
//  	| boolean(bool boolean)
// 	| varName(Name name)
// 	;