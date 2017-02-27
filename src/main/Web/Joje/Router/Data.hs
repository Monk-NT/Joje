module Web.Joje.Router.Data
(
  Route (..),
  RouteTree
)where


import           Data.ByteString    (ByteString)
import           Data.Trie
import           Network.HTTP.Types
import           Network.Wai

-- |This type represents the route. It is used by router to
-- route and call correct route handlers. Handlers are simple
-- Request -> Response functions.
data Route = Route { root    :: ByteString
                   , verb    :: [StdMethod]
                   , handler :: Request -> Response
                   }

instance Show Route where
  show r = show $ root r

type RouteTree = Trie Route
