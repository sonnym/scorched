module Scorched.Model.Terrain where

import List
import Random (Seed)

import Scorched.Model.Geometry (Dimension)

type alias Terrain = List Int

generate : Seed -> Dimension -> Terrain
generate seed {width,height} = List.repeat width (height // 2)
