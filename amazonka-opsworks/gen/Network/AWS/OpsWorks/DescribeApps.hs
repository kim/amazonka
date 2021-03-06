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

-- Module      : Network.AWS.OpsWorks.DescribeApps
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

-- | Requests a description of a specified set of apps.
--
-- You must specify at least one of the parameters.
--
-- Required Permissions: To use this action, an IAM user must have a Show,
-- Deploy, or Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions, see <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html Managing User Permissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_DescribeApps.html>
module Network.AWS.OpsWorks.DescribeApps
    (
    -- * Request
      DescribeApps
    -- ** Request constructor
    , describeApps
    -- ** Request lenses
    , daAppIds
    , daStackId

    -- * Response
    , DescribeAppsResponse
    -- ** Response constructor
    , describeAppsResponse
    -- ** Response lenses
    , darApps
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.OpsWorks.Types
import qualified GHC.Exts

data DescribeApps = DescribeApps
    { _daAppIds  :: List "AppIds" Text
    , _daStackId :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'DescribeApps' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'daAppIds' @::@ ['Text']
--
-- * 'daStackId' @::@ 'Maybe' 'Text'
--
describeApps :: DescribeApps
describeApps = DescribeApps
    { _daStackId = Nothing
    , _daAppIds  = mempty
    }

-- | An array of app IDs for the apps to be described. If you use this parameter, 'DescribeApps' returns a description of the specified apps. Otherwise, it returns a
-- description of every app.
daAppIds :: Lens' DescribeApps [Text]
daAppIds = lens _daAppIds (\s a -> s { _daAppIds = a }) . _List

-- | The app stack ID. If you use this parameter, 'DescribeApps' returns a
-- description of the apps in the specified stack.
daStackId :: Lens' DescribeApps (Maybe Text)
daStackId = lens _daStackId (\s a -> s { _daStackId = a })

newtype DescribeAppsResponse = DescribeAppsResponse
    { _darApps :: List "Apps" App
    } deriving (Eq, Read, Show, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeAppsResponse where
    type Item DescribeAppsResponse = App

    fromList = DescribeAppsResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _darApps

-- | 'DescribeAppsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'darApps' @::@ ['App']
--
describeAppsResponse :: DescribeAppsResponse
describeAppsResponse = DescribeAppsResponse
    { _darApps = mempty
    }

-- | An array of 'App' objects that describe the specified apps.
darApps :: Lens' DescribeAppsResponse [App]
darApps = lens _darApps (\s a -> s { _darApps = a }) . _List

instance ToPath DescribeApps where
    toPath = const "/"

instance ToQuery DescribeApps where
    toQuery = const mempty

instance ToHeaders DescribeApps

instance ToJSON DescribeApps where
    toJSON DescribeApps{..} = object
        [ "StackId" .= _daStackId
        , "AppIds"  .= _daAppIds
        ]

instance AWSRequest DescribeApps where
    type Sv DescribeApps = OpsWorks
    type Rs DescribeApps = DescribeAppsResponse

    request  = post "DescribeApps"
    response = jsonResponse

instance FromJSON DescribeAppsResponse where
    parseJSON = withObject "DescribeAppsResponse" $ \o -> DescribeAppsResponse
        <$> o .:? "Apps" .!= mempty
