{-# LANGUAGE PackageImports #-}
--
module GoogleOAuthV2 where
--
import Data.Maybe (fromJust)
import "mtl" Control.Monad.Trans
import Network.OAuth.Consumer
import Network.OAuth.Http.Request
import Network.OAuth.Http.Response
import Network.OAuth.Http.HttpClient
import Network.OAuth.Http.PercentEncoding
--
import Network.Curl
--
reqUrl = fromJust . parseURL $ "https://www.google.com/accounts/OAuthGetAccessToken"
accUrl = fromJust . parseURL $ ""
--
data Consumer = Consumer
    { key :: String
    , secret :: String }
    deriving (Show, Eq)
--
authenticate :: Consumer -> IO Token
authenticate consumer = unCurlM . runOAuth $ do
    ignite $ Application (key consumer) (secret consumer) OOB
    oauthRequest HMACSHA1 Nothing reqUrl
    cliAskAuthorization authUrl
    oauthRequest HMACSHA1 Nothing accUrl
    getToken
--
