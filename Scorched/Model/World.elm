module Scorched.Model.World where

import List

type alias Terrain = List Int

type alias World = {
  terrain: Terrain
}

default : {width:Int, height:Int} -> World
default {width, height} = {terrain=(List.repeat width 500)}
