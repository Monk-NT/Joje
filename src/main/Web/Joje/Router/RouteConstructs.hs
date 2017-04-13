module Web.Joje.Router.RouteConstructs
(
get,
post,
patch,
delete,
put
)where

import           Data.ByteString
import qualified Network.HTTP.Types   as Methods (StdMethod (DELETE, GET, PATCH, POST, PUT))
import           Web.Joje.Router.Data

get :: ByteString -> RouteHandler -> Route
get = buildRoute Methods.GET

post :: ByteString -> RouteHandler -> Route
post = buildRoute Methods.POST

patch :: ByteString -> RouteHandler -> Route
patch = buildRoute Methods.PATCH

delete :: ByteString -> RouteHandler -> Route
delete = buildRoute Methods.DELETE

put :: ByteString -> RouteHandler -> Route
put = buildRoute Methods.PUT

buildRoute :: Methods.StdMethod -> ByteString -> RouteHandler -> Route
buildRoute httpMethod path = Route path httpMethod
