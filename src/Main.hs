module Main where

import Lexer (lex)
import Parser (parse)
import Prelude hiding (lex)

main :: IO ()
main = do 
  tokens <- lex "./../write_a_c_compiler/stage_1/valid/return_2.c"
  let ast = parse tokens
  print ast
  -- print tokens
