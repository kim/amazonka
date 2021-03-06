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

-- Module      : Network.AWS.ELB.DescribeLoadBalancerAttributes
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

-- | Returns detailed information about all of the attributes associated with the
-- specified load balancer.
--
-- <http://docs.aws.amazon.com/ElasticLoadBalancing/latest/APIReference/API_DescribeLoadBalancerAttributes.html>
module Network.AWS.ELB.DescribeLoadBalancerAttributes
    (
    -- * Request
      DescribeLoadBalancerAttributes
    -- ** Request constructor
    , describeLoadBalancerAttributes
    -- ** Request lenses
    , dlbaLoadBalancerName

    -- * Response
    , DescribeLoadBalancerAttributesResponse
    -- ** Response constructor
    , describeLoadBalancerAttributesResponse
    -- ** Response lenses
    , dlbarLoadBalancerAttributes
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.ELB.Types
import qualified GHC.Exts

newtype DescribeLoadBalancerAttributes = DescribeLoadBalancerAttributes
    { _dlbaLoadBalancerName :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'DescribeLoadBalancerAttributes' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dlbaLoadBalancerName' @::@ 'Text'
--
describeLoadBalancerAttributes :: Text -- ^ 'dlbaLoadBalancerName'
                               -> DescribeLoadBalancerAttributes
describeLoadBalancerAttributes p1 = DescribeLoadBalancerAttributes
    { _dlbaLoadBalancerName = p1
    }

-- | The name of the load balancer.
dlbaLoadBalancerName :: Lens' DescribeLoadBalancerAttributes Text
dlbaLoadBalancerName =
    lens _dlbaLoadBalancerName (\s a -> s { _dlbaLoadBalancerName = a })

newtype DescribeLoadBalancerAttributesResponse = DescribeLoadBalancerAttributesResponse
    { _dlbarLoadBalancerAttributes :: Maybe LoadBalancerAttributes
    } deriving (Eq, Read, Show)

-- | 'DescribeLoadBalancerAttributesResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dlbarLoadBalancerAttributes' @::@ 'Maybe' 'LoadBalancerAttributes'
--
describeLoadBalancerAttributesResponse :: DescribeLoadBalancerAttributesResponse
describeLoadBalancerAttributesResponse = DescribeLoadBalancerAttributesResponse
    { _dlbarLoadBalancerAttributes = Nothing
    }

-- | The load balancer attributes structure.
dlbarLoadBalancerAttributes :: Lens' DescribeLoadBalancerAttributesResponse (Maybe LoadBalancerAttributes)
dlbarLoadBalancerAttributes =
    lens _dlbarLoadBalancerAttributes
        (\s a -> s { _dlbarLoadBalancerAttributes = a })

instance ToPath DescribeLoadBalancerAttributes where
    toPath = const "/"

instance ToQuery DescribeLoadBalancerAttributes where
    toQuery DescribeLoadBalancerAttributes{..} = mconcat
        [ "LoadBalancerName" =? _dlbaLoadBalancerName
        ]

instance ToHeaders DescribeLoadBalancerAttributes

instance AWSRequest DescribeLoadBalancerAttributes where
    type Sv DescribeLoadBalancerAttributes = ELB
    type Rs DescribeLoadBalancerAttributes = DescribeLoadBalancerAttributesResponse

    request  = post "DescribeLoadBalancerAttributes"
    response = xmlResponse

instance FromXML DescribeLoadBalancerAttributesResponse where
    parseXML = withElement "DescribeLoadBalancerAttributesResult" $ \x -> DescribeLoadBalancerAttributesResponse
        <$> x .@? "LoadBalancerAttributes"
