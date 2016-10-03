module Web.Joje.Route
  ( RouteData (..)
  ) where

import Network.HTTP.Types.Method
import Network.Wai
import Data.ByteString (ByteString)

data RouteData = RouteData { path :: ByteString
                           , verb :: Maybe [Method]
                           , handler :: Request -> Response
                           }

