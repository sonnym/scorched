module Scorched.View.Terrain exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Terrain, Dimension)

import Scorched.View.Helper as Helper
import Scorched.View.Palette as Palette exposing (Color)

build : Terrain -> Dimension -> Svg msg
build {altitudes, color} {height} =
  Svg.g
    [ Attr.id "terrain"
    , Attr.transform "translate(0.5, 0)"
    ]
    (List.map2
      (buildLine color height)
      (List.range 0 (List.length altitudes - 1))
      altitudes)

buildLine : Color -> Int -> Int -> Int -> Svg msg
buildLine color bottom xOffset height =
  Svg.line
    [ Attr.x1 (String.fromInt xOffset)
    , Attr.x2 (String.fromInt xOffset)
    , Attr.y1 (String.fromInt bottom)
    , Attr.y2 (String.fromInt (bottom - height))
    , Attr.strokeWidth "1"
    , Attr.stroke (Palette.toString color)
    ]
    []
