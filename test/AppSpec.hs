{-# LANGUAGE QuasiQuotes #-}

module AppSpec where

import Tree(Tree, Tree(..), pretty')
import Examples
import Test.Hspec

import NeatInterpolation

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
