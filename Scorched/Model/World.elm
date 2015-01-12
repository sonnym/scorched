module Scorched.Model.World where

import List
import Random (Seed)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Terrain (Terrain)
import Scorched.Model.Terrain as Terrain

import Scorched.Model.Sky (Sky)
import Scorched.Model.Sky as Sky

type alias World = {
  terrain: Terrain,
  sky: Sky
}

generate : Seed -> Dimension -> World
generate seed dimensions = {
  terrain = Terrain.generate seed dimensions,
  sky = Sky.generate seed}

empty : World
empty = { terrain=[], sky=Sky.empty }
