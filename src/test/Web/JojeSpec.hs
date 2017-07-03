{-# LANGUAGE OverloadedStrings #-}
module Web.JojeSpec (main, spec) where

import Test.Hspec
import Web.Joje.Internal
import Data.ByteString
import qualified Data.ByteString.Lazy as LBS
import qualified Network.HTTP.Types   as Methods
import           Network.Wai

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "findLongestRoute" $ do
    it "finds longest possible route" $ do
      findLongestRoute rt "/joje" `shouldBe` ("/joje/" :: ByteString)
      findLongestRoute rt "/joje/123/" `shouldBe` ("/joje/:var/" :: ByteString)
      findLongestRoute rt "/joje/123/handler/" `shouldBe` ("/joje/:var/handler/" :: ByteString)
      findLongestRoute rt "/joje/123/handler/123/" `shouldBe` ("/joje/:var/handler/:var/" :: ByteString)


routes :: [Route]
routes = [ get "/joje"              demoRoute
         , get "/joje/:element"     demoRoute
         , get "/joje/:element/handler" demoRoute
         , get "/joje/:var/handler/:internal" demoRoute ]

rt :: RouteTree
rt = buildRouteTree routes

demoRoute :: RouteHandler
demoRoute curState = curState { resp = responseLBS Methods.status200 [] $ LBS.fromStrict (path $ req curState) }
