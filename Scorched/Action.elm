module Scorched.Action where

import Signal (Signal, Channel, Message, channel)

import Scorched.Model.Configuration as Configuration

type alias Messenger = Int -> Message
type alias Hook = (Char, Action)

type Action
  = NoOp
  | Start
  | Configuration Configuration.Action

updates : Channel Action
updates = channel NoOp
