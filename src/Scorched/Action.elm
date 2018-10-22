module Scorched.Action exposing (..)

import Scorched.Model.Configuration as Configuration

-- type alias Messenger = Int -> Message
type alias Hook = (Char, Action)

type Action
  = NoOp
  | Initialize
  | Start
  | Configuration Configuration.Action

updates : Cmd Action
updates = Cmd.none
