module utils::TemplateUtils

import IO;
import Location;
import String;

//Collect locations of all template files in Unexplored2 project
public list[loc] listFiles(loc dir) {
    list[loc] files = [];
    for (str entryName <- listEntries(dir)) { 
        loc entry = dir + "/" + entryName;
        if (isFile(entry) && endsWith(entryName, ".txt")) {
            files += [entry];
        }
    }
    return files;
}

public set[str] intersectAll(list[set[str]] sets) {
    if (sets == []) {
        return {}; 
    }
    set[str] commonElements = sets[0]; 
    for (set[str] s <- sets[1..]) {
        commonElements = {x | x <- commonElements, x in s}; 
    }
    return commonElements;
}
