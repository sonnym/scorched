module Scorched.Action where

import Signal (Signal, Channel, channel)

type Action
  = NoOp
  | PlayerCount Int
  | Start

updates : Channel Action
updates = channel NoOp
