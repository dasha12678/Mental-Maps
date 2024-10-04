//////////////////////////////////////////////////////////////////////////////
//
// Part of Mental Maps DSL
// @brief   The AST used for parsing Ludoscope Mini files ().lm. 
//			This file contains the data structure needed for imploding
//			a parsed .lm tree
// @author  Daria Protsenko - daria.protsenkoo@gmail.com
// @date    10-10-202
//
//////////////////////////////////////////////////////////////////////////////
module mentalmapslanguage::AST

import mentalmapslanguage::SyntaxDefinition;

////////////////////////////////////////////////
// ADT
////////////////////////////////////////////////

data Type 
  = boolean(bool boolean, loc src = |unknown:///|) 
  | string(str string, loc src = |unknown:///|) 
  | integer(int integer, loc src = |unknown:///|) 
  | float(real float, loc src = |unknown:///|) 
  | lists(list[Type] myList, loc src = |unknown:///|)
  | sets(set[Type] mySet, loc src = |unknown:///|)
  | enum(str enum, loc src = |unknown:///|)
  | struct(str struct, loc src = |unknown:///|)
  ;

data Value = 
    boolValue(bool boolValue, loc src = |unknown:///|)
  | intValue(int intValue, loc src = |unknown:///|)
  | floatValue(real floatValue, loc src = |unknown:///|)
  | stringValue(str stringValue, loc src = |unknown:///|)
  | declValue(str nameValue, loc src = |unknown:///|)
  ;

data Level = level(list[TypeDef] typedefs, ID name, list[Declaration] declarations, loc src = |unknown:///|)
  ;

data TypeDef
  = enumDef(Mod modif, ID name, list[Value] values, loc src = |unknown:///|)
  | structDef(bool isRoot, Mod modif, ID name, list[Member] members, loc src = |unknown:///|) 
  | listDef(Mod modif, ID idtype, ID name, loc src = |unknown:///|)
  | setDef(Mod modif, ID idtype, ID name, loc src = |unknown:///|)
  | boolDef(Mod modif, ID name)
  | intDef(Mod modif, ID name) 
  | floatDef(Mod modif, ID name) 
  | strDef(Mod modif, ID name) 
  ;

  data MemberDecl
  = init(Mod modif, ID typeCustom, ID name, loc src = |unknown:///|)
  | defBasic(Mod modif, Type typeOf, ID name, loc src = |unknown:///|)
  ;

data Declaration 
  = decl(ID name, Value chosenValue, loc src = |unknown:///|)
  | declList(ID name, list[Value] setValues, loc src = |unknown:///|)
  | declSet(ID name, set[Value] listValues, loc src = |unknown:///|)
  | declStruct(ID name, list[Declaration] declarations, loc src = |unknown:///|)
  | ifElse(ID variable, Value myValue, list[Declaration] declsIf, list[Declaration] declsElse, loc src = |unknown:///|) 
  ;

data Member
  = initMember(MemberDecl member, loc src = |unknown:///|)
  | initXor(MemberDecl mmbr1, MemberDecl mmbr2, loc src = |unknown:///|) 
  ;

data Mod
  = optional(loc src = |unknown:///|) 
  | required(loc src = |unknown:///|)
  | or(loc src = |unknown:///|)
  | xor(loc src = |unknown:///|)
  ;

data ID
  = id(str name, loc src = |unknown:///|);


