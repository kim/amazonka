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

-- Module      : Network.AWS.SDB.ListDomains
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

-- | The 'ListDomains' operation lists all domains associated with the Access Key
-- ID. It returns domain names up to the limit set by <#MaxNumberOfDomains MaxNumberOfDomains>. A <#NextToken NextToken> is returned if there are more than 'MaxNumberOfDomains' domains. Calling 'ListDomains' successive times with the 'NextToken' provided by the operation returns up to 'MaxNumberOfDomains' more domain names with each successive operation call.
--
-- <http://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/SDB_API_ListDomains.html>
module Network.AWS.SDB.ListDomains
    (
    -- * Request
      ListDomains
    -- ** Request constructor
    , listDomains
    -- ** Request lenses
    , ldMaxNumberOfDomains
    , ldNextToken

    -- * Response
    , ListDomainsResponse
    -- ** Response constructor
    , listDomainsResponse
    -- ** Response lenses
    , ldrDomainNames
    , ldrNextToken
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.SDB.Types
import qualified GHC.Exts

data ListDomains = ListDomains
    { _ldMaxNumberOfDomains :: Maybe Int
    , _ldNextToken          :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListDomains' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ldMaxNumberOfDomains' @::@ 'Maybe' 'Int'
--
-- * 'ldNextToken' @::@ 'Maybe' 'Text'
--
listDomains :: ListDomains
listDomains = ListDomains
    { _ldMaxNumberOfDomains = Nothing
    , _ldNextToken          = Nothing
    }

-- | The maximum number of domain names you want returned. The range is 1 to 100.
-- The default setting is 100.
ldMaxNumberOfDomains :: Lens' ListDomains (Maybe Int)
ldMaxNumberOfDomains =
    lens _ldMaxNumberOfDomains (\s a -> s { _ldMaxNumberOfDomains = a })

-- | A string informing Amazon SimpleDB where to start the next list of domain
-- names.
ldNextToken :: Lens' ListDomains (Maybe Text)
ldNextToken = lens _ldNextToken (\s a -> s { _ldNextToken = a })

data ListDomainsResponse = ListDomainsResponse
    { _ldrDomainNames :: List "member" Text
    , _ldrNextToken   :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListDomainsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ldrDomainNames' @::@ ['Text']
--
-- * 'ldrNextToken' @::@ 'Maybe' 'Text'
--
listDomainsResponse :: ListDomainsResponse
listDomainsResponse = ListDomainsResponse
    { _ldrDomainNames = mempty
    , _ldrNextToken   = Nothing
    }

-- | A list of domain names that match the expression.
ldrDomainNames :: Lens' ListDomainsResponse [Text]
ldrDomainNames = lens _ldrDomainNames (\s a -> s { _ldrDomainNames = a }) . _List

-- | An opaque token indicating that there are more domains than the specified 'MaxNumberOfDomains' still available.
ldrNextToken :: Lens' ListDomainsResponse (Maybe Text)
ldrNextToken = lens _ldrNextToken (\s a -> s { _ldrNextToken = a })

instance ToPath ListDomains where
    toPath = const "/"

instance ToQuery ListDomains where
    toQuery ListDomains{..} = mconcat
        [ "MaxNumberOfDomains" =? _ldMaxNumberOfDomains
        , "NextToken"          =? _ldNextToken
        ]

instance ToHeaders ListDomains

instance AWSRequest ListDomains where
    type Sv ListDomains = SDB
    type Rs ListDomains = ListDomainsResponse

    request  = post "ListDomains"
    response = xmlResponse

instance FromXML ListDomainsResponse where
    parseXML = withElement "ListDomainsResult" $ \x -> ListDomainsResponse
        <$> parseXML x
        <*> x .@? "NextToken"

instance AWSPager ListDomains where
    page rq rs
        | stop (rs ^. ldrNextToken) = Nothing
        | otherwise = (\x -> rq & ldNextToken ?~ x)
            <$> (rs ^. ldrNextToken)
