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
  | listDef(Mod modif, Value typeOf, ID name, loc src = |unknown:///|)
  | setDef(Mod modif, Value typeOf, ID name, loc src = |unknown:///|)
  | boolDef(Mod modif, ID name, loc src = |unknown:///|)
  | intDef(Mod modif, ID name, loc src = |unknown:///|) 
  | floatDef(Mod modif, ID name, loc src = |unknown:///|) 
  | strDef(Mod modif, ID name, loc src = |unknown:///|) 
  ;

  data MemberDecl
  = memberDecl(Mod modif, ID typeOf, ID name, loc src = |unknown:///|)
  | typeDef(TypeDef typedef, loc src = |unknown:///|) 
  ;

  data Member
  = initMember(MemberDecl member, loc src = |unknown:///|)
  | initXor(MemberDecl mmbr1, MemberDecl mmbr2, loc src = |unknown:///|) 
  ;

data Declaration 
  = declBasic(ID name, Value chosenValue, loc src = |unknown:///|)
  | declList(ID name, list[Value] listValues, loc src = |unknown:///|)
  | declSet(ID name, set[Value] setValues, loc src = |unknown:///|)
  | declStruct(ID name, list[Declaration] declarations, loc src = |unknown:///|)
  | ifElse(ID variable, str myValue, list[Declaration] declsIf, list[Declaration] declsElse, loc src = |unknown:///|) 
  | IfNoElse(ID variable, str myValue, list[Declaration] declsIf, loc src = |unknown:///|)
  ;

data Mod
  = optional() 
  | required()
  | or()
  | xor()
  ;

data ID
  = id(str name, loc src = |unknown:///|);
