module Main where

import Control.Distributed.Process (Process, liftIO, nodeAddress)
import Control.Distributed.Process.Node (initRemoteTable, localNodeId, newLocalNode, runProcess)
import Network.Socket (withSocketsDo)
import Network.Transport.TCP (createTransport, defaultTCPParameters)

main :: IO ()
main = do
  et <- withSocketsDo $ createTransport "localhost" "10501" defaultTCPParameters
  case et of
    Left e -> print e
    Right t -> do
      node <- newLocalNode t initRemoteTable
      putStrLn $ "node address: " ++ show (nodeAddress $ localNodeId node)
      runProcess node mainProcess

mainProcess :: Process ()
mainProcess = do
  liftIO $ putStrLn "hello"
