{-# LANGUAGE OverloadedStrings #-}

module Web.Joje.DefaultHandlers
(
  noRouteFound
)
where

import           Network.HTTP.Types
import           Network.Wai
import           Web.Joje.Router.Data


noRouteFound:: RouteHandler
noRouteFound _ _ = responseFile
                   status404
                   [("Content-Type", "text/html")]
                   "static/404.html"
                   Nothing
