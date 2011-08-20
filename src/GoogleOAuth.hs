module GoogleOAuth where
--
--
import Data.HMAC
--
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString as B1
import Data.Digest.Pure.SHA
--
-- oAuth = hmac_sha1Source
--
test' :: String -> B.ByteString
test' tmp = show tmp
--
--test :: B1.ByteString
--test = B1.pack "anonymous"
--
--
-- oAuth = hmacSha1 "anonymous" "anonymous"
--
--
