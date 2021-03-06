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

-- Module      : Network.AWS.Config.DeleteDeliveryChannel
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

-- | Deletes the specified delivery channel.
--
-- The delivery channel cannot be deleted if it is the only delivery channel
-- and the configuration recorder is still running. To delete the delivery
-- channel, stop the running configuration recorder using the 'StopConfigurationRecorder' action.
--
-- <http://docs.aws.amazon.com/config/latest/APIReference/API_DeleteDeliveryChannel.html>
module Network.AWS.Config.DeleteDeliveryChannel
    (
    -- * Request
      DeleteDeliveryChannel
    -- ** Request constructor
    , deleteDeliveryChannel
    -- ** Request lenses
    , ddcDeliveryChannelName

    -- * Response
    , DeleteDeliveryChannelResponse
    -- ** Response constructor
    , deleteDeliveryChannelResponse
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.Config.Types
import qualified GHC.Exts

newtype DeleteDeliveryChannel = DeleteDeliveryChannel
    { _ddcDeliveryChannelName :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'DeleteDeliveryChannel' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ddcDeliveryChannelName' @::@ 'Text'
--
deleteDeliveryChannel :: Text -- ^ 'ddcDeliveryChannelName'
                      -> DeleteDeliveryChannel
deleteDeliveryChannel p1 = DeleteDeliveryChannel
    { _ddcDeliveryChannelName = p1
    }

-- | The name of the delivery channel to delete.
ddcDeliveryChannelName :: Lens' DeleteDeliveryChannel Text
ddcDeliveryChannelName =
    lens _ddcDeliveryChannelName (\s a -> s { _ddcDeliveryChannelName = a })

data DeleteDeliveryChannelResponse = DeleteDeliveryChannelResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DeleteDeliveryChannelResponse' constructor.
deleteDeliveryChannelResponse :: DeleteDeliveryChannelResponse
deleteDeliveryChannelResponse = DeleteDeliveryChannelResponse

instance ToPath DeleteDeliveryChannel where
    toPath = const "/"

instance ToQuery DeleteDeliveryChannel where
    toQuery = const mempty

instance ToHeaders DeleteDeliveryChannel

instance ToJSON DeleteDeliveryChannel where
    toJSON DeleteDeliveryChannel{..} = object
        [ "DeliveryChannelName" .= _ddcDeliveryChannelName
        ]

instance AWSRequest DeleteDeliveryChannel where
    type Sv DeleteDeliveryChannel = Config
    type Rs DeleteDeliveryChannel = DeleteDeliveryChannelResponse

    request  = post "DeleteDeliveryChannel"
    response = nullResponse DeleteDeliveryChannelResponse
