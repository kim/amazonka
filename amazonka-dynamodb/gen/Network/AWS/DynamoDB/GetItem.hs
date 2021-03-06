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

-- Module      : Network.AWS.DynamoDB.GetItem
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

-- | The /GetItem/ operation returns a set of attributes for the item with the given
-- primary key. If there is no matching item, /GetItem/ does not return any data.
--
-- /GetItem/ provides an eventually consistent read by default. If your
-- application requires a strongly consistent read, set /ConsistentRead/ to 'true'.
-- Although a strongly consistent read might take more time than an eventually
-- consistent read, it always returns the last updated value.
--
-- <http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_GetItem.html>
module Network.AWS.DynamoDB.GetItem
    (
    -- * Request
      GetItem
    -- ** Request constructor
    , getItem
    -- ** Request lenses
    , giAttributesToGet
    , giConsistentRead
    , giExpressionAttributeNames
    , giKey
    , giProjectionExpression
    , giReturnConsumedCapacity
    , giTableName

    -- * Response
    , GetItemResponse
    -- ** Response constructor
    , getItemResponse
    -- ** Response lenses
    , girConsumedCapacity
    , girItem
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.DynamoDB.Types
import qualified GHC.Exts

data GetItem = GetItem
    { _giAttributesToGet          :: List1 "AttributesToGet" Text
    , _giConsistentRead           :: Maybe Bool
    , _giExpressionAttributeNames :: Map Text Text
    , _giKey                      :: Map Text AttributeValue
    , _giProjectionExpression     :: Maybe Text
    , _giReturnConsumedCapacity   :: Maybe ReturnConsumedCapacity
    , _giTableName                :: Text
    } deriving (Eq, Read, Show)

-- | 'GetItem' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'giAttributesToGet' @::@ 'NonEmpty' 'Text'
--
-- * 'giConsistentRead' @::@ 'Maybe' 'Bool'
--
-- * 'giExpressionAttributeNames' @::@ 'HashMap' 'Text' 'Text'
--
-- * 'giKey' @::@ 'HashMap' 'Text' 'AttributeValue'
--
-- * 'giProjectionExpression' @::@ 'Maybe' 'Text'
--
-- * 'giReturnConsumedCapacity' @::@ 'Maybe' 'ReturnConsumedCapacity'
--
-- * 'giTableName' @::@ 'Text'
--
getItem :: Text -- ^ 'giTableName'
        -> NonEmpty Text -- ^ 'giAttributesToGet'
        -> GetItem
getItem p1 p2 = GetItem
    { _giTableName                = p1
    , _giAttributesToGet          = withIso _List1 (const id) p2
    , _giKey                      = mempty
    , _giConsistentRead           = Nothing
    , _giReturnConsumedCapacity   = Nothing
    , _giProjectionExpression     = Nothing
    , _giExpressionAttributeNames = mempty
    }

-- | There is a newer parameter available. Use /ProjectionExpression/ instead. Note
-- that if you use /AttributesToGet/ and /ProjectionExpression/ at the same time,
-- DynamoDB will return a /ValidationException/ exception.
--
-- This parameter allows you to retrieve attributes of type List or Map;
-- however, it cannot retrieve individual elements within a List or a Map.
--
-- The names of one or more attributes to retrieve. If no attribute names are
-- provided, then all attributes will be returned. If any of the requested
-- attributes are not found, they will not appear in the result.
--
-- Note that /AttributesToGet/ has no effect on provisioned throughput
-- consumption. DynamoDB determines capacity units consumed based on item size,
-- not on the amount of data that is returned to an application.
giAttributesToGet :: Lens' GetItem (NonEmpty Text)
giAttributesToGet =
    lens _giAttributesToGet (\s a -> s { _giAttributesToGet = a })
        . _List1

-- | A value that if set to 'true', then the operation uses strongly consistent
-- reads; otherwise, eventually consistent reads are used.
giConsistentRead :: Lens' GetItem (Maybe Bool)
giConsistentRead = lens _giConsistentRead (\s a -> s { _giConsistentRead = a })

-- | One or more substitution tokens for attribute names in an expression. The
-- following are some use cases for using /ExpressionAttributeNames/:
--
-- To access an attribute whose name conflicts with a DynamoDB reserved word.
--
-- To create a placeholder for repeating occurrences of an attribute name in
-- an expression.
--
-- To prevent special characters in an attribute name from being
-- misinterpreted in an expression.
--
-- Use the # character in an expression to dereference an attribute name. For
-- example, consider the following attribute name:
--
-- 'Percentile'
--
-- The name of this attribute conflicts with a reserved word, so it cannot be
-- used directly in an expression. (For the complete list of reserved words, go
-- to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html Reserved Words> in the /Amazon DynamoDB Developer Guide/). To work around
-- this, you could specify the following for /ExpressionAttributeNames/:
--
-- '{"#P":"Percentile"}'
--
-- You could then use this substitution in an expression, as in this example:
--
-- '#P = :val'
--
-- Tokens that begin with the : character are /expression attribute values/,
-- which are placeholders for the actual value at runtime.
--
-- For more information on expression attribute names, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html Accessing ItemAttributes> in the /Amazon DynamoDB Developer Guide/.
giExpressionAttributeNames :: Lens' GetItem (HashMap Text Text)
giExpressionAttributeNames =
    lens _giExpressionAttributeNames
        (\s a -> s { _giExpressionAttributeNames = a })
            . _Map

-- | A map of attribute names to /AttributeValue/ objects, representing the primary
-- key of the item to retrieve.
--
-- For the primary key, you must provide all of the attributes. For example,
-- with a hash type primary key, you only need to provide the hash attribute.
-- For a hash-and-range type primary key, you must provide both the hash
-- attribute and the range attribute.
giKey :: Lens' GetItem (HashMap Text AttributeValue)
giKey = lens _giKey (\s a -> s { _giKey = a }) . _Map

-- | A string that identifies one or more attributes to retrieve from the table.
-- These attributes can include scalars, sets, or elements of a JSON document.
-- The attributes in the expression must be separated by commas.
--
-- If no attribute names are specified, then all attributes will be returned.
-- If any of the requested attributes are not found, they will not appear in the
-- result.
--
-- For more information, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html Accessing Item Attributes> in the /Amazon DynamoDBDeveloper Guide/.
giProjectionExpression :: Lens' GetItem (Maybe Text)
giProjectionExpression =
    lens _giProjectionExpression (\s a -> s { _giProjectionExpression = a })

giReturnConsumedCapacity :: Lens' GetItem (Maybe ReturnConsumedCapacity)
giReturnConsumedCapacity =
    lens _giReturnConsumedCapacity
        (\s a -> s { _giReturnConsumedCapacity = a })

-- | The name of the table containing the requested item.
giTableName :: Lens' GetItem Text
giTableName = lens _giTableName (\s a -> s { _giTableName = a })

data GetItemResponse = GetItemResponse
    { _girConsumedCapacity :: Maybe ConsumedCapacity
    , _girItem             :: Map Text AttributeValue
    } deriving (Eq, Read, Show)

-- | 'GetItemResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'girConsumedCapacity' @::@ 'Maybe' 'ConsumedCapacity'
--
-- * 'girItem' @::@ 'HashMap' 'Text' 'AttributeValue'
--
getItemResponse :: GetItemResponse
getItemResponse = GetItemResponse
    { _girItem             = mempty
    , _girConsumedCapacity = Nothing
    }

girConsumedCapacity :: Lens' GetItemResponse (Maybe ConsumedCapacity)
girConsumedCapacity =
    lens _girConsumedCapacity (\s a -> s { _girConsumedCapacity = a })

-- | A map of attribute names to /AttributeValue/ objects, as specified by /AttributesToGet/.
girItem :: Lens' GetItemResponse (HashMap Text AttributeValue)
girItem = lens _girItem (\s a -> s { _girItem = a }) . _Map

instance ToPath GetItem where
    toPath = const "/"

instance ToQuery GetItem where
    toQuery = const mempty

instance ToHeaders GetItem

instance ToJSON GetItem where
    toJSON GetItem{..} = object
        [ "TableName"                .= _giTableName
        , "Key"                      .= _giKey
        , "AttributesToGet"          .= _giAttributesToGet
        , "ConsistentRead"           .= _giConsistentRead
        , "ReturnConsumedCapacity"   .= _giReturnConsumedCapacity
        , "ProjectionExpression"     .= _giProjectionExpression
        , "ExpressionAttributeNames" .= _giExpressionAttributeNames
        ]

instance AWSRequest GetItem where
    type Sv GetItem = DynamoDB
    type Rs GetItem = GetItemResponse

    request  = post "GetItem"
    response = jsonResponse

instance FromJSON GetItemResponse where
    parseJSON = withObject "GetItemResponse" $ \o -> GetItemResponse
        <$> o .:? "ConsumedCapacity"
        <*> o .:? "Item" .!= mempty
