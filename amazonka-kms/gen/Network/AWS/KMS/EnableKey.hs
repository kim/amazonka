{-# LANGUAGE DataKinds                   #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
{-# LANGUAGE LambdaCase                  #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.KMS.EnableKey
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Marks a key as enabled, thereby permitting its use. You can have up to 25
-- enabled keys at one time.
--
-- <http://docs.aws.amazon.com/kms/latest/APIReference/API_EnableKey.html>
module Network.AWS.KMS.EnableKey
    (
    -- * Request
      EnableKey
    -- ** Request constructor
    , enableKey
    -- ** Request lenses
    , ekKeyId

    -- * Response
    , EnableKeyResponse
    -- ** Response constructor
    , enableKeyResponse
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.KMS.Types
import qualified GHC.Exts

newtype EnableKey = EnableKey
    { _ekKeyId :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'EnableKey' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ekKeyId' @::@ 'Text'
--
enableKey :: Text -- ^ 'ekKeyId'
          -> EnableKey
enableKey p1 = EnableKey
    { _ekKeyId = p1
    }

-- | A unique identifier for the customer master key. This value can be a globally
-- unique identifier or the fully specified ARN to a key.  Key ARN Example -
-- arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012 Globally Unique Key ID Example - 12345678-1234-1234-123456789012
--
ekKeyId :: Lens' EnableKey Text
ekKeyId = lens _ekKeyId (\s a -> s { _ekKeyId = a })

data EnableKeyResponse = EnableKeyResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'EnableKeyResponse' constructor.
enableKeyResponse :: EnableKeyResponse
enableKeyResponse = EnableKeyResponse

instance ToPath EnableKey where
    toPath = const "/"

instance ToQuery EnableKey where
    toQuery = const mempty

instance ToHeaders EnableKey

instance ToJSON EnableKey where
    toJSON EnableKey{..} = object
        [ "KeyId" .= _ekKeyId
        ]

instance AWSRequest EnableKey where
    type Sv EnableKey = KMS
    type Rs EnableKey = EnableKeyResponse

    request  = post "EnableKey"
    response = nullResponse EnableKeyResponse
