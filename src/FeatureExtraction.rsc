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
import ParseTree;

import parsing::Parser;
import parsing::AST;

import utils::FileUtils;
import utils::ParamUtils;
import utils::TemplateUtils;

loc folderPath = |file:///C:/Users/dasha/Thesis/Unexplored2-master/Unexplored2-master/Assets/Resources/Templates/Encounters/Destinations|;
loc outputFile = |project://mental-maps/src/feature-extraction-results/Features.txt|;

////////////////////////////////////////////////
// DISPLAY VARIABLE CALL COUNTER - ABSTRACT SYNTAX IMPLEMENTATION
////////////////////////////////////////////////

void featureExtraction1(loc templateFolderPath, loc outputFile){
    map[str, int] functionCounts = (); // Map to store function name -> count
  
    for (loc templateFile <- listFiles(templateFolderPath)) {
        top-down visit(parsePipelineToAST(templateFile)) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] _): {
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

////////////////////////////////////////////////
// DISPLAY MANDATORY VARIABLE CALLS - ABSTRACT SYNTAX IMPLEMENTATION
////////////////////////////////////////////////

void featureExtraction2(loc templateFolderPath, loc outputFile) {
    set[str] allFunctions = {}; 
    list[set[str]] fileFunctionSets = []; 

    for (loc templateFile <- listFiles(templateFolderPath)) {
        set[str] functionSet = {}; 

        top-down visit(parsePipelineToAST(templateFile)) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] _): {
                        functionSet += name;
                    }
                }
            }
        }
        fileFunctionSets += functionSet; 
    }
    set[str] commonFunctions = {};
    if (size(fileFunctionSets) > 0) {
        commonFunctions = intersectAll(fileFunctionSets);
    }
    writeFile(outputFile, commonFunctions);
    //println(commonFunctions);
}

////////////////////////////////////////////////
// DISPLAY VARIABLE CALL -> PARAMETER -> VALUE
////////////////////////////////////////////////

void featureExtraction3(loc templateFolderPath, loc outputFile) {
    map[str, map[str, list[str]]] functionParams = (); // Map to store function name -> map of parameter name -> value

    for (loc templateFile <- listFiles(templateFolderPath)) {

        top-down visit(parsePipelineToAST(templateFile)) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        map[str, list[str]] paramInfo = getParamInfo(parameters);

                        if (name in functionParams) {
                            map[str, list[str]] existingParams = functionParams[name];
                            for (str paramKey <- paramInfo) {
                                if (paramKey in existingParams) {
                                    for (str paramValue <- paramInfo[paramKey]) {  
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
                            functionParams[name] = paramInfo;
                        }
                    }
                }
            }
        }
    }

    writeFunctionParamsToFile(outputFile, functionParams); // Writing to file in a readable format
}

////////////////////////////////////////////////
// FUNCTION AND PARAMETER COUNTS
////////////////////////////////////////////////

void featureExtraction4(loc templateFolderPath, loc outputFile) {
    map[str, map[str, int]] functionParamCounts = (); // Map to store function name -> map of parameter name -> count

    for (loc templateFile <- listFiles(templateFolderPath)) {

        top-down visit(parsePipelineToAST(templateFile)) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        map[str, int] paramCounts = getParamCounts(parameters);

                        if (name in functionParamCounts) {
                            map[str, int] existingParamCounts = functionParamCounts[name];
                            for (str paramKey <- paramCounts) {
                                if (paramKey in existingParamCounts) {
                                    existingParamCounts[paramKey] = existingParamCounts[paramKey] + paramCounts[paramKey];
                                } else {
                                    existingParamCounts[paramKey] = paramCounts[paramKey];
                                }
                            }
                            functionParamCounts[name] = existingParamCounts;
                        } else {
                            functionParamCounts[name] = paramCounts;
                        }
                    }
                }
            }
        }
    }

    writeFunctionParamCountsToFile(outputFile, functionParamCounts); 
}

////////////////////////////////////////////////
// VARIABLE CALL AND MANDATORY PARAMETERS
////////////////////////////////////////////////

void featureExtraction5(loc templateFolderPath, loc outputFile) {
    map[str, set[str]] functionMandatoryParams = (); 

    for (loc templateFile <- listFiles(templateFolderPath)) {
        map[str, set[str]] functionParamSets = (); 

        top-down visit(parsePipelineToAST(templateFile)) {
            case /Statement stmt: {
                switch (stmt) {
                    case funcCall(str name, list[Parameter] parameters): {
                        set[str] paramSet = getParameterSet(parameters);

                        if (name in functionParamSets) {
                            functionParamSets[name] += paramSet;
                        } else {
                            functionParamSets[name] = paramSet;
                        }
                    }
                }
            }
        }

        for (str functionName <- functionParamSets) {
            if (functionName in functionMandatoryParams) {
                functionMandatoryParams[functionName] = intersectAll([functionMandatoryParams[functionName], functionParamSets[functionName]]);
            } else {
                functionMandatoryParams[functionName] = functionParamSets[functionName];
            }
        }
    }
    writeMandatoryParamsToFile(outputFile, functionMandatoryParams); 
}
