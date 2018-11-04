module Scorched.Model.World exposing (empty, random)

import Random
import Time

import Scorched.Model.Types exposing (Msg(..), Permutation, World, Sky, Terrain)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Time.Posix -> Dimension -> Cmd Msg
random permutation time dimensions =
  Random.generate MainMenuWorld (generator permutation time dimensions)

generator : Permutation -> Time.Posix -> Dimension -> Random.Generator World
generator permutation time dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain})
    Sky.generator
    (Terrain.generator permutation time dimensions)

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }
