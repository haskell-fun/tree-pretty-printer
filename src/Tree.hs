{-# LANGUAGE FlexibleInstances #-}
module Tree (pretty, pretty', Tree(Leaf, Branch)) where

import Data.List.NonEmpty ( toList, NonEmpty )
import Data.Text (Text(), pack)
import Data.Foldable (fold)

import Data.List(intercalate)

data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq)

pretty :: CustomShow a => Tree a -> String
pretty = aux 0 where 
 aux n (Leaf x) = customShowN n x
 aux n (Branch x y) = intercalate "\n" (customShowN n x :
                                           toList (fmap (aux (n + 1)) y))

customShowN :: CustomShow a => Int -> a -> String
customShowN n a = fold (replicate n separator <> pure (customShow a)) where 
 separator = "--"

pretty' :: CustomShow a => Tree a -> Text
pretty' = pack . pretty

class CustomShow a where
  customShow :: a -> String

instance CustomShow Char where
  customShow = pure

instance CustomShow String where
  customShow = id
