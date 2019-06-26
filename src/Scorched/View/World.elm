module Scorched.View.World exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (World, Dimension)

import Scorched.View.Sky as Sky
import Scorched.View.Terrain as Terrain

build : World -> Svg msg
build {terrain, sky, dimensions} =
  Svg.g
    [ Attr.id "world"
    , Attr.transform "translate(1, 1)"
    ]
    [ Sky.build sky dimensions, Terrain.build terrain dimensions ]
