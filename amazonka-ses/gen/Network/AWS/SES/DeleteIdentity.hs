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

-- Module      : Network.AWS.SES.DeleteIdentity
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

-- | Deletes the specified identity (email address or domain) from the list of
-- verified identities.
--
-- This action is throttled at one request per second.
--
-- <http://docs.aws.amazon.com/ses/latest/APIReference/API_DeleteIdentity.html>
module Network.AWS.SES.DeleteIdentity
    (
    -- * Request
      DeleteIdentity
    -- ** Request constructor
    , deleteIdentity
    -- ** Request lenses
    , diIdentity

    -- * Response
    , DeleteIdentityResponse
    -- ** Response constructor
    , deleteIdentityResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.SES.Types
import qualified GHC.Exts

newtype DeleteIdentity = DeleteIdentity
    { _diIdentity :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'DeleteIdentity' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'diIdentity' @::@ 'Text'
--
deleteIdentity :: Text -- ^ 'diIdentity'
               -> DeleteIdentity
deleteIdentity p1 = DeleteIdentity
    { _diIdentity = p1
    }

-- | The identity to be removed from the list of identities for the AWS Account.
diIdentity :: Lens' DeleteIdentity Text
diIdentity = lens _diIdentity (\s a -> s { _diIdentity = a })

data DeleteIdentityResponse = DeleteIdentityResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DeleteIdentityResponse' constructor.
deleteIdentityResponse :: DeleteIdentityResponse
deleteIdentityResponse = DeleteIdentityResponse

instance ToPath DeleteIdentity where
    toPath = const "/"

instance ToQuery DeleteIdentity where
    toQuery DeleteIdentity{..} = mconcat
        [ "Identity" =? _diIdentity
        ]

instance ToHeaders DeleteIdentity

instance AWSRequest DeleteIdentity where
    type Sv DeleteIdentity = SES
    type Rs DeleteIdentity = DeleteIdentityResponse

    request  = post "DeleteIdentity"
    response = nullResponse DeleteIdentityResponse
