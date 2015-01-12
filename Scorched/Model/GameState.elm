module Scorched.Model.GameState where

import Random (Seed)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World (World)
import Scorched.Model.World as World

type alias GameState = {
  world: World
}

default : Seed -> Dimension -> GameState
default seed dimensions = {world=World.generate seed dimensions}

empty : GameState
empty = { world=World.empty }
