module Scorched.Model.World where

import List

type alias Dimension = {width:Int, height:Int}

type alias Terrain = List Int

type alias World = {
  terrain: Terrain
}

generate : Dimension -> World
generate {width, height} = {terrain=(List.repeat width (height // 2))}
