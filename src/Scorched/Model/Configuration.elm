module Scorched.Model.Configuration exposing (..)

import Scorched.Model.Types exposing (Configuration)

type Action
  = NoOp
  | PlayerCount Int
  | RoundCount Int

step : Action -> Configuration -> Configuration
step action config =
  case action of
    PlayerCount value -> { config | playerCount = value }
    RoundCount value -> { config | roundCount = value }
    NoOp -> config

default : Configuration
default = { playerCount = 2, roundCount = 10 }
