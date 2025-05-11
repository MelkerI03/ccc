module Tokenizer where
import Data.Char (isSpace, isAlphaNum)

tokenize :: String -> [String]
tokenize [] = []
tokenize (c:cs)
  | isSpace c = tokenize cs
  | isSymbolChar c = [c] : tokenize cs
  | isAlphaNum c =
      let (token, rest) = span isAlphaNum (c:cs)
      in token : tokenize rest
  | otherwise = tokenize cs

isSymbolChar :: Char -> Bool
isSymbolChar c = c `elem` "{}();"
