//////////////////////////////////////////////////////////////////////////////
//
// Part of Mental Maps DSL
// @brief   Automated feature extraction with Rascal.
// @author  Daria Protsenko - daria.protsenkoo@gmail.com
// @date    26-06-2024
//
//////////////////////////////////////////////////////////////////////////////

module FeatureExtraction

import IO;
import Location;
import ParseTree;
import String;

import util::LanguageServer;
import util::Reflective;
import util::Math;

import parsing::TemplateSyntax;
import parsing::Parser;
import parsing::AST;

loc folderPath = |file:///C:/Users/dasha/Thesis/Unexplored2-master/Unexplored2-master/Assets/Resources/Templates/Encounters/Destinations|;
loc outputFile = |project://mental-maps/src/Features.txt|;

list[loc] listFiles(loc dir) {
  list[loc] files = [];
  for (str entryName <- listEntries(dir)) { //listEntries list[str] lists entries in a directory
    loc entry = dir + "/" + entryName;
    if (isFile(entry) && endsWith(entryName, ".txt")) {
      files += [entry];
    }
  }
  return files;
}

void featureExtraction(loc templateFolderPath){
map[NAME, int] functionCounts = (); // Map to store function name -> count
  
  for (loc templateFile <- listFiles(templateFolderPath)) {
    Tree parseTree = parseProject(templateFile);

        top-down visit(parseTree) {
            case (Statement) `<NAME x> (<{Parameter ","}* _>)` : {
                if (x in functionCounts) {
                    functionCounts[x] = functionCounts[x] + 1;
                } else {
                    functionCounts[x] = 1;
                }
            }
        }
  //println(functionCounts);
  }
  println("Function Usage Counts:");
    for (NAME functionName <- functionCounts) {
      println("<functionName>: <functionCounts[functionName]>");
 }
}

void featureExtraction1(loc templateFolderPath, loc outputFile){
map[str, int] functionCounts = (); // Map to store function name -> count
  
  for (loc templateFile <- listFiles(templateFolderPath)) {
    Tree parseTree = parseProject(templateFile);
    impl = implode(#parsing::AST::Template, parseTree);

        top-down visit(impl) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        if (name in functionCounts) {
                            functionCounts[name] = functionCounts[name] + 1;
                        } else {
                            functionCounts[name] = 1;
                        }
                    }
                }
            }
        }
    }
    writeFunctionCountsToFile(outputFile, functionCounts); // Writing to file in a readable format
}

void writeFunctionCountsToFile(loc file, map[str, int] counts) {
    str content = "Function Usage Counts:\n"; // Initialize content string with a header

    // Construct content string with formatted entries
    for (str functionName <- counts) {
        content += "Function: " + functionName + " | Count: " + toString(counts[functionName]) + "\n";
    }

    writeFile(file, content);
}

set[str] intersectAll(list[set[str]] sets) {
    if (sets == []) {
        return {}; // Return empty set if no sets are provided
    }
    set[str] commonElements = sets[0]; // Start with the first set
    for (set[str] s <- sets[1..]) {
        commonElements = {x | x <- commonElements, x in s}; // Intersection with each subsequent set
    }
    return commonElements;
}

set[str] intersect(set[str] a, set[str] b) {
    return a & b;
}

void featureExtraction2(loc templateFolderPath, loc outputFile) {
    set[str] allFunctions = {}; // Set to store all unique functions
    list[set[str]] fileFunctionSets = []; // List to store function sets for each file

    // Iterate over each file in the template folder
    for (loc templateFile <- listFiles(templateFolderPath)) {
        set[str] functionSet = {}; // Set to store functions in the current file
        Tree parseTree = parseProject(templateFile);
        impl = implode(#parsing::AST::Template, parseTree);

        // Collect functions in the current file
        top-down visit(impl) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        functionSet += name;
                    }
                }
            }
        }
        
        fileFunctionSets += functionSet; // Add the current file's function set to the list
    }

    set[str] commonFunctions = {};
    if (size(fileFunctionSets) > 0) {
        commonFunctions = intersectAll(fileFunctionSets);
    }

    // Write the common functions to the output file
    writeFile(outputFile, commonFunctions);

    // // Print common functions to the console
    // println("Common Functions:");
    // for (str functionName <- commonFunctions) {
    //     println(functionName);
    //}
}

// void featureExtraction3(loc templateFolderPath, loc outputFile) {
//     map[str, list[tuple[str name, str val]]] functionParams = (); // Map to store function name -> list of parameter tuples (name, value)

//     for (loc templateFile <- listFiles(templateFolderPath)) {
//         Tree parseTree = parseProject(templateFile);
//         impl = implode(#parsing::AST::Template, parseTree);

//         top-down visit(impl) {
//             case /Statement stmt: {
//                 switch (stmt) {
//                     case funcCall(str name, list[Parameter] parameters): {
//                         list[tuple[str name, str val]] paramList = [];
//                         for (Parameter param <- parameters) {
//                             tuple[str, str] paramInfo = extractParamInfo(param);
//                             paramList += paramInfo;
//                         }
//                                                 // Check if name is already a key in functionParams
//                         if (name in functionParams) {
//                             functionParams[name] += paramList; // Append paramList to existing list
//                         } else {
//                             functionParams[name] = paramList; // Initiate paramList for new function name
//                         }
//                         //println(paramList);
//                         //println(functionParams[name]);
//                     }
//                 }
//             }
//         }
//     }

//     for (str key <- functionParams) {
//     println("First element: " + key + functionParams[key]);
//     break; // Exit the loop after printing the first element
//     }
//     writeFunctionParamsToFile(outputFile, functionParams); // Writing to file in a readable format
// }

// tuple[str, str] extractParamInfo(Parameter param) {
//       tuple[str, str] result = <"", "">;
//       switch (param) {
//         case parameter(str name, Option option): result = <name, optionToString(option)>; 
//         case parameterWithListContent(str name, list[Option] options): {
//         result = <name, optionsToString(options)>;
//         }
//     }
//   return(result);
// }

// str optionToString(Option option) {
//     str result = "";
    
//     switch (option) {
//         case optionName(str name): result = name;
//         case optionBoolean(bool boolean): result = boolean ? "true" : "false";
//         case optionInteger(int integer): result = "<integer>"; // Convert integer to string
//         case optionFloat(real float): result = "<float>"; // Convert float to string
//         case optionString(str string): result = string;
//     }
    
//     return result;
// }

// str optionsToString(list[Option] options) {
//     return "{" + toString([optionToString(opt) | opt <- options]) + "}";
// }

// void writeFunctionParamsToFile(loc file, map[str, list[tuple[str name, str val]]] functionParams) {
//     str content = "Function Parameters:\n";

//     for (str functionName <- functionParams) {
//         content += "Function: " + functionName + "\n";
//         list[tuple[str name, str val]] params = functionParams[functionName];
//         for (tuple[str name, str val] param <- params) {
//             content += "  Parameter: " + param.name + ", Value: " + param.val + "\n";
//         }
//     }

//     writeFile(file, content);
// }

///////////////////////////////////////////////////////

void featureExtraction3(loc templateFolderPath, loc outputFile) {
    map[str, map[str, list[str]]] functionParams = (); // Map to store function name -> map of parameter name -> value

    for (loc templateFile <- listFiles(templateFolderPath)) {
        Tree parseTree = parseProject(templateFile);
        impl = implode(#parsing::AST::Template, parseTree);

        top-down visit(impl) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        map[str, list[str]] paramInfo = ();

                        // Extract parameter information for the current function call
                        for (Parameter param <- parameters) {
                            map[str, list[str]] paramInfoPart = extractParamInfo(param);
                            // Merge paramInfoPart into paramInfo
                            for (str paramKey <- paramInfoPart) {
                              paramInfo[paramKey] = paramInfoPart[paramKey];
                            }
                        }

                        //PREVIOUS VERSION WITHOUT VALUES
                        // // Extract parameter information for the current function call
                        // for (Parameter param <- parameters) {
                        //     map[str, str] paramInfoPart = extractParamInfo(param);
                        //     // Merge paramInfoPart into paramInfo
                        //     for (str paramKey <- paramInfoPart) {
                        //         paramInfo[paramKey] = paramInfoPart[paramKey];
                        //     }
                        // }


                        // Update functionParams with paramInfo for the current function name
                        if (name in functionParams) {
                            // Merge paramInfo into existing functionParams[name]
                            map[str, list[str]] existingParams = functionParams[name];
                            for (str paramKey <- paramInfo) {
                                if (paramKey in existingParams) {
                                    for (str paramValue <- paramInfo[paramKey]) {      //!!!!
                                        if (!(paramValue in existingParams[paramKey])) {
                                            existingParams[paramKey] += paramValue;
                                        }
                                    }
                                } else {
                                    existingParams[paramKey] = paramInfo[paramKey];
                                }
                            }
                            functionParams[name] = existingParams;
                        } else {
                            // Initiate paramInfo for new function name
                            functionParams[name] = paramInfo;
                        }
                    }
                }
            }
        }
    }

      //PREVIOUS VERSION WITHOUT VALUES
        // // Update functionParams with paramInfo for the current function name
        //                 if (name in functionParams) {
        //                     // Merge paramInfo into existing functionParams[name]
        //                     map[str, str] existingParams = functionParams[name];
        //                     for (str paramKey <- paramInfo) {
        //                         existingParams[paramKey] = paramInfo[paramKey];
        //                     }
        //                     functionParams[name] = existingParams;
        //                 } else {
        //                     // Initiate paramInfo for new function name
        //                     functionParams[name] = paramInfo;
        //                 }

    writeFunctionParamsToFile(outputFile, functionParams); // Writing to file in a readable format
}

map[str, list[str]] extractParamInfo(Parameter param) {
    map[str, list[str]] result = ();
    switch (param) {
        case parameter(str name, Option option): {
          result[name] = [optionToString(option)];
        }
        case parameterWithListContent(str name, list[Option] options): {
          result[name] = optionsToString(options);
        }
    }
    return result; 
}

str optionToString(Option option) {
    switch (option) {
        case optionName(str name): return name;
        case optionBoolean(bool boolean): return boolean ? "true" : "false";
        case optionInteger(int integer): return "<integer>"; // Convert integer to string
        case optionFloat(real float): return "<float>"; // Convert float to string
        case optionString(str string): return string;
    }
    return "";
}

// str optionsToString(list[Option] options) {
//     return "{" + toString([optionToString(opt) | opt <- options]) + "}";
// }

list[str] optionsToString(list[Option] options) {
    return [optionToString(opt) | opt <- options];
}

void writeFunctionParamsToFile(loc file, map[str, map[str, list[str]]] functionParams) {
    str content = "Function Parameters:\n";

    for (str functionName <- functionParams) {
        content += "Function: " + functionName + "\n";
        map[str, list[str]] paramMap = functionParams[functionName];
        for (str param <- paramMap) {
            content += "  Parameter: " + param + ", Values: " + toString(paramMap[param]) + "\n";
        }
    }

    writeFile(file, content);
}