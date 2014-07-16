-- Copyright © 2014 Garrison Jensen
-- License
-- This code and text are dedicated to the public domain. 
-- You can copy, modify, distribute and perform the work, 
-- even for commercial purposes, all without asking permission.
-- For more information, please refer to <http://unlicense.org/> 
-- or the accompanying LICENSE file. 

import Text.Parsec
import Text.Parsec.String
import Data.Either

type VColor  = Int
data VarName = VC VColor String deriving (Eq, Show)

data Expr
  = Var VarName
  | Lam VarName Expr
  | App Expr Expr
  deriving (Eq, Show)

lam :: Parser Expr
lam = do
  char '\\'
  n <- letter
  string "."
  e <- expr
  return $ Lam (VC 0 [n]) e

app :: Parser Expr
app = do
  apps <- many1 term
  return $ foldl1 App apps

var :: Parser Expr
var = do
  n <- letter
  return $ Var $ VC 0 [n]

parens :: Parser Expr -> Parser Expr
parens p = do
  char '('
  e <- p
  char ')'
  return e

term :: Parser Expr
term = var <|> parens expr

expr :: Parser Expr
expr = lam <|> app

decl :: Parser Expr
decl = do
  e <- expr
  eof
  return e

test :: IO ()
test = do 
  n <- getLine 
  parseTest decl n

main :: IO ()
main = test >>= print >> main
