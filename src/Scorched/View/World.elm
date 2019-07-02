module Scorched.View.World exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (World, Dimension)

import Scorched.View.Sky as Sky
import Scorched.View.Terrain as Terrain
import Scorched.View.Tank as Tank

build : World -> Svg msg
build {terrain, sky, players, dimensions} =
  Svg.g
    [ Attr.id "world"
    , Attr.transform "translate(1, 1)"
    ]
    (List.append
      [ Sky.build sky dimensions, Terrain.build terrain dimensions ]
      (List.map (Tank.build dimensions) players))
