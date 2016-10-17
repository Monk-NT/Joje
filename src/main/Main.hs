{-# LANGUAGE OverloadedStrings #-}
-- |This is a simple demo app, used for testing of Joje during development

import Web.Joje (joje)
import Web.Joje.Data
import Network.Wai
import Network.HTTP.Types
import qualified Data.ByteString.Lazy as LBS

main :: IO ()
main = joje 3000 [ Route "/joje" Nothing demoRoute
                 , Route "/snd" Nothing demoRoute ]

-- |'demoRoute' is a simple route used for demo. It returns its path in 
-- response body
demoRoute :: Request -> Response
demoRoute req = responseLBS status200 [] $ LBS.fromStrict (rawPathInfo req)
