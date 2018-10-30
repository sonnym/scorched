module Scorched.Model.World exposing (empty, random)

import Random

import Scorched.Model.Types exposing (Msg(..), Permutation, World, Sky, Terrain)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Dimension -> Cmd Msg
random permutation dimensions =
  Random.generate MenuWorld (generator permutation dimensions)

generator : Permutation -> Dimension -> Random.Generator World
generator permutation dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain})
    Sky.generator
    (Terrain.generator permutation dimensions)

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }
