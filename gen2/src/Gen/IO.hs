{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Gen.IO
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Gen.IO where

import           Control.Applicative
import           Control.Error
import           Control.Monad
import           Control.Monad.Error
import           Control.Monad.IO.Class
import qualified Data.Aeson                as A
import           Data.Aeson.Encode.Pretty
import           Data.Bifunctor
import           Data.ByteString           (ByteString)
import qualified Data.ByteString.Lazy      as LBS
import           Data.Jason                (eitherDecode')
import           Data.Jason.Types          (FromJSON, Object, Value (..),
                                            mkObject)
import           Data.List                 (intercalate, sort)
import           Data.Maybe
import           Data.Monoid
import           Data.Text                 (Text)
import qualified Data.Text                 as Text
import qualified Data.Text.IO              as Text
import qualified Data.Text.IO              as Text
import qualified Data.Text.Lazy            as LText
import qualified Data.Text.Lazy.IO         as LText
import qualified Filesystem                as FS
import           Filesystem.Path.CurrentOS hiding (encode)
import           Gen.JSON
import           Gen.Model
import           Gen.Types
import           Prelude                   hiding (FilePath)
import           System.Directory.Tree
import           Text.EDE                  (Template)
import qualified Text.EDE                  as EDE

writeTree :: AnchoredDirTree (Either String LText.Text)
          -> Script (AnchoredDirTree ())
writeTree t = do
    d <- scriptIO (writeDirectoryWith go t)
    verifyTree d
    return d
  where
    go p x = do
        say "Write Tree" (Text.pack p)
        either (throwError . userError)
               (LText.writeFile p)
               x

verifyTree :: AnchoredDirTree a -> Script ()
verifyTree (_ :/ d)
    | [] <- xs  = return ()
    | otherwise = throwError (intercalate "\n" xs)
  where
    xs = mapMaybe f (failures d)

    f (Failed _ e) = Just (show e)
    f _            = Nothing

fileContents :: FilePath -> Script LBS.ByteString
fileContents p = do
    say "Read File" (encode p)
    b <- scriptIO (FS.isFile p)
    if b
        then LBS.fromStrict <$> scriptIO (FS.readFile p)
        else throwError $ "Unable to find " ++ show p

copyDirectory :: FilePath -> FilePath -> Script ()
copyDirectory src dst = scriptIO (FS.listDirectory src >>= mapM_ copy)
  where
    copy f = say "Copy File" (encode p) >> FS.copyFile f p
      where
        p = dst </> filename f

say :: MonadIO m => Text -> Text -> m ()
say x msg = liftIO . Text.putStrLn $ "[ " <> y <> "] " <> msg
  where
    y | n > 0     = x <> Text.replicate n " "
      | otherwise = x

    n = 17 - Text.length x
