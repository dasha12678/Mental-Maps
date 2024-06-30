module utils::ParamUtils

import parsing::AST;

// Extract parameters
public map[str, list[str]] getParamInfo(list[Parameter] parameters) {
    map[str, list[str]] paramInfo = ();

    for (Parameter param <- parameters) {
        map[str, list[str]] paramInfoPart = extractParamInfo(param);
        for (str paramKey <- paramInfoPart) {
            paramInfo[paramKey] = paramInfoPart[paramKey];
        }
    }
    return paramInfo;
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

public map[str, int] getParamCounts(list[Parameter] parameters) {
    map[str, int] paramCounts = ();
    for (Parameter param <- parameters) {
        str paramName = extractParamName(param);
        if (paramName in paramCounts) {
            paramCounts[paramName] = paramCounts[paramName] + 1;
        } else {
            paramCounts[paramName] = 1;
        }
    }
    return paramCounts;
}

// Extract parameter name
public str extractParamName(Parameter param) {
    switch (param) {
        case parameter(str name, _): return name;
        case parameterWithListContent(str name, _): return name;
    }
    return "";
}

set[str] getParameterSet(list[Parameter] parameters) {
    set[str] paramSet = {};
    for (Parameter param <- parameters) {
        paramSet += extractParamName(param);
    }
    return paramSet;
}

public str optionToString(Option option) {
    switch (option) {
        case optionName(str name): return name;
        case optionBoolean(bool boolean): return boolean ? "true" : "false";
        case optionInteger(int integer): return "<integer>"; 
        case optionFloat(real float): return "<float>"; 
        case optionString(str string): return string;
    }
    return "";
}

public list[str] optionsToString(list[Option] options) {
    return [optionToString(opt) | opt <- options];
}
