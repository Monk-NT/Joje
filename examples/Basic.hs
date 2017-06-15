{-# LANGUAGE OverloadedStrings #-}
-- |This is a simple demo app, used for testing of Joje during development

import qualified Data.ByteString.Lazy as LBS
import qualified Network.HTTP.Types   as Methods
import           Network.Wai
import           Web.Joje

routes :: [Route]
routes = [ get "/joje"              demoRoute
         , get "/joje/:element"     demoRoute
         , get "/joje/:element/handler" demoRoute ]

main :: IO ()
main = joje 3000 routes

-- |'demoRoute' is a simple route used for demo. It returns its path in
-- response body
demoRoute :: RouteHandler
demoRoute curState = curState { resp = responseLBS Methods.status200 [] $ LBS.fromStrict (path $ req curState) }
