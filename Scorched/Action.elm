module Scorched.Action where

import Signal

type Action
  = NoOp
  | PlayerCount
  | Start

updates : Signal.Channel Action
updates = Signal.channel NoOp
