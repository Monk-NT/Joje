{-# LANGUAGE OverloadedStrings #-}

module Web.Joje
  (
    joje
  ) where

import Network.Wai (responseLBS, Application)
import Network.Wai.Handler.Warp
import Network.HTTP.Types
import Network.HTTP.Types.Header

joje :: Port -> IO ()
joje p = do
  putStrLn $ "Listening on port " ++ show p
  run p jojeApp


jojeApp :: Application
jojeApp req f =
  f $ responseLBS status200 [(hContentType, "text/plain")] "Hello world!"

