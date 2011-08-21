{-# LANGUAGE OverloadedStrings #-}
-- {-# LANGUAGE OverloadedStrings #-}
module GoogleOAuth where
--
--
import Data.HMAC
--
import qualified Data.ByteString.Lazy as BL
--import qualified Data.ByteString as B1
-- import Data.ByteString.Lazy
import Data.Digest.Pure.SHA
import Codec.Utils
import Data.ByteString.Lazy.Char8
--import Data.String
--
import Network.HTTP.Enumerator
import Network.HTTP.Types
import Network.TLS (TLSCertificateUsage (CertificateUsageAccept))
-- cabal install to-string-class
-- import Data.String.ToString
--
import qualified Data.ByteString.Internal as BI
--
-- oAuth = hmac_sha1Source
--
--test' :: String -> ByteString
--test' tmp = fromString tmp
--
test' :: BL.ByteString
test' =  "anonymous"
--
--
--oAuth :: String
oAuth = showDigest $ hmacSha1 "anonymous" "anonymous"
--oAuth :: BI.ByteString
--oAuth = hmacSha1 "anonymous" "anonymous"
--
--
--getOAuthFromGoogle :: String -> IO BL.ByteString
getOAuthFromGoogle url = do
  req0 <- parseUrl $ url
  let req = req0 { method = methodPost
                 , requestHeaders = [ ("Content-Type"          , "application/x-www-form-urlencoded")
                                    , ("Authorization"         , "OAuth" )
                                    , ("oauth_consumer_key"    , "example.com" )
                                    , ("oauth_signature_method", "HMAC-SHA1" )
--                                    , ("oauth_signature"       , oAuth )
                                    , ("oauth_signature"       , "055a3b88e1cc6bb0d60e274770676ffd5cf0bc68" )
                                    , ("oauth_timestamp"       , "1943825400" )
                                    , ("oauth_nonce"           , "4572616e48616d6d65724c61686176" )
                                    , ("oauth_version"         , "1.0" )
                                    , ("oauth_callback"        , "http://www.example.com/showcalendar.html" )
                                    ]
                 , checkCerts = const $ return CertificateUsageAccept
                 }
  res <- withManager $ httpLbs req
  return $ res

--
--
