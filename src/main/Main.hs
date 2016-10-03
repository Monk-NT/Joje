{-# LANGUAGE OverloadedStrings #-}

import Web.Joje (joje)
import Web.Joje.Route
import Network.Wai
import Network.Wai.Handler.Warp
import Network.HTTP.Types
import Network.HTTP.Types.Header
import qualified Data.ByteString.Lazy as LBS

main :: IO ()
main = joje 3000 [(RouteData "/joje" Nothing demoRoute), (RouteData "/snd" Nothing demoRoute)]

demoRoute :: Request -> Response
demoRoute req = responseLBS status200 [] $ LBS.fromStrict (rawPathInfo req)
