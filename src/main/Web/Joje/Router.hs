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
  RouteHandler,
  buildRouteTree,
  getHandlerForRoute,
  get,
  Param

)
where

import           Data.ByteString          (ByteString, append)
import qualified Data.ByteString.Char8    as Char8
import qualified Data.Trie                as Trie
import           Web.Joje.DefaultHandlers
import           Web.Joje.Router.Data
import           Web.Joje.Data
import Web.Joje.Router.RouteConstructs


addEndSlash :: ByteString -> ByteString
addEndSlash route = if Char8.last route == '/'
  then route
  else append route "/"

buildRouteTree :: [Route] -> RouteTree
buildRouteTree  =  Trie.fromList . map (\x-> (addEndSlash $ fullRoute x,x))

getHandlerForRoute :: ByteString -> RouteTree -> RouteHandler
getHandlerForRoute route rt =
  maybe noRouteFound handler (Trie.lookup (addEndSlash route) rt)
