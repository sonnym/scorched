module Scorched.Model.World where

import List
import Random (Seed)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Sky (Sky)
import Scorched.Model.Sky as Sky

type alias Terrain = List Int

type alias World = {
  terrain: Terrain,
  sky: Sky
}

generate : Seed -> Dimension -> World
generate seed ({width, height} as dimensions) = {
  terrain = (List.repeat width (height // 2)),
  sky = Sky.generate seed}

empty : World
empty = { terrain=[], sky=Sky.empty }
