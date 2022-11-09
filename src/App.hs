module App where

import Data.List.NonEmpty


program :: IO ()
program =
  pure ()


data Tree a = Leaf a | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq)


pretty :: Show a => Tree a -> String
pretty _ = ""



-- enum Tree [T]:
--   case Leaf (value: T)
--   case Branch (value: T) (children: NonEmptyList[Tree[T]])
