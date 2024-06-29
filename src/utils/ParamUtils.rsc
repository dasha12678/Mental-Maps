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
