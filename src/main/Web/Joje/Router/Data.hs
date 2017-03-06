module Web.Joje.Router.Data
(
  Route (..),
  RouteTree,
  RouteHandler,
  Param
)where


import           Data.ByteString    (ByteString)
import           Data.Trie
import           Network.HTTP.Types
import           Network.Wai

-- |This type represents the route. It is used by router to
-- route and call correct route handlers. Handlers are simple
-- Request -> Response functions.
data Route = Route { fullRoute :: ByteString
                   , verb      :: [StdMethod]
                   , handler   :: RouteHandler
                   }

instance Show Route where
  show = show . fullRoute

type RouteTree = Trie Route

type RouteHandler = Param -> Request -> Response

type Param = ByteString
