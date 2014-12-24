module Scorched.Action where

import Signal

type Action = NoOp | Start

updates : Signal.Channel Action
updates = Signal.channel NoOp
