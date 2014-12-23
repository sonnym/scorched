module Scorched.Action where

import Signal

type Action = NoOp | Play

updates : Signal.Channel Action
updates = Signal.channel NoOp
