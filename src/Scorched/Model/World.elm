module Scorched.Model.World exposing (..)

import Random exposing (..)

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Terrain as Terrain exposing (Terrain)

-- import Scorched.Model.Sky as Sky exposing (Sky)

type alias World =
  { terrain: Terrain
  -- , sky: Sky
  }

generate : Random.Generator Int -> Dimension -> World
generate seed dimensions =
  { terrain = Terrain.generate seed dimensions
  -- , sky = Sky.generate seed
  }

empty : World
empty =
  { terrain=[]
  -- , sky=Sky.empty
  }
