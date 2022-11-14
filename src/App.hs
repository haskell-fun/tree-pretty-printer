{-# LANGUAGE FlexibleInstances #-}

module App where

import Data.List.NonEmpty ( toList, NonEmpty )
import Data.Text (Text(), pack)
import Data.Foldable (fold)

import Data.List(intercalate)


program :: IO ()
program =
  pure ()


data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq)



pretty :: CustomShow a => Tree a -> String
pretty = pretty2 0


pretty2 :: CustomShow a => Int -> Tree a -> String
pretty2 n (Leaf x) = customShow2 n x
pretty2 n (Branch x y) = intercalate "\n" (customShow2 n x :
                                           toList (fmap (pretty2 (n + 1)) y))


customShow2 :: CustomShow a => Int -> a -> String
customShow2 0 a = customShow a
customShow2 n a = fold (take n (repeat "--")) ++ customShow a



pretty' :: CustomShow a => Tree a -> Text
pretty' = pack . pretty



class CustomShow a where
  customShow :: a -> String

instance CustomShow Char where
  customShow = pure

instance CustomShow String where
  customShow = id
