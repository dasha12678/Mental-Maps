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

import IO;
import ParseTree;
import mentalmapslanguage::MMgrammar;

////////////////////////////////////////////////
// AST
////////////////////////////////////////////////

data NAME = name(str name);

data SIZE = 
  tiny()
  | small()
  | medium()
  | large();

data DIRECTION = 
north() 
| east() 
| south() 
| west() 
| northeast() 
| northwest()
| southeast() 
| southwest();

data TypeOfPlace = 
site()
| room()
| path()
| entrance()
| environment();

data Type 
    = boolean(bool boolean) 
    | string(str string) 
    | integer(int integer) 
    | float(real float) 
    | customType(NAME name);

data Level = level(NAME name, list[TypeDef] typedefs, list[Annotation] annotations, list[Place] places, list[Connection] connections);

data Place = place(TypeOfPlace typeOfPlace, NAME name, list[Statement] statements, list[Place] subPlaces);

data Statement = 
    location(DIRECTION location) 
  | size(SIZE size) 
  | isGoal() 
  | antechamber() 
  | lock(NAME lock) 
  | key(NAME key) 
  | style(NAME style) 
  | item(NAME item) 
  | direction(DIRECTION direction) 
  | encounter(NAME encounter) 
  | storyElement(NAME storyElement) 
  | annotation(Annotation annotation);

data Annotation = annotation(list[EnumCall] enumCalls);

data EnumCall = 
    enumCallSingle (Type chosenType, NAME name, NAME chosenValue) 
  | enumCallMultiple(Type chosenType, NAME name, list[NAME] chosenValues);

data Connection = connection(NAME site1, NAME site2, DIRECTION direction);

data TypeDef = typedef(NAME name, list[Value] values);

data Value = 
    boolValue(bool boolValue)
  | intValue(int intValue)
  | floatValue(real floatValue)
  | stringValue(str stringValue)
  | enumValue(NAME nameValue)
  | listValue(list[Value] listValue)
  | setValue(set[Value] setValue);
