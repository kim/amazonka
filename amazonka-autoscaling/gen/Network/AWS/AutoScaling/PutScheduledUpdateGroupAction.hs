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

-- Module      : Network.AWS.AutoScaling.PutScheduledUpdateGroupAction
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

-- | Creates or updates a scheduled scaling action for an Auto Scaling group.
-- When updating a scheduled scaling action, if you leave a parameter
-- unspecified, the corresponding value remains unchanged in the affected Auto
-- Scaling group.
--
-- For more information, see <http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/schedule_time.html Scheduled Scaling> in the /Auto Scaling DeveloperGuide/.
--
-- Auto Scaling supports the date and time expressed in "YYYY-MM-DDThh:mm:ssZ"
-- format in UTC/GMT only.
--
--
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_PutScheduledUpdateGroupAction.html>
module Network.AWS.AutoScaling.PutScheduledUpdateGroupAction
    (
    -- * Request
      PutScheduledUpdateGroupAction
    -- ** Request constructor
    , putScheduledUpdateGroupAction
    -- ** Request lenses
    , psugaAutoScalingGroupName
    , psugaDesiredCapacity
    , psugaEndTime
    , psugaMaxSize
    , psugaMinSize
    , psugaRecurrence
    , psugaScheduledActionName
    , psugaStartTime
    , psugaTime

    -- * Response
    , PutScheduledUpdateGroupActionResponse
    -- ** Response constructor
    , putScheduledUpdateGroupActionResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.AutoScaling.Types
import qualified GHC.Exts

data PutScheduledUpdateGroupAction = PutScheduledUpdateGroupAction
    { _psugaAutoScalingGroupName :: Text
    , _psugaDesiredCapacity      :: Maybe Int
    , _psugaEndTime              :: Maybe ISO8601
    , _psugaMaxSize              :: Maybe Int
    , _psugaMinSize              :: Maybe Int
    , _psugaRecurrence           :: Maybe Text
    , _psugaScheduledActionName  :: Text
    , _psugaStartTime            :: Maybe ISO8601
    , _psugaTime                 :: Maybe ISO8601
    } deriving (Eq, Ord, Read, Show)

-- | 'PutScheduledUpdateGroupAction' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'psugaAutoScalingGroupName' @::@ 'Text'
--
-- * 'psugaDesiredCapacity' @::@ 'Maybe' 'Int'
--
-- * 'psugaEndTime' @::@ 'Maybe' 'UTCTime'
--
-- * 'psugaMaxSize' @::@ 'Maybe' 'Int'
--
-- * 'psugaMinSize' @::@ 'Maybe' 'Int'
--
-- * 'psugaRecurrence' @::@ 'Maybe' 'Text'
--
-- * 'psugaScheduledActionName' @::@ 'Text'
--
-- * 'psugaStartTime' @::@ 'Maybe' 'UTCTime'
--
-- * 'psugaTime' @::@ 'Maybe' 'UTCTime'
--
putScheduledUpdateGroupAction :: Text -- ^ 'psugaAutoScalingGroupName'
                              -> Text -- ^ 'psugaScheduledActionName'
                              -> PutScheduledUpdateGroupAction
putScheduledUpdateGroupAction p1 p2 = PutScheduledUpdateGroupAction
    { _psugaAutoScalingGroupName = p1
    , _psugaScheduledActionName  = p2
    , _psugaTime                 = Nothing
    , _psugaStartTime            = Nothing
    , _psugaEndTime              = Nothing
    , _psugaRecurrence           = Nothing
    , _psugaMinSize              = Nothing
    , _psugaMaxSize              = Nothing
    , _psugaDesiredCapacity      = Nothing
    }

-- | The name or Amazon Resource Name (ARN) of the Auto Scaling group.
psugaAutoScalingGroupName :: Lens' PutScheduledUpdateGroupAction Text
psugaAutoScalingGroupName =
    lens _psugaAutoScalingGroupName
        (\s a -> s { _psugaAutoScalingGroupName = a })

-- | The number of Amazon EC2 instances that should be running in the group.
psugaDesiredCapacity :: Lens' PutScheduledUpdateGroupAction (Maybe Int)
psugaDesiredCapacity =
    lens _psugaDesiredCapacity (\s a -> s { _psugaDesiredCapacity = a })

-- | The time for this action to end.
psugaEndTime :: Lens' PutScheduledUpdateGroupAction (Maybe UTCTime)
psugaEndTime = lens _psugaEndTime (\s a -> s { _psugaEndTime = a }) . mapping _Time

-- | The maximum size for the Auto Scaling group.
psugaMaxSize :: Lens' PutScheduledUpdateGroupAction (Maybe Int)
psugaMaxSize = lens _psugaMaxSize (\s a -> s { _psugaMaxSize = a })

-- | The minimum size for the new Auto Scaling group.
psugaMinSize :: Lens' PutScheduledUpdateGroupAction (Maybe Int)
psugaMinSize = lens _psugaMinSize (\s a -> s { _psugaMinSize = a })

-- | The time when recurring future actions will start. Start time is specified
-- by the user following the Unix cron syntax format. For information about cron
-- syntax, go to <http://en.wikipedia.org/wiki/Cron Wikipedia, The Free Encyclopedia>.
--
-- When 'StartTime' and 'EndTime' are specified with 'Recurrence', they form the
-- boundaries of when the recurring action will start and stop.
psugaRecurrence :: Lens' PutScheduledUpdateGroupAction (Maybe Text)
psugaRecurrence = lens _psugaRecurrence (\s a -> s { _psugaRecurrence = a })

-- | The name of this scaling action.
psugaScheduledActionName :: Lens' PutScheduledUpdateGroupAction Text
psugaScheduledActionName =
    lens _psugaScheduledActionName
        (\s a -> s { _psugaScheduledActionName = a })

-- | The time for this action to start, as in '--start-time 2010-06-01T00:00:00Z'.
--
-- If you try to schedule your action in the past, Auto Scaling returns an
-- error message.
--
-- When 'StartTime' and 'EndTime' are specified with 'Recurrence', they form the
-- boundaries of when the recurring action will start and stop.
psugaStartTime :: Lens' PutScheduledUpdateGroupAction (Maybe UTCTime)
psugaStartTime = lens _psugaStartTime (\s a -> s { _psugaStartTime = a }) . mapping _Time

-- | 'Time' is deprecated.
--
-- The time for this action to start. 'Time' is an alias for 'StartTime' and can be
-- specified instead of 'StartTime', or vice versa. If both 'Time' and 'StartTime' are
-- specified, their values should be identical. Otherwise, 'PutScheduledUpdateGroupAction' will return an error.
psugaTime :: Lens' PutScheduledUpdateGroupAction (Maybe UTCTime)
psugaTime = lens _psugaTime (\s a -> s { _psugaTime = a }) . mapping _Time

data PutScheduledUpdateGroupActionResponse = PutScheduledUpdateGroupActionResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'PutScheduledUpdateGroupActionResponse' constructor.
putScheduledUpdateGroupActionResponse :: PutScheduledUpdateGroupActionResponse
putScheduledUpdateGroupActionResponse = PutScheduledUpdateGroupActionResponse

instance ToPath PutScheduledUpdateGroupAction where
    toPath = const "/"

instance ToQuery PutScheduledUpdateGroupAction where
    toQuery PutScheduledUpdateGroupAction{..} = mconcat
        [ "AutoScalingGroupName" =? _psugaAutoScalingGroupName
        , "DesiredCapacity"      =? _psugaDesiredCapacity
        , "EndTime"              =? _psugaEndTime
        , "MaxSize"              =? _psugaMaxSize
        , "MinSize"              =? _psugaMinSize
        , "Recurrence"           =? _psugaRecurrence
        , "ScheduledActionName"  =? _psugaScheduledActionName
        , "StartTime"            =? _psugaStartTime
        , "Time"                 =? _psugaTime
        ]

instance ToHeaders PutScheduledUpdateGroupAction

instance AWSRequest PutScheduledUpdateGroupAction where
    type Sv PutScheduledUpdateGroupAction = AutoScaling
    type Rs PutScheduledUpdateGroupAction = PutScheduledUpdateGroupActionResponse

    request  = post "PutScheduledUpdateGroupAction"
    response = nullResponse PutScheduledUpdateGroupActionResponse
