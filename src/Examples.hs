module Examples where 

import Tree(Tree(..))


tree1 :: Tree String
tree1 = Leaf "a"

tree2 :: Tree Char
tree2 = Branch 'a' [Leaf 'b',
                    Leaf 'c']

tree3 :: Tree Char
tree3 = Branch 'a' [Branch 'd'
                      [Branch 'e'
                         [Leaf 'f']],
                    Leaf 'b',
                    Leaf 'c']

