module utils::FileUtils

import IO;
import util::Math;
import List;

public void writeFunctionCountsToFile(loc file, map[str, int] counts) {
    str content = "Function Usage Counts:\n"; 

    for (str functionName <- counts) {
        content += "Function: " + functionName + " | Count: " + toString(counts[functionName]) + "\n";
    }

    writeFile(file, content);
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
