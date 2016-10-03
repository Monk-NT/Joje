module Web.Joje.Route
  ( RouteData (..)
  ) where

import Network.HTTP.Types.Method
import Network.Wai
import Data.ByteString (ByteString)

-- |This type represents the route. It is used by router to
-- route and call correct route handlers. Handlers are simple
-- Request -> Response functions.
data RouteData = RouteData { path :: ByteString
                           , verb :: Maybe [Method]
                           , handler :: Request -> Response
                           }

