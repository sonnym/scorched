module Scorched.Model.GameState where

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World (World)
import Scorched.Model.World as World

type alias GameState = {
  world: World
}

default : Dimension -> GameState
default dimensions = {world=World.generate dimensions}

empty : GameState
empty = { world=World.empty }
