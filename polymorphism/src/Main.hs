module Main where

data Ele = forall a . (Show a) => Ele a
instance Show Ele where
  show (Ele x) = show x

eles :: [Ele]
eles =
  [ Ele "hoge"
  , Ele (1 :: Integer)
  , Ele ((3, 6) :: (Integer, Integer))
  , Ele (Just 2 :: Maybe Integer)
  , Ele ([4, 3] :: [Integer])
  , Ele ["a", "b"]
  , Ele (1.23 :: Double)
  ]

main :: IO ()
main = mapM_ print eles
