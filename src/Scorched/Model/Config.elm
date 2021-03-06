module Scorched.Model.Config exposing (default)

import Scorched.Model.World as World

import Scorched.Model.Types exposing (Config)

default : Config
default =
  { playerCount = 2
  , roundCount = 10
  , worldConfig = World.defaultConfig
  }
