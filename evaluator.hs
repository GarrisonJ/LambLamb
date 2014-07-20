-- Copyright © 2014 Garrison Jensen
-- License
-- This code and text are dedicated to the public domain. 
-- You can copy, modify, distribute and perform the work, 
-- even for commercial purposes, all without asking permission.
-- For more information, please refer to <http://unlicense.org/> 
-- or the accompanying LICENSE file. 
--

module LambdaCalc 
    ( eval,
      Expr(Var, Lam, App),
      VarName(VC)
    ) where

type VColor  = Int
data VarName = VC VColor String deriving (Eq, Show)

data Expr
  = Var VarName
  | Lam VarName Expr
  | App Expr Expr
  deriving (Eq, Show)

eval :: Expr -> Expr
eval expr = eval' expr []

eval' :: Expr -> [Expr] -> Expr
eval' v@(Var n) []         = v
eval' v@(Var n) stack      = unwind v stack 
eval' (Lam v e) []         = etaRed $ Lam v (eval e)
eval' (Lam v e) (x:stack)  = eval' (betaRed e v x) stack
eval' (App e1 e2) stack    = eval' e1 (e2:stack)

unwind :: Expr -> [Expr] -> Expr
unwind = foldl (\ expr x -> App expr $ eval x)

-- (λx.Mx) ==> M 
etaRed :: Expr -> Expr
etaRed (Lam v (App e (Var v'))) 
      | v == v' && (let (o,n) = occurs e v in not o) = e
etaRed expr = expr

-- (λx.Mx)N ==> M[x := N] 
betaRed :: Expr -> VarName -> Expr -> Expr
betaRed expr v (Var v') | v == v' = expr
betaRed t@(Var v) n e 
        | v == n    = e
        | otherwise = t
betaRed (App e1 e2) v e = App (betaRed e1 v e) (betaRed e2 v e)
betaRed t@(Lam x _) v _ | v == x  = t  
betaRed (Lam x body) v e = Lam x' (betaRed body' v e)
    where
       (f,xIne) = occurs e x
       (x',body') =
            if f then 
		    let uniXinE = colorpplus' (colorpplus x xIne) v
                        (bf,xOccurBody) = occurs body uniXinE
		        uniX = if bf
                               then colorpplus uniXinE xOccurBody 
                               else uniXinE
                    in (uniX,betaRed body x (Var x'))
           else (x,body)
       colorpplus (VC c n) (VC c' _) = VC (max c c' + 1) n
       colorpplus' v1@(VC _ n) v2@(VC _ n') = 
                   if n==n' then colorpplus v1 v2 else v1

occurs :: Expr -> VarName -> (Bool, VarName)
occurs (Var v@(VC c name)) v'@(VC c' name')
    | name /= name' = (False, v)
    | c == c'       = (True, v)
    | otherwise     = (False,v')
occurs (App t1 t2) v = let (f1,v1@(VC c1 _)) = occurs t1 v
                           (f2,v2@(VC c2 _)) = occurs t2 v
                       in (f1 || f2, if c1 > c2 then v1 else v2)
occurs (Lam x body) v | x == v    = (False,v)
                      | otherwise = occurs body v
