module Scorched.View.Terrain exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Terrain)
import Scorched.Model.Geometry exposing (Dimension)

build : Terrain -> Dimension -> List (Svg msg)
build terrain {height} =
  List.map2
    (buildLine height)
    (List.range 0 (List.length terrain - 1))
    terrain

buildLine : Int -> Int -> Int -> Svg msg
buildLine bottom yOffset height =
  Svg.line
    [ Attr.x1 (String.fromInt yOffset)
    , Attr.x2 (String.fromInt yOffset)
    , Attr.y1 (String.fromInt bottom)
    , Attr.y2 (String.fromInt (bottom - height))
    , Attr.stroke "rgb(142, 216, 112)"
    ]
    []
