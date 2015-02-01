module Main where

import Control.Distributed.Process (Process, liftIO)
import Control.Distributed.Process.Node (runProcess, initRemoteTable, newLocalNode)
import Network.Socket (withSocketsDo)
import Network.Transport.TCP (createTransport, defaultTCPParameters)

main :: IO ()
main = do
  et <- withSocketsDo $ createTransport "localhost" "10501" defaultTCPParameters
  case et of
    Left e -> print e
    Right t -> do
      node <- newLocalNode t initRemoteTable
      runProcess node mainProcess

mainProcess :: Process ()
mainProcess = do
  liftIO $ putStrLn "hello"
