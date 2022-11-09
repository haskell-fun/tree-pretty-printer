{-# LANGUAGE FlexibleInstances #-}

module Internal.CustomShow where


class CustomShow a where
  customShow :: a -> String

instance CustomShow Char where
  customShow = pure

instance CustomShow String where
  customShow = id
