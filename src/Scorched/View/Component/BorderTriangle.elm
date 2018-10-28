module Scorched.View.Component.BorderTriangle exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Offset, Point)

import Scorched.View.Helper as Helper

import Scorched.View.Palette as Palette exposing (Color)

type Direction = Up | Down

build : Bool -> Direction -> Offset -> Svg msg
build invert direction offset =
  Svg.g
    [ Attr.transform (Helper.translate offset) ]
    (lines invert direction)

lines : Bool -> Direction -> List (Svg msg)
lines invert direction =
  case direction of
    Up -> List.map2 line upLines upColors
    Down -> List.map2 line downLines downColors

line : (Point, Point) -> Color -> Svg msg
line (start, end) color =
  Svg.line
    [ Attr.x1 (String.fromInt start.x)
    , Attr.x2 (String.fromInt end.x)
    , Attr.y1 (String.fromInt start.y)
    , Attr.y2 (String.fromInt end.y)
    , Attr.strokeWidth "2"
    , Attr.stroke (Palette.toString color)
    ]
    []

upLines : List (Point, Point)
upLines = [ ({x=7, y=0}, {x=14, y=9})
          , ({x=14, y=9}, {x=0, y=9})
          , ({x=0, y=9}, {x=7, y=0})
          ]

downLines : List (Point, Point)
downLines = [ ({x=0, y=0}, {x=14, y=0})
            , ({x=14, y=0}, {x=7, y=9})
            , ({x=7, y=9}, {x=0, y=0})
            ]

upColors : List Color
upColors = [ Palette.shadowDark, Palette.shadowLight, Palette.highlightLight ]

downColors : List Color
downColors = [ Palette.highlightDark, Palette.shadowDark, Palette.highlightLight ]
