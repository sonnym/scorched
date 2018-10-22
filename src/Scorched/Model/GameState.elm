module Scorched.Model.GameState exposing (..)

import Random exposing (Seed)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.World as World exposing (World)

type alias GameState = { world: World }

init : Random.Generator Int -> Dimension -> GameState
init seed dimensions = {world=World.generate seed dimensions}

empty : GameState
empty = { world=World.empty }
