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
// ADT
////////////////////////////////////////////////

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
    | customType(str name);

data Level = level(str name, list[TypeDef] typedefs, list[Annotation] annotations, list[Place] places, list[Connection] connections);

data Place = place(TypeOfPlace typeOfPlace, str name, list[Statement] statements, list[Place] subPlaces);

data Statement
  = AnnotationStatement(Annotation annotation)
  | EntityStatement(Entity entity);

data Entity
  = TypeOfEntity(str typeOfEntity)
  | SingleEntity(str nameOfEntity)
  | MultipleEntities(Entity firstEntity, Entity secondEntity)
  | chooseEntity(Entity firstEntity, Entity secondEntity);

data Annotation = annotation(list[EnumCall] enumCalls);

data EnumCall = 
    enumCallSingle (Type chosenType, str name, str chosenValue) 
  | enumCallMultiple(Type chosenType, str name, list[str] chosenValues);

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
