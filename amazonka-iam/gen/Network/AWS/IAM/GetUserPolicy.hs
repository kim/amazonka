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

-- Module      : Network.AWS.IAM.GetUserPolicy
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

-- | Retrieves the specified inline policy document that is embedded in the
-- specified user.
--
-- A user can also have managed policies attached to it. To retrieve a managed
-- policy document that is attached to a user, use 'GetPolicy' to determine the
-- policy's default version, then use 'GetPolicyVersion' to retrieve the policy
-- document.
--
-- For more information about policies, refer to <http://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html Managed Policies and InlinePolicies> in the /Using IAM/ guide.
--
-- <http://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUserPolicy.html>
module Network.AWS.IAM.GetUserPolicy
    (
    -- * Request
      GetUserPolicy
    -- ** Request constructor
    , getUserPolicy
    -- ** Request lenses
    , gupPolicyName
    , gupUserName

    -- * Response
    , GetUserPolicyResponse
    -- ** Response constructor
    , getUserPolicyResponse
    -- ** Response lenses
    , guprPolicyDocument
    , guprPolicyName
    , guprUserName
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.IAM.Types
import qualified GHC.Exts

data GetUserPolicy = GetUserPolicy
    { _gupPolicyName :: Text
    , _gupUserName   :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'GetUserPolicy' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gupPolicyName' @::@ 'Text'
--
-- * 'gupUserName' @::@ 'Text'
--
getUserPolicy :: Text -- ^ 'gupUserName'
              -> Text -- ^ 'gupPolicyName'
              -> GetUserPolicy
getUserPolicy p1 p2 = GetUserPolicy
    { _gupUserName   = p1
    , _gupPolicyName = p2
    }

-- | The name of the policy document to get.
gupPolicyName :: Lens' GetUserPolicy Text
gupPolicyName = lens _gupPolicyName (\s a -> s { _gupPolicyName = a })

-- | The name of the user who the policy is associated with.
gupUserName :: Lens' GetUserPolicy Text
gupUserName = lens _gupUserName (\s a -> s { _gupUserName = a })

data GetUserPolicyResponse = GetUserPolicyResponse
    { _guprPolicyDocument :: Text
    , _guprPolicyName     :: Text
    , _guprUserName       :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'GetUserPolicyResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'guprPolicyDocument' @::@ 'Text'
--
-- * 'guprPolicyName' @::@ 'Text'
--
-- * 'guprUserName' @::@ 'Text'
--
getUserPolicyResponse :: Text -- ^ 'guprUserName'
                      -> Text -- ^ 'guprPolicyName'
                      -> Text -- ^ 'guprPolicyDocument'
                      -> GetUserPolicyResponse
getUserPolicyResponse p1 p2 p3 = GetUserPolicyResponse
    { _guprUserName       = p1
    , _guprPolicyName     = p2
    , _guprPolicyDocument = p3
    }

-- | The policy document.
guprPolicyDocument :: Lens' GetUserPolicyResponse Text
guprPolicyDocument =
    lens _guprPolicyDocument (\s a -> s { _guprPolicyDocument = a })

-- | The name of the policy.
guprPolicyName :: Lens' GetUserPolicyResponse Text
guprPolicyName = lens _guprPolicyName (\s a -> s { _guprPolicyName = a })

-- | The user the policy is associated with.
guprUserName :: Lens' GetUserPolicyResponse Text
guprUserName = lens _guprUserName (\s a -> s { _guprUserName = a })

instance ToPath GetUserPolicy where
    toPath = const "/"

instance ToQuery GetUserPolicy where
    toQuery GetUserPolicy{..} = mconcat
        [ "PolicyName" =? _gupPolicyName
        , "UserName"   =? _gupUserName
        ]

instance ToHeaders GetUserPolicy

instance AWSRequest GetUserPolicy where
    type Sv GetUserPolicy = IAM
    type Rs GetUserPolicy = GetUserPolicyResponse

    request  = post "GetUserPolicy"
    response = xmlResponse

instance FromXML GetUserPolicyResponse where
    parseXML = withElement "GetUserPolicyResult" $ \x -> GetUserPolicyResponse
        <$> x .@  "PolicyDocument"
        <*> x .@  "PolicyName"
        <*> x .@  "UserName"
