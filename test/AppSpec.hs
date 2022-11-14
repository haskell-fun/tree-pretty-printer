{-# LANGUAGE QuasiQuotes #-}

module AppSpec where

import App
import Test.Hspec

import NeatInterpolation


tree1 = Leaf "a"

tree2 = Branch 'a' [Leaf 'b',
                    Leaf 'c']

tree3 = Branch 'a' [Branch 'd'
                      [Branch 'e'
                         [Leaf 'f']],
                    Leaf 'b',
                    Leaf 'c']



spec :: Spec
spec = describe "Simple test" $ do

     it "simple depth 1 tree unit test" $
        pretty' tree1 `shouldBe` [trimming|
                                   a|]

     it "depth 2 tree unit test" $
        pretty' tree2 `shouldBe` [trimming|
                                   a
                                   --b
                                   --c|]

     it "depth 3 tree unit test" $
        pretty' tree3 `shouldBe` [trimming|
                                   a
                                   --d
                                   ----e
                                   ------f
                                   --b
                                   --c|]
