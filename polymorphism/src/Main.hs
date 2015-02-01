module Main where

import System.Environment (getArgs)
import System.IO (hFlush, stdout)

class Config a where
  get :: a -> IO String

data SomeConfig where
  SomeConfig :: Config a => a -> SomeConfig
instance Config SomeConfig where
  get (SomeConfig c) = get c

data ConfigFromValue = ConfigFromValue String
instance Config ConfigFromValue where
  get (ConfigFromValue value) = return value

data ConfigFromInput = ConfigFromInput
instance Config ConfigFromInput where
  get ConfigFromInput = do
    putStr "> "
    hFlush stdout
    getLine

data ConfigFromFile = ConfigFromFile String
instance Config ConfigFromFile where
  get (ConfigFromFile path) = readFile path

fromArgs :: IO SomeConfig
fromArgs = do
  args <- getArgs
  return $ case args of
    ["value", value] -> SomeConfig $ ConfigFromValue value
    ["input"]        -> SomeConfig $ ConfigFromInput
    ["file", path]   -> SomeConfig $ ConfigFromFile path
    _                -> SomeConfig $ ConfigFromValue "default"

main :: IO ()
main = do
  conf <- fromArgs
  content <- get conf
  putStrLn content
