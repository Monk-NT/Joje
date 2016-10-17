module Web.Joje.Data
(
  Route (..),
  Params (..),
  UrlParam (..)
)where


import Network.HTTP.Types.Method
import Network.Wai
import Data.ByteString (ByteString)

-- |This type represents the route. It is used by router to
-- route and call correct route handlers. Handlers are simple
-- Request -> Response functions.
data Route = Route { path :: ByteString
                   , verb :: Maybe [Method]
                   , handler :: Params -> Response
                   }

-- |This data type represents parameters for input
-- into user functions.
data Params = Params { fullPath :: ByteString
                     , params :: [UrlParam]
                     , httpVerb :: Method
                     }


-- |This represents the single parameter
data UrlParam = UrlParam { paramName :: ByteString
                         , value :: ByteString
                         } deriving Show

