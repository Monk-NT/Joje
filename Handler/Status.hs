module Handler.Status where

import Import

getStatusR :: Handler Html
getStatusR = defaultLayout [whamlet|<h1> Ok|]
