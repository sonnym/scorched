module Scorched.Model.World exposing (default, defaultConfig, random)

import Random
import Time

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  Config,
  Permutation,
  WorldConfig,
  World,
  Sky,
  Terrain,
  Dimension)

import Scorched.Model.Player as Player
import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Config -> Time.Posix -> Dimension -> Cmd Msg
random permutation config time dimensions =
  Random.generate
    (\world -> BasicMsg_ (WorldGenerated world))
    (generator permutation config time dimensions)

generator : Permutation -> Config -> Time.Posix -> Dimension -> Random.Generator World
generator permutation config time dimensions =
  Random.map3
    (create dimensions)
    (Sky.generator config)
    (Terrain.generator permutation config time dimensions)
    (Player.generator config)

default : World
default =
  { sky=Sky.empty
  , terrain=Terrain.empty
  , dimensions={width=0,height=0}
  , players=[ ]
  }

defaultConfig : WorldConfig
defaultConfig =
  { sky = Sky.default
  , dimensions = menuWorldSize
  , bumpiness = 20
  , slopes = 20
  }

create : Dimension -> Sky -> Terrain -> List Int -> World
create dimensions sky terrain playerPositions =
  { sky=sky
  , terrain=terrain
  , dimensions=dimensions
  , players=[]
  }

menuWorldSize : Dimension
menuWorldSize = {width=906, height=724}
