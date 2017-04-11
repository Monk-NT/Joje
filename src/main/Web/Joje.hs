{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje,
    get
  ) where

import           Network.Wai
import           Network.HTTP.Types
import           Network.Wai.Handler.Warp (Port, run)
import           Web.Joje.Router
import           Web.Joje.Data



-- |Main entry function. TODO: add examples of calling
joje :: Port -> [Route] -> IO ()
joje p routes = do
  putStrLn $ "Listening on port " ++ show p
  run p (jojeApp routeTree)
  where
    routeTree = buildRouteTree routes

jojeApp :: RouteTree -> Application
jojeApp routes request f = f $ resp (getHandlerForRoute (rawPathInfo request) routes (mkJojeState request))

mkJojeState :: Request -> JojeState
mkJojeState request = JojeState { req = mkJojeReq request
                                , resp = responseFile
                                          status404
                                          [("Content-Type", "text/html")]
                                          "static/404.html"
                                          Nothing
                                }
