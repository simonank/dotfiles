module Main
import System
import Data.Fuel
import Control.Monad.Reader
import Data.SortedSet

%default total
%hide Prelude.Pairs.DPair.fst
%hide Data.SortedSet.toList

data Colour = Error | Pending | Done

putStatus : Colour -> String -> IO ()
putStatus col = putStrLn . (colour++) . (++"\x1b[0m")
  where
    colour : String
    colour = case col of
                  Error   => "\x1b[38;5;1m"
                  Done    => "\x1b[38;5;2m"
                  Pending => "\x1b[38;5;3m"

err : String -> IO ()
err = putStatus Error

errExists : String -> IO ()
errExists file = err $ file ++ " does not exist"

errOpen : String -> IO ()
errOpen file = err $ file ++ " cannot be opened"

errTime : IO ()
errTime = err "cannot get modification time"

filename : String -> String
filename = fst . break (=='.')

extension : String -> String
extension = snd . break (=='.')

ytdl : (playlist : String) -> IO ()
ytdl pl = do
  putStatus Pending $ "downloading " ++ pl
  system $ unwords
    [ "pushd $HOME/music/" ++ (filename pl) ++ " > /dev/null;"
    , "youtube-dl"
    , "-xio '%(title)s.%(ext)s'"
    , "--geo-bypass"
    , "--external-downloader=aria2c"
    , "--add-metadata"
    , "--external-downloader-args='-j 8 -c -x 8 -m 10 -k 5M -s 8'"
    , "-a"
    , "../" ++ pl
    , "> /dev/null;"
    , "popd > /dev/null"
    ]
  putStatus Done "done"

mpd : (playlist : String) -> IO ()
mpd pl = do
  let dr = filename pl
  putStatus Pending $ "updating mpd " ++ dr ++ "..."
  system $ concatMap (++" > /dev/null;")
    [ "mpc rm " ++ dr
    , "mpc clear"
    , "mpc add " ++ dr
    , "mpc save " ++ dr
    ]
  putStatus Done "done"

data Options = CreateMissing
             | UpdateMPD
             | DownloadSongs
             | DisplayHelp

Show Options where
  show CreateMissing = "create missing"
  show UpdateMPD = "update mpd"
  show DownloadSongs = "download songs"
  show DisplayHelp = "display help"

Eq Options where
  CreateMissing == CreateMissing = True
  UpdateMPD     == UpdateMPD     = True
  DownloadSongs == DownloadSongs = True
  DisplayHelp   == DisplayHelp   = True
  _             == _             = False

Ord Options where
  compare DisplayHelp DisplayHelp     = EQ
  compare DisplayHelp x               = LT
  compare x DisplayHelp               = GT
  compare CreateMissing CreateMissing = EQ
  compare UpdateMPD UpdateMPD         = EQ
  compare DownloadSongs DownloadSongs = EQ
  compare CreateMissing UpdateMPD     = LT
  compare CreateMissing DownloadSongs = LT
  compare DownloadSongs UpdateMPD     = LT
  compare UpdateMPD CreateMissing     = GT
  compare UpdateMPD DownloadSongs     = GT
  compare DownloadSongs CreateMissing = GT

update : Fuel -> SortedSet Options -> String -> IO ()
update Dry _ _ = pure ()
update (More more) opts pl = do
  let dr = filename pl
  Right playlist  <- openFile pl Read | Left _ => errOpen pl
  Right directory <- openFile dr Read | Left _ =>
    do closeFile playlist
       errExists dr
       when (CreateMissing `contains` opts) $ do
            putStatus Pending "creating directory..."
            Right _ <- createDir dr | Left _ => err ("failed to create " ++ dr)
            update more opts pl
  let cleanup = do closeFile playlist
                   closeFile directory
  Right dirtime   <- fileModifiedTime directory | Left _ => do cleanup; errTime
  Right lsttime   <- fileModifiedTime playlist  | Left _ => do cleanup; errTime
  when (dirtime < lsttime) $ do ytdl pl; mpd pl
  cleanup

loop : Fuel -> Directory -> IO (List String)
loop Dry _ = pure empty -- convince the type checker that we're total
loop (More more) dir = do
  Right entry <- dirEntry dir | Left _ => pure []
  entries     <- loop more dir
  pure $ filter ((==".lst") . extension) (entry :: entries)

option : List String -> List Options
option [] = []
option ("-A" :: xs) = CreateMissing :: option xs
option ("-D" :: xs) = DownloadSongs :: option xs
option ("-U" :: xs) = UpdateMPD     :: option xs
option (_ :: xs) = option xs

help : IO ()
help = putStrLn """
usage: update -[ADU]

-A  Add missing directories
-D  Download songs
-U  Update MPD playlists"""

partial
main : IO ()
main = do
  options <- map option getArgs
  case DisplayHelp `elem` options of
       True => help
       False => do
         system "mpc update"
         Just home <- getEnv "HOME" | Nothing => errExists "HOME"
         let music = home ++ "/music"
         Right dir <- dirOpen music | Left _ => errExists music
         True      <- changeDir music | False => errOpen music
         lst       <- loop forever dir
         traverse_ (update forever $ fromList options) lst
         dirClose dir
         pure ()
