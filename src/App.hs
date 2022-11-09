module App where

import Data.List.NonEmpty


program :: IO ()
program =
  pure ()


data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq)



pretty :: Tree a -> String
pretty (Leaf _) = ""
pretty (Branch _ _) = ""
