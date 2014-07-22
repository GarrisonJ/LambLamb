-- Copyright © 2014 Garrison Jensen
-- License
-- This code and text are dedicated to the public domain. 
-- You can copy, modify, distribute and perform the work, 
-- even for commercial purposes, all without asking permission.
-- For more information, please refer to <http://unlicense.org/> 
-- or the accompanying LICENSE file. 
--

import LambdaCalc
import Parser

main :: IO ()
main = do
      l <- lambdaParser
      e <- return $ eval l
      print e >> main
