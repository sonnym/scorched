module Scorched.Action where

import Signal exposing (Signal, Mailbox, Message, mailbox)

import Scorched.Model.Configuration as Configuration

type alias Messenger = Int -> Message
type alias Hook = (Char, Action)

type Action
  = NoOp
  | Initialize
  | Start
  | Configuration Configuration.Action

updates : Mailbox Action
updates = mailbox NoOp
