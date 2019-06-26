module Scorched.Model.World exposing (defaultSettings, default, random)

import Random
import Time

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  Config,
  Permutation,
  NoiseConfig,
  WorldConfig,
  World,
  Sky,
  Terrain,
  Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Config -> Time.Posix -> Dimension -> Cmd Msg
random permutation config time dimensions =
  Random.generate
    (\world -> BasicMsg_ (WorldGenerated world))
    (generator permutation config time dimensions)

generator : Permutation -> Config -> Time.Posix -> Dimension -> Random.Generator World
generator permutation config time dimensions =
  Random.map2
    (\sky terrain -> {sky=sky, terrain=terrain, dimensions=dimensions})
    (Sky.generator config)
    (Terrain.generator permutation config.noiseConfig time dimensions)

default : World
default = { sky=Sky.empty, terrain=Terrain.empty, dimensions={width=0,height=0} }

defaultSettings : WorldConfig
defaultSettings = { sky = Sky.default , dimensions = menuWorldSize }

menuWorldSize : Dimension
menuWorldSize = {width=906, height=724}
