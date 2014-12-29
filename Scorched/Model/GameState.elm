module Scorched.Model.GameState where

import Scorched.Model.Window (dimensions)

import Scorched.Model.World (World)
import Scorched.Model.World as World

type alias GameState = {
  world: World
}

default : GameState
default = {world=World.generate dimensions}
