{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje,
    Route
  ) where

import           Network.Wai              (Application, rawPathInfo)
import           Network.Wai.Handler.Warp (Port, run)
import           Web.Joje.Router

-- |Main entry function. TODO: add examples of calling
joje :: Port -> [Route] -> IO ()
joje p routes = do
  putStrLn $ "Listening on port " ++ show p
  run p (jojeApp routeTree)
  where
    routeTree = buildRouteTree routes

jojeApp :: RouteTree -> Application
jojeApp routes req f = f $ getHandlerForRoute (rawPathInfo req) routes req
