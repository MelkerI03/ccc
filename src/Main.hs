module Main where

import Lexer (lex)
import Prelude hiding (lex)

main :: IO ()
main = do 
  tokens <- lex "/home/viking/projects/ccc/write_a_c_compiler/stage_1/valid/return_2.c"
  print tokens
