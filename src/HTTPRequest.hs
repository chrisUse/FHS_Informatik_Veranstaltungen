module HTTPRequest where
--
-- Libs for web request
-- -- ===============================================
import Network.HTTP.Enumerator
import Network.HTTP.Types
import qualified Data.ByteString.Lazy.UTF8 as BSLU
import Network.Socket
-- ===============================================
--
requestHTML addr = withSocketsDo $ do
    req0 <- parseUrl addr
    let req = req0 { method = methodGet }
    res <- withManager $ httpLbs req 
    return $ BSLU.toString $ responseBody res 
--
--
