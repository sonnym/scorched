module Scorched.Model.World exposing (empty, random)

import Random
import Time

import Scorched.Model.Types exposing (Msg(..), MainMenuMsg(..), Permutation, NoiseSettings, World, Sky, Terrain, Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> NoiseSettings -> Time.Posix -> Dimension -> Cmd Msg
random permutation settings time dimensions =
  Random.generate
    (\world -> MainMenu (World_ world))
    (generator permutation settings time dimensions)

generator : Permutation -> NoiseSettings -> Time.Posix -> Dimension -> Random.Generator World
generator permutation settings time dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain})
    Sky.generator
    (Terrain.generator permutation settings time dimensions)

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }
