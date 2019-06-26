module Scorched.Model.World exposing (defaultSettings, empty, random)

import Random
import Time

import Scorched.Model.Types exposing (
  Msg(..),
  MenuMsg(..),
  Permutation,
  NoiseSettings,
  WorldSettings,
  World,
  Sky,
  Terrain,
  Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> NoiseSettings -> Time.Posix -> Dimension -> Cmd Msg
random permutation settings time dimensions =
  Random.generate
    (\world -> MenuMsg_ (WorldGenerated world))
    (generator permutation settings time dimensions)

generator : Permutation -> NoiseSettings -> Time.Posix -> Dimension -> Random.Generator World
generator permutation settings time dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain})
    Sky.generator
    (Terrain.generator permutation settings time dimensions)

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }

defaultSettings : WorldSettings
defaultSettings = { sky = Sky.default }
