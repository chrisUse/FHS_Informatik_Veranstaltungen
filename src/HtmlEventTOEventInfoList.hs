module HtmlEventTOEventInfoList where
--
import Text.HTML.TagSoup
--
data Date      = Date      { jear   :: String
                           , month  :: String
                           , day    :: String
                           }
                           deriving (Show, Read)
--
data Time      = Time      { houre  :: String
                           , minute :: String
                           }
                           deriving (Show, Read)
--
data TimeStamp = TimeStamp { date   :: Date
                           , time   :: Time
                           }
                           deriving (Show, Read)
--
data EventInfo = EventInfo { start  :: TimeStamp
                           , end    :: TimeStamp
                           , title  :: String
                           , room   :: String
                           }
                           deriving (Show, Read)
--
type EventInfoList = [EventInfo]
--
listTOStrukt :: [[[String]]] -> EventInfoList
listTOStrukt [] = []
listTOStrukt ( ( dateArea : ( _ : link : title : _ : room : _ ) : _ ) : events) =
   (EventInfo { start=s, end=e, title=title, room=room }) : (listTOStrukt events)
    where
     (s, e) = splitDateArea dateArea
--
--
-- =============================================================================
-- | Functions for filtering date and time
splitDateArea :: [String] -> (TimeStamp, TimeStamp)
splitDateArea ( _ : dateArea1 : timeArea1 : _ : _ : dateArea2 : timeArea2 : _ ) =
                         ( TimeStamp { date=Date{jear=j1, month=m1, day=d1}
                                     , time=Time{houre=h1, minute=mi1}
                                     }
                         , TimeStamp { date=Date{jear=j2, month=m2, day=d2}
                                     , time=Time{houre=h2, minute=mi2}
                                     }
                         )
   where
    (j1, m1, d1) = dateTriepel dateArea1
    (j2, m2, d2) = dateTriepel dateArea2
    (h1, mi1)    = timeTupel timeArea1
    (h2, mi2)    = timeTupel timeArea2
--
timeTupel = stringTOTupel . filterTimeStamp
--
stringTOTupel ( h1 : h2 : _ : m1 : m2 : _ ) = ( (h1 : h2 : []), (m1 : m2 : []) )
--
filterTimeStamp :: String -> String
filterTimeStamp [] = []
filterTimeStamp (x : xss) =
   case x of
    '\n'   -> filterTimeStamp xss
    '\t'   -> filterTimeStamp xss
    ' '    -> filterTimeStamp xss
    '\160' -> filterTimeStamp xss
    _      -> x : filterTimeStamp xss
--
-- ========================================================================
--
dateTriepel = stringTOTriepel . filterDateStamp
--
stringTOTriepel (j1 : j2 : j3 : j4 : _ : m1 : m2 : _ : d1 : d2 : _) =
  ( (j1 : j2 : j3 : j4 : []), (m1 : m2 : []), (d1 : d2 : []) )
--
--
filterDateStamp :: String -> String
filterDateStamp [] = []
filterDateStamp (x : xss) =
   case x of
    '\n'   -> filterDateStamp xss
    '\t'   -> filterDateStamp xss
    ' '    -> filterDateStamp xss
    '\160' -> filterDateStamp xss
    _      -> x : filterDateStamp xss
--
-- 
--
-- ===============================================================================
-- | search for a "table" tag in the HTML-Code.
serachTable :: [Tag String] -> [[[String]]]
serachTable (tag : tags) =
   case tag of
    TagOpen  "table" _ -> serachTable tags
    TagOpen  "tr"    _ -> (searchTR tags) : (serachTable tags)
    TagClose "table"   -> []
    _ -> serachTable tags
--
--
searchTR :: [Tag String] -> [[String]]
searchTR (tag : tags) =
   case tag of
    TagOpen  "td" _ -> (serachTD tags) : (searchTR tags)
    TagClose "tr"   -> []
    _ -> searchTR tags
--
--
serachTD :: [Tag String] -> [String]
serachTD (tag : tags) =
   case tag of
    TagText  daten     -> daten : (serachTD tags)
    TagOpen  "a" daten -> (snd (head daten)) : (serachTD tags)
    TagClose "td"      -> []
    _ -> serachTD tags
--

