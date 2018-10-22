module Scorched.Model.World exposing (..)

-- import Scorched.Model.Geometry exposing (Dimension)

-- import Scorched.Model.Terrain as Terrain exposing (Terrain)
import Scorched.Model.Sky as Sky exposing (Sky)

type alias World =
  { sky: Sky }
  -- , terrain: Terrain

{--
generate : Random.Generator Int -> Dimension -> World
generate seed dimensions =
  { terrain = Terrain.generate seed dimensions
  , sky = Sky.generate seed
  }
--}

empty : World
empty =
  { sky=Sky.empty }
  -- ,  terrain=[]
