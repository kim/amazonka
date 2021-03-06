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

-- Module      : Network.AWS.MachineLearning.UpdateMLModel
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

-- | Updates the 'MLModelName' and the 'ScoreThreshold' of an 'MLModel'.
--
-- You can use the 'GetMLModel' operation to view the contents of the updated
-- data element.
--
-- <http://http://docs.aws.amazon.com/machine-learning/latest/APIReference/API_UpdateMLModel.html>
module Network.AWS.MachineLearning.UpdateMLModel
    (
    -- * Request
      UpdateMLModel
    -- ** Request constructor
    , updateMLModel
    -- ** Request lenses
    , umlmMLModelId
    , umlmMLModelName
    , umlmScoreThreshold

    -- * Response
    , UpdateMLModelResponse
    -- ** Response constructor
    , updateMLModelResponse
    -- ** Response lenses
    , umlmrMLModelId
    ) where

import Network.AWS.Data (Object)
import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.MachineLearning.Types
import qualified GHC.Exts

data UpdateMLModel = UpdateMLModel
    { _umlmMLModelId      :: Text
    , _umlmMLModelName    :: Maybe Text
    , _umlmScoreThreshold :: Maybe Double
    } deriving (Eq, Ord, Read, Show)

-- | 'UpdateMLModel' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'umlmMLModelId' @::@ 'Text'
--
-- * 'umlmMLModelName' @::@ 'Maybe' 'Text'
--
-- * 'umlmScoreThreshold' @::@ 'Maybe' 'Double'
--
updateMLModel :: Text -- ^ 'umlmMLModelId'
              -> UpdateMLModel
updateMLModel p1 = UpdateMLModel
    { _umlmMLModelId      = p1
    , _umlmMLModelName    = Nothing
    , _umlmScoreThreshold = Nothing
    }

-- | The ID assigned to the 'MLModel' during creation.
umlmMLModelId :: Lens' UpdateMLModel Text
umlmMLModelId = lens _umlmMLModelId (\s a -> s { _umlmMLModelId = a })

-- | A user-supplied name or description of the 'MLModel'.
umlmMLModelName :: Lens' UpdateMLModel (Maybe Text)
umlmMLModelName = lens _umlmMLModelName (\s a -> s { _umlmMLModelName = a })

-- | The 'ScoreThreshold' used in binary classification 'MLModel' that marks the
-- boundary between a positive prediction and a negative prediction.
--
-- Output values greater than or equal to the 'ScoreThreshold' receive a positive
-- result from the 'MLModel', such as 'true'. Output values less than the 'ScoreThreshold' receive a negative response from the 'MLModel', such as 'false'.
umlmScoreThreshold :: Lens' UpdateMLModel (Maybe Double)
umlmScoreThreshold =
    lens _umlmScoreThreshold (\s a -> s { _umlmScoreThreshold = a })

newtype UpdateMLModelResponse = UpdateMLModelResponse
    { _umlmrMLModelId :: Maybe Text
    } deriving (Eq, Ord, Read, Show, Monoid)

-- | 'UpdateMLModelResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'umlmrMLModelId' @::@ 'Maybe' 'Text'
--
updateMLModelResponse :: UpdateMLModelResponse
updateMLModelResponse = UpdateMLModelResponse
    { _umlmrMLModelId = Nothing
    }

-- | The ID assigned to the 'MLModel' during creation. This value should be
-- identical to the value of the 'MLModelID' in the request.
umlmrMLModelId :: Lens' UpdateMLModelResponse (Maybe Text)
umlmrMLModelId = lens _umlmrMLModelId (\s a -> s { _umlmrMLModelId = a })

instance ToPath UpdateMLModel where
    toPath = const "/"

instance ToQuery UpdateMLModel where
    toQuery = const mempty

instance ToHeaders UpdateMLModel

instance ToJSON UpdateMLModel where
    toJSON UpdateMLModel{..} = object
        [ "MLModelId"      .= _umlmMLModelId
        , "MLModelName"    .= _umlmMLModelName
        , "ScoreThreshold" .= _umlmScoreThreshold
        ]

instance AWSRequest UpdateMLModel where
    type Sv UpdateMLModel = MachineLearning
    type Rs UpdateMLModel = UpdateMLModelResponse

    request  = post "UpdateMLModel"
    response = jsonResponse

instance FromJSON UpdateMLModelResponse where
    parseJSON = withObject "UpdateMLModelResponse" $ \o -> UpdateMLModelResponse
        <$> o .:? "MLModelId"
