module Web.Joje.Route
  (
  ) where

import Network.HTTP.Types.Method

data RouteData = RouteData { route :: String
                           , verb  :: Maybe [Method]
                           }


