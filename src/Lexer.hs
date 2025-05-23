module Lexer where

import Types
import Tokenizer (tokenize)
import Data.Char (isNumber, isLetter)
import Data.List (findIndex, isPrefixOf, tails)
import Data.Maybe (isJust)

lex :: FilePath -> IO [Token]
lex path = do
  content <- readFile path
  return $ map classifyWord (tokenize content)

classifyWord :: String -> Token
classifyWord str 
  | str `elem` keywords    = TokKeyword $ stringToKeyword str
  | str `contains` symbols = TokSymbol $ stringToSymbol str
  | all isNumber str       = TokNumber (read str :: Int)
  | isLetter (head str)    = TokIdentifier str
  | otherwise              = error "Token is not yet implemented"
  where
    contains :: (Eq a) => [a] -> [a] -> Bool
    contains sub s = isJust $ findIndex (isPrefixOf sub) (tails s)

stringToKeyword :: String -> Keyword
stringToKeyword "int"     = IntKw
stringToKeyword "return"  = ReturnKw
stringToKeyword _         = error "stringToKeyword has recieved an argument that is not a keyword."

stringToSymbol :: String -> Char
stringToSymbol [x] 
  | x `elem` symbols = x
stringToSymbol _   = error "String is not a character"




