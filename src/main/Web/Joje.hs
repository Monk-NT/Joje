{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje,
    get
  ) where

import           Network.Wai              (Application, rawPathInfo)
import           Network.Wai.Handler.Warp (Port, run)
import           Web.Joje.Router

-- |This type will probably be removed in the future. It will be used only to allow compilation
type JojeApplication = Param -> Application

-- |Main entry function. TODO: add examples of calling
joje :: Port -> [Route] -> IO ()
joje p routes = do
  putStrLn $ "Listening on port " ++ show p
  run p (jojeApp routeTree "")
  where
    routeTree = buildRouteTree routes

jojeApp :: RouteTree -> JojeApplication
jojeApp routes param req f = f $ getHandlerForRoute (rawPathInfo req) routes param req
