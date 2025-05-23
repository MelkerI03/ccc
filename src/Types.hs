module Types where

keywords :: [String]
keywords = ["int", "return"]

symbols :: [Char]
symbols = ['{', '}', '(', ')', ';']

data Keyword = IntKw | ReturnKw
  deriving (Show, Eq)

data Token
  = TokKeyword Keyword
  | TokIdentifier String
  | TokSymbol Char
  | TokNumber Int
  deriving (Show, Eq)

newtype AST 
  = Program [Function]
  deriving (Show, Eq)

data Function 
  = Function String Statement
  deriving (Show, Eq)

data Statement
  = Return Expression
  | Declaration String
  deriving (Show, Eq)

data Expression
  = Const Int
  | Var String
  | BinaryOp Op Expression Expression
  | Parens Expression
  deriving (Show, Eq)

data Op = Add | Mul | Sub | Div
  deriving (Show, Eq)
