{-# LANGUAGE OverloadedStrings, ImplicitParams #-}

module Main where

import Ununicode
import qualified Data.Text as T
import qualified System.IO.Encoding as Enc
import Data.Encoding.UTF8
import System.Environment
import System.Exit
import System.IO
import Control.Exception
import Control.Monad (when)

die s = do
  hPutStrLn stderr s
  exitWith $ ExitFailure (-1)

handleIO :: (IOException -> IO a) -> IO a -> IO a
handleIO = handle

main = do
  args <- getArgs
  when (length args /= 2) $
    die "input and output filepath is required"
  let ?enc = UTF8
  let [input, output] = args
  handleIO (const $ die "Input file does not exist") $ do
    contents <- Enc.readFile input
    let (result, errs) = ununicode $ T.pack contents
    when (length errs > 0) $ do
      putStrLn "Conversion errors encountered!:"
      mapM_ (putStrLn) errs
    Enc.writeFile output $ T.unpack result