module Scorched.Action where

import Signal (Signal, Channel, channel)

import Scorched.Model.Configuration as Configuration

type Action
  = NoOp
  | Start
  | Configuration Configuration.Action

updates : Channel Action
updates = channel NoOp
