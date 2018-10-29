module Scorched.View.World exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (World)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Sky as Sky
import Scorched.View.Terrain as Terrain

build : World -> Dimension -> Svg msg
build {terrain, sky} dimensions =
  Svg.g [ ] [ Sky.build sky dimensions, Terrain.build terrain dimensions ]
