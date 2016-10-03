{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje
  ) where

import Network.Wai (Application, Response, rawPathInfo, Request)
import Network.Wai.Handler.Warp (Port, run)
import Web.Joje.Route
import Data.ByteString (ByteString)

joje :: Port -> [RouteData] -> IO ()
joje p routes = do
  putStrLn $ "Listening on port " ++ show p
  run p (jojeApp routes)

jojeApp :: [RouteData] -> Application
jojeApp routes req f =
  f $ findRoute (rawPathInfo req) routes req

findRoute :: ByteString -> [RouteData] -> Request -> Response
findRoute route [] = error ("Route " ++ show route ++ " could not be found!")
findRoute route (rData:s)
  | route == path rData = handler rData
  | otherwise = findRoute route s
