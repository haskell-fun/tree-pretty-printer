{-# LANGUAGE QuasiQuotes #-}

module AppSpec where

import App
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck.Property

import Data.List.NonEmpty
import Text.RawString.QQ


tree1 = Leaf "a"

tree2 = Branch "a" [Leaf "b",
                    Leaf "c"]

tree3 = Branch "a" [Branch "d"
                      (Branch "e"
                         [Leaf "f"]),
                    Leaf "b",
                    Leaf "c"]



spec :: Spec
spec = describe "Simple test" $ do

     it "simple depth 1 tree unit test" $
        pretty tree1 `shouldBe` "a"
     it "depth 2 tree unit test" $
        pretty tree2 `shouldBe` [r|a
                                   --b
                                   --c|]
