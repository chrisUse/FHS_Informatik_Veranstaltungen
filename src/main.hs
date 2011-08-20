module Main where
--
import System.Environment
--
import HTTPRequest
import Text.HTML.TagSoup
--
import HtmlEventTOEventInfoList
--
main = do
--   (filePath : args) <- getArgs
   daten <- requestHTML "http://www.fh-schmalkalden.de/Veranstaltungen-p-143.html"
--
--   print $ parseTags daten
   print $ listTOStrukt $ serachTable $ parseTags daten
--   print $ head $ head $ serachTable $ parseTags daten
--
--
--
--
--
