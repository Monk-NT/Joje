{-# LANGUAGE OverloadedStrings #-}
-- |This is a simple demo app, used for testing of Joje during development

import qualified Data.ByteString.Lazy as LBS
import qualified Network.HTTP.Types   as Methods
import           Network.Wai
import           Web.Joje             (joje)
import           Web.Joje.Router

routes :: [Route]
routes = [get "/joje" demoRoute
         ,get "/joje/is" demoRoute]

main :: IO ()
main = joje 3000 routes

-- |'demoRoute' is a simple route used for demo. It returns its path in
-- response body
demoRoute :: RouteHandler
demoRoute  _ req  = responseLBS Methods.status200 [] $ LBS.fromStrict (rawPathInfo req)
