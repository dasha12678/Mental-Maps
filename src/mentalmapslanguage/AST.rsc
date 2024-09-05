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

// data TypeOfPlace = 
//   site(str site)
// | room(str room)
// | path(str path)
// | entrance(str entrance)
// | environment(str environment);

// data Type 
//     = boolean(bool boolean) 
//     | string(str string) 
//     | integer(int integer) 
//     | float(real float) 
//     | customType(str name);

data Level = level(str levelName, list[TypeDef] typedefs, list[Place] places, list[Connection] connections);

data Place = place(str typeOfPlace, str placeName, list[EnumCall] enumCalls, list[Place] subPlaces);

data EnumCall = 
    enumCallSingle(str chosenType, str name, str chosenValue) 
  | enumCallMultiple(str chosenType, str name, list[str] chosenValues)
  | enumCallChoose(str chosenType, str name, str chosenValue1, str chosenValue2);

data Connection = connection(str site1, str site2, Value direction);

data TypeDef = typedef(str name, list[Value] values);

data Value = 
    boolValue(bool boolValue)
  | intValue(int intValue)
  | floatValue(real floatValue)
  | stringValue(str stringValue)
  | enumValue(str nameValue)
  | listValue(list[Value] listValues)
  | setValue(set[Value] setValues);
