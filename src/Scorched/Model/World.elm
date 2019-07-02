module Scorched.Model.World exposing (default, defaultConfig, random)

import Random
import Time

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  Permutation,
  WorldConfig,
  Model,
  World,
  Sky,
  Terrain,
  Player,
  Dimension)

import Scorched.Model.Player as Player
import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

random : Permutation -> Model -> Dimension -> Cmd Msg
random permutation ({config, time} as model) dimensions =
  Random.generate
    (\world -> BasicMsg_ (WorldGenerated world))
    (generator permutation model dimensions)

generator : Permutation -> Model -> Dimension -> Random.Generator World
generator permutation {config, world, time} dimensions =
  Random.map3
    (create dimensions)
    (Sky.generator config)
    (Terrain.generator permutation config time dimensions)
    (Player.generator world.players dimensions.width)

default : World
default =
  { sky = Sky.empty
  , terrain = Terrain.empty
  , dimensions = {width=0,height=0}
  , players = [ ]
  }

defaultConfig : WorldConfig
defaultConfig =
  { sky = Sky.default
  , dimensions = menuWorldSize
  , bumpiness = 20
  , slopes = 20
  }

create : Dimension -> Sky -> Terrain -> List Player -> World
create dimensions sky terrain players =
  { sky = sky
  , terrain = terrain
  , dimensions = dimensions
  , players = players
  }

menuWorldSize : Dimension
menuWorldSize = { width = 906, height = 724 }
