{-# LANGUAGE DeriveFunctor #-}

module App where

import Data.List.NonEmpty ( NonEmpty, toList )
import Data.Text (Text(), pack)
import Internal.CustomShow


program :: IO ()
program = pure ()


data Tree a = Leaf a
   | Branch a (NonEmpty (Tree a))
  deriving (Functor, Show, Eq)



-- Regular printer
pretty :: CustomShow a => Tree a -> String
pretty (Leaf x) = customShow x
pretty (Branch x y) = customShow x ++ childrenStr
  where
    childrenLines        = lines . pretty <$> y
    childrenLinesConcatd = mconcat $ toList childrenLines
    childrenFormatted    = ("--" ++) <$> childrenLinesConcatd
    childrenStr          = foldMap ("\n" ++) childrenFormatted


-- Depth printer
hydrateDepth :: Tree a -> Tree (a, Int)
hydrateDepth = hydrateDepth' 0
  where
    hydrateDepth' n (Leaf x)     = Leaf (x, n)
    hydrateDepth' n (Branch x y) = Branch (x, n) (hydrateDepth' (n + 1) <$> y)

prettyWithDepth :: CustomShow a => Tree a -> String
prettyWithDepth = printHelper . hydrateDepth
  where
    printHelper (Leaf (x, n))     = mconcat (replicate n "--") ++ customShow x
    printHelper (Branch (x, n) y) = mconcat (replicate n "--") ++ customShow x ++
                                      foldMap ("\n" ++) (toList $ printHelper <$> y)

pretty' :: CustomShow a => Tree a -> Text
pretty' = pack . pretty

prettyWithDepth' :: CustomShow a => Tree a -> Text
prettyWithDepth' = pack . prettyWithDepth
