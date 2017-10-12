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

import           Data.ByteString                 (ByteString)
import qualified Data.ByteString                 as BS (append, concat)
import qualified Data.ByteString.Char8           as Char8
import qualified Data.Trie                       as Trie
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
  maybe noRouteFound handler (Trie.lookup (addEndSlash $ findLongestRoute rt route) rt)

prepareRoute :: Route -> Route
prepareRoute route = route {fullRoute = replaceRouteExp $ fullRoute route}

replaceRouteExp :: ByteString -> ByteString
replaceRouteExp fRoute = BS.concat $ map ((`BS.append` "/") . createVarExpression) splitRoute
  where splitRoute = Char8.split '/' fRoute

-- @ This function creates the "var" expression
createVarExpression :: ByteString -> ByteString
createVarExpression "" = ""
createVarExpression routePart = if Char8.head routePart == ':'
  then ":var"
  else routePart

findLongestRoute :: RouteTree -> ByteString -> ByteString
findLongestRoute rt route = getNext (Trie.match rt $ addEndSlash route) rt

getNext :: Maybe(ByteString, Route, ByteString) -> RouteTree -> ByteString
getNext (Just (currentRoute, _, "")) _ = currentRoute
getNext (Just (currentRoute, _, rest)) rt =
  findLongestRoute rt (BS.append currentRoute $ BS.concat $ map (`appendOnNonEmpty` "/") $ addVar rest)
getNext Nothing _ = "BS.empty"

addVar :: ByteString -> [ByteString]
addVar str = if Char8.elem '/' str && str /= ":var/"
  then ":var" : tail (Char8.split '/' str)
  else []

appendOnNonEmpty :: ByteString -> ByteString -> ByteString
appendOnNonEmpty "" _      = ""
appendOnNonEmpty str1 str2 = BS.append str1 str2
