package app


import data.list.non_empty._


enum Tree [A] derives Show, Eq : 

  case Leaf (x: A)

  case Branch (x: A[NonEmpty[Tree[A]]])



def program: IO[Unit] = 
  pure (())


def pretty [A]: Tree[A] => String = 

    case Leaf (_) => ""
    case Branch (_, _) => ""