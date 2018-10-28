module Scorched.Model.Terrain exposing (empty, random)

import Random

import Scorched.Model.Types exposing (Action(..), Terrain)
import Scorched.Model.Geometry exposing (Dimension)

random : Dimension -> Cmd Action
random dimension =
  Random.generate MenuTerrain (generator dimension)

generator : Dimension -> Random.Generator Terrain
generator {width, height} =
  Random.list width (Random.int 0 (height // 4))

empty : Terrain
empty = []
