module Scorched.Model.Configuration exposing (..)

type Action
  = NoOp
  | PlayerCount Int
  | RoundCount Int

type alias Configuration =
  { playerCount: Int
  , roundCount: Int
  }

step : Action -> Configuration -> Configuration
step action config =
  case action of
    PlayerCount value -> { config | playerCount = value }
    RoundCount value -> { config | roundCount = value }
    NoOp -> config

default : Configuration
default = {
  playerCount = 2,
  roundCount = 10 }
