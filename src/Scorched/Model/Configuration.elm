module Scorched.Model.Configuration exposing (default)

import Scorched.Model.Noise as Noise
import Scorched.Model.World as World

import Scorched.Model.Types exposing (Configuration)

default : Configuration
default =
  { playerCount = 2
  , roundCount = 10
  , noiseSettings = Noise.defaultSettings
  , worldSettings = World.defaultSettings
  }
