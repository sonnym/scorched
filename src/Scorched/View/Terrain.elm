module Scorched.View.Terrain exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Terrain, Dimension)

import Scorched.View.Helper as Helper

build : Terrain -> Dimension -> Svg msg
build terrain {height} =
  Svg.g
    [ Attr.id "terrain"
    , Attr.transform "translate(0.5, 0)"
    ]
    (List.map2
      (buildLine height)
      (List.range 0 (List.length terrain - 1))
      terrain)

buildLine : Int -> Int -> Int -> Svg msg
buildLine bottom xOffset height =
  Svg.line
    [ Attr.x1 (String.fromInt xOffset)
    , Attr.x2 (String.fromInt xOffset)
    , Attr.y1 (String.fromInt bottom)
    , Attr.y2 (String.fromInt (bottom - height))
    , Attr.strokeWidth "1"
    , Attr.stroke "rgb(142, 216, 112)"
    ]
    []
