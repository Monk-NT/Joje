{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings         #-}
-- @
-- Joje.Router is implemented with using a /trie/\//prefix-tree/ data structure
-- This is done to make it go fast.
-- @
module Web.Joje.Router
(
  Route(..),
  RouteTree,
  buildRouteTree,
  getHandlerForRoute
)
where

import           Data.ByteString          (ByteString, append)
import qualified Data.ByteString.Char8    as Char8
import qualified Data.Trie                as Trie
import           Network.Wai
import           Web.Joje.DefaultHandlers
import           Web.Joje.Router.Data

addEndSlash :: ByteString -> ByteString
addEndSlash route = if Char8.last route == '/'
  then route
  else append route "/"

buildRouteTree :: [Route] -> RouteTree
buildRouteTree  =  Trie.fromList . map (\x-> (addEndSlash $ root x,x))

getHandlerForRoute :: ByteString -> RouteTree -> Request -> Response
getHandlerForRoute route rt =
  case fmap handler (Trie.lookup (addEndSlash route) rt) of
    Just x  -> x
    Nothing -> noRouteFound
