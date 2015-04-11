module Scorched.Action where

import Signal exposing (Signal, Channel, Message, channel)

import Scorched.Model.Configuration as Configuration

type alias Messenger = Int -> Message
type alias Hook = (Char, Action)

type Action
  = NoOp
  | Initialize
  | Start
  | Configuration Configuration.Action

updates : Channel Action
updates = channel NoOp
