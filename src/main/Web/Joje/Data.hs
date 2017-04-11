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

data JojeReq = JojeReq { param  :: Param
                       , path   :: ByteString
                       , method :: Method
                       }

data JojeResp = JojeResp { respBody    :: ByteString
                         , respHeaders :: ResponseHeaders
                         , respStatus  :: Status
                         }

data JojeState = JojeState { req  :: JojeReq
                           , resp :: Response
                           }

mkJojeReq :: Request -> JojeReq
mkJojeReq request = JojeReq { param = rawQueryString request
                            , path = rawPathInfo request
                            , method = requestMethod request
                            }
