module Parser where
import Types

parse :: [Token] -> AST
parse _ = Program [ Function "main" $ Declaration "x"]
