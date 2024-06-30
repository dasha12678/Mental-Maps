module utils::FileUtils

import IO;
import util::Math;
import List;

public void writeFunctionCountsToFile(loc file, map[str, int] counts) {
    str content = "THIS FILE DISPLAYS VARIABLE CALLS USED AND THEIR COUNTER\n";
    content += "(HOW MANY TIMES THEY HAVE BEEN USED ACROSS ALL TEMPLATES)\n\n";
    content += "Function Usage Counts:\n";

    list[tuple[str, int]] countList = [<functionName, counts[functionName]> | functionName <- counts];
    countList = sort(countList, bool (tuple[str, int] a, tuple[str, int] b){ return a[1] > b[1]; });

    for (tuple[str, int] entry <- countList) {
        content += "Function: " + entry[0] + " | Count: " + toString(entry[1]) + "\n";
    }

    writeFile(file, content);
}

void writeFunctionParamsToFile(loc file, map[str, map[str, list[str]]] functionParams) {
    str content = "THIS FILE DISPLAYS VARIABLE CALLS USED ACROSS ALL TEMPLATES\n";
    content += "WITH THEIR RESPECTIVE PARAMETERS AND VALUES \n\n";
    content += "Function Parameters:\n";

    for (str functionName <- functionParams) {
        content += "Function: " + functionName + "\n";
        map[str, list[str]] paramMap = functionParams[functionName];
        for (str param <- paramMap) {
            content += "  Parameter: " + param + ", Values: " + toString(paramMap[param]) + "\n";
        }
    }

    writeFile(file, content);
}

public void writeFunctionParamCountsToFile(loc file, map[str, map[str, int]] functionParamCounts) {
    str content = "THIS FILE DISPLAYS PARAMETERS USED IN EACH VARIABLE CALL AND\n";
    content += "THEIR COUNTER (HOW MANY TIMES THEY HAVE BEEN USED IN RESPECTIVE VARIABLE CALL)\n\n";
    content += "Function Parameters Usage Counts:\n";

    for (str functionName <- functionParamCounts) {
        content += "Function: " + functionName + "\n";
        map[str, int] paramMap = functionParamCounts[functionName];
        
        list[tuple[str, int]] paramList = [<param, paramMap[param]> | param <- paramMap];
        paramList = sort(paramList, bool (tuple[str, int] a, tuple[str, int] b) { return a[1] > b[1]; });

        for (tuple[str, int] entry <- paramList) {
            content += "  Parameter: " + entry[0] + " | Count: " + toString(entry[1]) + "\n";
        }
    }

    writeFile(file, content);
}

void writeMandatoryParamsToFile(loc outputFile, map[str, set[str]] mandatoryParams) {
    str content = "THIS FILE DISPLAYS MANDATORY PARAMETERS FOR EACH VARIABLE CALL,\n";
    content += "WHICH ARE PARAMETERS USED IN EVERY OCCURENCE OF THAT VARIABLE CALL ACROSS ALL TEMPLATES\n\n";

    content += "FUNCTIONS WITH MANDATORY PARAMETERS:\n\n";
    for (str functionName <- mandatoryParams<0>) {
        content += "Function: " + functionName + "\n";
        set[str] params = mandatoryParams[functionName];
        for (str param <- params) {
            content += "  Mandatory Parameter: " + param + "\n";
        }
        content += "\n";
    }

    writeFile(outputFile, content);
}

