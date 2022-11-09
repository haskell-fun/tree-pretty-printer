{-# LANGUAGE FlexibleInstances #-}

module App where

import Data.List.NonEmpty
import Data.Text (Text(), pack)


program :: IO ()
program =
  pure ()


data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Show, Eq)



pretty :: CustomShow a => Tree a -> String
pretty (Leaf x) = customShow x
pretty (Branch x y) = customShow x ++ childrenStr
  where
    childrenLines        = lines . pretty <$> y
    childrenLinesConcatd = mconcat $ toList childrenLines
    childrenFormatted    = ("--" ++) <$> childrenLinesConcatd
    childrenStr          = foldMap ("\n" ++) childrenFormatted



pretty' :: CustomShow a => Tree a -> Text
pretty' = pack . pretty



class CustomShow a where
  customShow :: a -> String

instance CustomShow Char where
  customShow = pure

instance CustomShow String where
  customShow = id
