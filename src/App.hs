module App(program) where

import Examples(tree3) 
import Tree(pretty')
import Data.Text.IO(putStrLn)
import Prelude hiding (putStrLn)

program :: IO ()
program =  putStrLn (pretty' tree3)
