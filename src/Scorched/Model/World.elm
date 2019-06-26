module Scorched.Model.World exposing (defaultSettings, empty, random)

import Random
import Time

import Scorched.Model.Types exposing (
  Msg(..),
  MenuMsg(..),
  Configuration,
  Permutation,
  NoiseSettings,
  WorldSettings,
  World,
  Sky,
  Terrain,
  Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Configuration -> Time.Posix -> Dimension -> Cmd Msg
random permutation config time dimensions =
  Random.generate
    (\world -> MenuMsg_ (WorldGenerated world))
    (generator permutation config time dimensions)

generator : Permutation -> Configuration -> Time.Posix -> Dimension -> Random.Generator World
generator permutation config time dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain})
    (Sky.generator config)
    (Terrain.generator permutation config.noiseSettings time dimensions)

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }

defaultSettings : WorldSettings
defaultSettings = { sky = Sky.default }
