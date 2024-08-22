module mentalmapslanguage::CST2AST

import mentalmapslanguage::AST;
import mentalmapslanguage::SyntaxDefinition;
import ParseTree;

/*
 * Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 *
 * - Use switch to do case distinction with concrete patterns (like in Hack your JS) 
 * - Map regular CST arguments (e.g., *, +, ?) to lists 
 *   (NB: you can iterate over * / + arguments using `<-` in comprehensions or for-loops).
 * - Map lexical nodes to Rascal primitive types (bool, int, str)
 * - See the ref example on how to obtain and propagate source locations.
 */

Level cst2ast(start[Level] sf) {
  Level f = sf.top; // remove layout before and after form
  return level("", [], [], [], []);
}