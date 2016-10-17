{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje,
    Route
  ) where

import Network.Wai (Application, Response, rawPathInfo, Request)
import Network.Wai.Handler.Warp (Port, run)
import Web.Joje.Router
import Data.ByteString (ByteString)


-- |Main entry function. TODO: add examples of calling
joje :: Port -> [Route] -> IO ()
joje p routes = do
  putStrLn $ "Listening on port " ++ show p
  run p (jojeApp routes)

jojeApp :: [InternalRoute] -> Application
jojeApp routes req f =
  f $ findRoute (rawPathInfo req) routes req

-- Internal function. Findes routes.
findRoute :: ByteString -> [Route] -> Request -> Response
findRoute route [] = error ("Route " ++ show route ++ " could not be found!")
findRoute route (rData:s)
  | route == path' rData = handler rData
  | otherwise = findRoute route s
