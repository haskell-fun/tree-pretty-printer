module AppSpec where

import App
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck.Property

import Data.List.NonEmpty


tree1 = Leaf "a"

tree2 = Branch "a" (Leaf "b" :| [Leaf "c"])




spec :: Spec
spec = describe "Simple test" $ do

     it "simple depth 1 tree unit test" $
        pretty tree1 `shouldBe` "a"

     it "depth 2 tree unit test" $
        pretty tree2 `shouldBe` "a\n--b\n--c"

     -- prop "property-based unit test" $
     --    \l -> reverse ( reverse l ) == ( l::[Int])
