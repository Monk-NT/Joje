module Web.Joje.Router.Data
(
  Route (..),
  RouteTree,
  RouteHandler
)where


import           Data.ByteString    (ByteString)
import           Data.Trie
import           Network.HTTP.Types
import           Web.Joje.Data

-- |This type represents the route. It is used by router to
-- route and call correct route handlers. Handlers are simple
-- Request -> Response functions.
data Route = Route { fullRoute   :: ByteString
                   , routeMethod :: StdMethod
                   , handler     :: RouteHandler
                   }

instance Show Route where
  show = show . fullRoute

type RouteTree = Trie Route

type RouteHandler = (JojeState -> JojeState)
