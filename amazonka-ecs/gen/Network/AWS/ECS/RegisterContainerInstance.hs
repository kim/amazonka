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

-- Module      : Network.AWS.ECS.RegisterContainerInstance
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

-- | This action is only used by the Amazon EC2 Container Service agent, and it is
-- not intended for use outside of the agent.
--
-- Registers an Amazon EC2 instance into the specified cluster. This instance
-- will become available to place containers on.
--
-- <http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RegisterContainerInstance.html>
module Network.AWS.ECS.RegisterContainerInstance
    (
    -- * Request
      RegisterContainerInstance
    -- ** Request constructor
    , registerContainerInstance
    -- ** Request lenses
    , rciCluster
    , rciInstanceIdentityDocument
    , rciInstanceIdentityDocumentSignature
    , rciTotalResources
    , rciVersionInfo

    -- * Response
    , RegisterContainerInstanceResponse
    -- ** Response constructor
    , registerContainerInstanceResponse
    -- ** Response lenses
    , rcirContainerInstance
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.ECS.Types
import qualified GHC.Exts

data RegisterContainerInstance = RegisterContainerInstance
    { _rciCluster                           :: Maybe Text
    , _rciInstanceIdentityDocument          :: Maybe Text
    , _rciInstanceIdentityDocumentSignature :: Maybe Text
    , _rciTotalResources                    :: List "totalResources" Resource
    , _rciVersionInfo                       :: Maybe VersionInfo
    } deriving (Eq, Read, Show)

-- | 'RegisterContainerInstance' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rciCluster' @::@ 'Maybe' 'Text'
--
-- * 'rciInstanceIdentityDocument' @::@ 'Maybe' 'Text'
--
-- * 'rciInstanceIdentityDocumentSignature' @::@ 'Maybe' 'Text'
--
-- * 'rciTotalResources' @::@ ['Resource']
--
-- * 'rciVersionInfo' @::@ 'Maybe' 'VersionInfo'
--
registerContainerInstance :: RegisterContainerInstance
registerContainerInstance = RegisterContainerInstance
    { _rciCluster                           = Nothing
    , _rciInstanceIdentityDocument          = Nothing
    , _rciInstanceIdentityDocumentSignature = Nothing
    , _rciTotalResources                    = mempty
    , _rciVersionInfo                       = Nothing
    }

-- | The short name or full Amazon Resource Name (ARN) of the cluster that you
-- want to register your container instance with. If you do not specify a
-- cluster, the default cluster is assumed..
rciCluster :: Lens' RegisterContainerInstance (Maybe Text)
rciCluster = lens _rciCluster (\s a -> s { _rciCluster = a })

rciInstanceIdentityDocument :: Lens' RegisterContainerInstance (Maybe Text)
rciInstanceIdentityDocument =
    lens _rciInstanceIdentityDocument
        (\s a -> s { _rciInstanceIdentityDocument = a })

rciInstanceIdentityDocumentSignature :: Lens' RegisterContainerInstance (Maybe Text)
rciInstanceIdentityDocumentSignature =
    lens _rciInstanceIdentityDocumentSignature
        (\s a -> s { _rciInstanceIdentityDocumentSignature = a })

rciTotalResources :: Lens' RegisterContainerInstance [Resource]
rciTotalResources =
    lens _rciTotalResources (\s a -> s { _rciTotalResources = a })
        . _List

rciVersionInfo :: Lens' RegisterContainerInstance (Maybe VersionInfo)
rciVersionInfo = lens _rciVersionInfo (\s a -> s { _rciVersionInfo = a })

newtype RegisterContainerInstanceResponse = RegisterContainerInstanceResponse
    { _rcirContainerInstance :: Maybe ContainerInstance
    } deriving (Eq, Read, Show)

-- | 'RegisterContainerInstanceResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rcirContainerInstance' @::@ 'Maybe' 'ContainerInstance'
--
registerContainerInstanceResponse :: RegisterContainerInstanceResponse
registerContainerInstanceResponse = RegisterContainerInstanceResponse
    { _rcirContainerInstance = Nothing
    }

rcirContainerInstance :: Lens' RegisterContainerInstanceResponse (Maybe ContainerInstance)
rcirContainerInstance =
    lens _rcirContainerInstance (\s a -> s { _rcirContainerInstance = a })

instance ToPath RegisterContainerInstance where
    toPath = const "/"

instance ToQuery RegisterContainerInstance where
    toQuery = const mempty

instance ToHeaders RegisterContainerInstance

instance ToJSON RegisterContainerInstance where
    toJSON RegisterContainerInstance{..} = object
        [ "cluster"                           .= _rciCluster
        , "instanceIdentityDocument"          .= _rciInstanceIdentityDocument
        , "instanceIdentityDocumentSignature" .= _rciInstanceIdentityDocumentSignature
        , "totalResources"                    .= _rciTotalResources
        , "versionInfo"                       .= _rciVersionInfo
        ]

instance AWSRequest RegisterContainerInstance where
    type Sv RegisterContainerInstance = ECS
    type Rs RegisterContainerInstance = RegisterContainerInstanceResponse

    request  = post "RegisterContainerInstance"
    response = jsonResponse

instance FromJSON RegisterContainerInstanceResponse where
    parseJSON = withObject "RegisterContainerInstanceResponse" $ \o -> RegisterContainerInstanceResponse
        <$> o .:? "containerInstance"
