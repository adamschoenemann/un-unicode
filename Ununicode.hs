{-# LANGUAGE OverloadedStrings, ImplicitParams #-}

module Ununicode (ununicode) where

import Data.Functor
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Char (isLatin1)
import qualified Data.Map.Strict as M
import UniMap (unicode_to_latex)
import Data.Maybe (fromMaybe, isNothing)
import Control.Monad.Writer

iff :: (a -> Bool) -> (a -> b) -> (a -> b) -> (a -> b)
iff f y n x = if f x then y x else n x

replace :: Char -> Maybe Text
replace x =
  M.lookup x unicode_to_latex


linef :: (Int, Text) -> Writer [String] Text
linef (i,l) =
  let ms :: [Maybe Text]
      ms = map (iff isLatin1 (Just . T.singleton) replace) $ T.unpack l
      cont = T.concat $ map (fromMaybe "UNICODE_ERROR") ms
  in  if any (isNothing) ms
      then do
        tell ([show i ++ ": Unicode conversion error"])
        return cont
      else return cont

ununicode :: Text -> (Text, [String])
ununicode t =
  let lines = zip [1..] $ T.lines t
  in  runWriter $ T.unlines <$> sequence (map linef lines)

