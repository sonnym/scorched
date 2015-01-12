module Scorched.Model.GameState where

import Random (Seed)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World (World)
import Scorched.Model.World as World

type alias GameState = {
  world: World
}

init : Seed -> Dimension -> GameState
init seed dimensions = {world=World.generate seed dimensions}

empty : GameState
empty = { world=World.empty }
