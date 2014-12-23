module Scorched.Model.World where

import List

type alias Dimension = {width:Int, height:Int}

type alias Terrain = List Int

type alias World = {
  terrain: Terrain
}

default : Dimension -> World
default {width, height} = {terrain=(List.repeat width 500)}
