{-# LANGUAGE OverloadedStrings #-}

module Web.Joje.Data
(
  JojeReq (..),
  JojeResp (..),
  JojeState (..),
  Param,
  mkJojeReq
) where

import           Data.ByteString
import           Network.HTTP.Types
import           Network.Wai

type Param = ByteString

data JojeReq = JojeReq { query    :: Param
                       , path     :: ByteString
                       , method   :: Method
                       , pathParam :: ByteString
                       }

data JojeResp = JojeResp { respBody    :: ByteString
                         , respHeaders :: ResponseHeaders
                         , respStatus  :: Status
                         }

data JojeState = JojeState { req  :: JojeReq
                           , resp :: Response
                           }

mkJojeReq :: Request -> JojeReq
mkJojeReq request = JojeReq { query = rawQueryString request
                            , path = rawPathInfo request
                            , method = requestMethod request
                            , pathParam = empty
                            }
