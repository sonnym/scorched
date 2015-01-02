module Scorched.Model.World where

import List

import Scorched.Model.Sky (Sky)
import Scorched.Model.Sky as Sky

type alias Dimension = {width:Int, height:Int}

type alias Terrain = List Int

type alias World = {
  terrain: Terrain,
  sky: Sky
}

generate : Dimension -> World
generate ({width, height} as dimensions) = {
  terrain = (List.repeat width (height // 2)),
  sky = Sky.generate}
