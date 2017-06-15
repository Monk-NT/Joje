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
  put,
  patch,
  post,
  delete,
  Param,
  JojeState(..),
  JojeReq(..),
  findLongestRoute
)
where

import Data.ByteString (ByteString)
import qualified          Data.ByteString   as BS              (append, concat, empty)
import qualified Data.ByteString.Char8           as Char8
import qualified Data.Trie                       as Trie
import           Text.Regex
import           Web.Joje.Data
import           Web.Joje.DefaultHandlers
import           Web.Joje.Router.Data
import           Web.Joje.Router.RouteConstructs



addEndSlash :: ByteString -> ByteString
addEndSlash route = if Char8.last route == '/'
  then route
  else BS.append route "/"

buildRouteTree :: [Route] -> RouteTree
buildRouteTree  =  Trie.fromList . map (\x-> (addEndSlash $ fullRoute $ prepareRoute x, prepareRoute x))

getHandlerForRoute :: ByteString -> RouteTree -> RouteHandler
getHandlerForRoute route rt =
  maybe noRouteFound handler (Trie.lookup (addEndSlash route) rt)

prepareRoute :: Route -> Route
prepareRoute route = route {fullRoute = replaceRouteExp $ fullRoute route}

replaceRouteExp :: ByteString -> ByteString
replaceRouteExp fRoute = Char8.pack $ subRegex (mkRegex ":([a-zA-Z0-9]*)/?") (Char8.unpack fRoute) ":var/"

getParamAndRoute :: ByteString -> (ByteString, ByteString)
getParamAndRoute route = ("findLongestRoute route", "param")

findLongestRoute :: RouteTree -> ByteString -> ByteString
findLongestRoute rt route = getNext (Trie.match rt route) rt

getNext :: Maybe (ByteString, Route, ByteString) -> RouteTree -> ByteString
getNext (Just (currentRoute, _, "")) _ = currentRoute
getNext (Just (currentRoute, _, rest)) rt =
  findLongestRoute rt (BS.append currentRoute (Char8.pack $ subRegex (mkRegex "(.*)/") (Char8.unpack rest) ":var/"))
getNext Nothing _ = BS.empty
-- Function above does not complete
