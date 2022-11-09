{-# LANGUAGE TupleSections #-}

module Internal.State where


newtype State s a = State { runState :: s -> (s, a) }

instance Functor (State s) where
  fmap f ma = State $
    \s -> mapSnd f $ runState ma s

instance Applicative (State s) where
  pure a       = State (,a)
  (<*>) mab ma = State $
    \s -> mapSnd (execState mab s) (runState ma s)

instance Monad (State s) where
  (>>=) ma amb = State $
    \s -> runState (execState (amb <$> ma) s) s


execState :: State s a -> s -> a
execState ma = snd . runState ma


get :: State s s
get = State $ \s -> (s, s)

put :: s -> State s ()
put s = State $ const (s, ())

modify :: (s -> s) -> State s ()
modify f = get >>= put . f


-- Tuple function helpers
mapFst :: (t -> a) -> (t, b) -> (a, b)
mapFst f (a, b) = (f a, b)

mapSnd :: (t -> b) -> (a, t) -> (a, b)
mapSnd f (a, b) = (a, f b)
