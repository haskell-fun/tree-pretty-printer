{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}
module Tree (pretty, pretty', Tree(Leaf, Branch), calculateDepth) where

import Data.List.NonEmpty
import Data.Text (Text(), pack)
import Data.Foldable (fold)


data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq, Functor, Foldable)

newtype Depth = Depth { depthValue :: Int } deriving (Eq, Show)
  deriving Num via Int

calculateDepth :: Tree a -> Tree (a, Depth)
calculateDepth = aux 0 where
 aux n (Leaf a) = Leaf (a, n)
 aux n (Branch a as) = Branch (a, n) (fmap (aux (n+1)) as)

pretty :: CustomShow a => Tree a -> String
pretty =  foldMap nodeToString . calculateDepth where
   nodeToString :: CustomShow a => (a, Depth) -> String
   nodeToString (a, d) = customShowN (depthValue d) a

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
