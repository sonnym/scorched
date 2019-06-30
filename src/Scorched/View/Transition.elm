module Scorched.View.Transition exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.View.Palette as Palette exposing (Color)
import Scorched.Model.Types exposing (Model, Msg, Dimension, PlayerColor(..))

build : Model -> PlayerColor -> Svg Msg
build {dimensions, ticks} playerColor =
  Svg.g
    [ Attr.id "transition" ]
    (List.indexedMap (band ticks dimensions) (bands dimensions.width playerColor))

bands : Int -> PlayerColor -> List Color
bands width playerColor =
  let
    visibleColors = colors playerColor
  in
    List.repeat (round (toFloat (repeats width) / 2)) visibleColors
      |> List.intersperse (List.reverse visibleColors)
      |> List.concat

band : Int -> Dimension -> Int -> Color -> Svg Msg
band ticks {width, height} n color =
  let
    offset = (n * bandWidth + (timeOffset ticks))
  in
    if offset < 0 - bandWidth || offset > width then
      Svg.g [ ] [ ]
    else
      Svg.rect
        [ Attr.x (String.fromInt offset)
        , Attr.y "0"
        , Attr.width (String.fromInt bandWidth)
        , Attr.height (String.fromInt height)
        , Attr.fill (Palette.toString color)
        ]
        []

timeOffset : Int -> Int
timeOffset ticks = 0 -
  modBy (colorCount * bandWidth * 2) (ticks * 10)

colors : PlayerColor -> List Color
colors playerColor =
  case playerColor of
    Red -> colorsRed
    Green -> colorsGreen
    Purple -> colorsPurple
    Yellow -> colorsYellow
    Aqua -> colorsAqua
    Fuchsia -> colorsFuchsia

repeats : Int -> Int
repeats width = 2 + round (toFloat width / toFloat (colorCount * bandWidth))

colorsRed : List Color
colorsRed =
  [ { r = 52, g = 8, b = 8 }
  , { r = 60, g = 8, b = 8 }
  , { r = 73, g = 8, b = 8 }
  , { r = 85, g = 12, b = 12 }
  , { r = 93, g = 12, b = 12 }
  , { r = 105, g = 16, b = 16 }
  , { r = 113, g = 16, b = 16 }
  , { r = 125, g = 20, b = 20 }
  , { r = 138, g = 20, b = 20 }
  , { r = 146, g = 20, b = 20 }
  , { r = 158, g = 24, b = 24 }
  , { r = 170, g = 24, b = 24 }
  , { r = 178, g = 28, b = 28 }
  , { r = 190, g = 28, b = 28 }
  , { r = 199, g = 28, b = 28 }
  , { r = 211, g = 32, b = 32 }
  , { r = 223, g = 32, b = 32 }
  , { r = 231, g = 36, b = 36 }
  , { r = 243, g = 36, b = 36 }
  , { r = 255, g = 40, b = 40 }
  ]

colorsGreen : List Color
colorsGreen =
  [ { r = 28, g = 44, b = 8 }
  , { r = 32, g = 52, b = 8 }
  , { r = 40, g = 65, b = 8 }
  , { r = 44, g = 73, b = 12 }
  , { r = 52, g = 81, b = 12 }
  , { r = 56, g = 89, b = 16 }
  , { r = 65, g = 101, b = 16 }
  , { r = 69, g = 109, b = 20 }
  , { r = 73, g = 117, b = 20 }
  , { r = 81, g = 130, b = 20 }
  , { r = 85, g = 138, b = 24 }
  , { r = 93, g = 146, b = 24 }
  , { r = 97, g = 154, b = 28 }
  , { r = 105, g = 166, b = 28 }
  , { r = 109, g = 174, b = 28 }
  , { r = 117, g = 182, b = 32 }
  , { r = 121, g = 195, b = 32 }
  , { r = 130, g = 203, b = 36 }
  , { r = 134, g = 211, b = 36 }
  , { r = 142, g = 223, b = 40 }
  ]

colorsPurple : List Color
colorsPurple =
  [ { r = 32, g = 16, b = 52 }
  , { r = 40, g = 20, b = 60 }
  , { r = 44, g = 20, b = 73 }
  , { r = 52, g = 24, b = 85 }
  , { r = 60, g = 28, b = 93 }
  , { r = 65, g = 32, b = 105 }
  , { r = 73, g = 36, b = 113 }
  , { r = 81, g = 40, b = 125 }
  , { r = 85, g = 40, b = 138 }
  , { r = 93, g = 44, b = 146 }
  , { r = 101, g = 48, b = 158 }
  , { r = 105, g = 52, b = 170 }
  , { r = 113, g = 56, b = 178 }
  , { r = 121, g = 60, b = 190 }
  , { r = 134, g = 65, b = 211 }
  , { r = 142, g = 69, b = 223 }
  , { r = 146, g = 73, b = 231 }
  , { r = 154, g = 77, b = 243 }
  , { r = 162, g = 81, b = 255 }
  ]

colorsYellow : List Color
colorsYellow =
  [ { r = 52, g = 52, b = 8 }
  , { r = 60, g = 60, b = 8 }
  , { r = 73, g = 73, b = 8 }
  , { r = 85, g = 85, b = 8 }
  , { r = 93, g = 93, b = 12 }
  , { r = 105, g = 105, b = 16 }
  , { r = 113, g = 113, b = 16 }
  , { r = 125, g = 125, b = 16 }
  , { r = 138, g = 138, b = 20 }
  , { r = 146, g = 146, b = 20 }
  , { r = 158, g = 158, b = 24 }
  , { r = 170, g = 170, b = 24 }
  , { r = 178, g = 178, b = 28 }
  , { r = 190, g = 190, b = 28 }
  , { r = 199, g = 199, b = 28 }
  , { r = 211, g = 211, b = 32 }
  , { r = 223, g = 223, b = 32 }
  , { r = 231, g = 231, b = 36 }
  , { r = 243, g = 243, b = 36 }
  , { r = 255, g = 255, b = 40 }
  ]

colorsAqua : List Color
colorsAqua =
  [ { r = 8, g = 52, b = 52 }
  , { r = 8, g = 60, b = 60 }
  , { r = 8, g = 73, b = 73 }
  , { r = 12, g = 85, b = 85 }
  , { r = 12, g = 93, b = 93 }
  , { r = 16, g = 105, b = 105 }
  , { r = 16, g = 113, b = 113 }
  , { r = 20, g = 125, b = 125 }
  , { r = 20, g = 138, b = 138 }
  , { r = 20, g = 146, b = 146 }
  , { r = 24, g = 158, b = 158 }
  , { r = 24, g = 170, b = 170 }
  , { r = 28, g = 178, b = 178 }
  , { r = 28, g = 190, b = 190 }
  , { r = 28, g = 199, b = 199 }
  , { r = 32, g = 211, b = 211 }
  , { r = 32, g = 223, b = 223 }
  , { r = 36, g = 231, b = 231 }
  , { r = 36, g = 243, b = 243 }
  , { r = 40, g = 255, b = 255 }
  ]

colorsFuchsia : List Color
colorsFuchsia =
  [ { r = 52, g = 8, b = 52 }
  , { r = 60, g = 8, b = 60 }
  , { r = 73, g = 8, b = 73 }
  , { r = 85, g = 12, b = 85 }
  , { r = 93, g = 12, b = 93 }
  , { r = 105, g = 16, b = 105 }
  , { r = 113, g = 16, b = 113 }
  , { r = 125, g = 20, b = 125 }
  , { r = 138, g = 20, b = 138 }
  , { r = 146, g = 20, b = 146 }
  , { r = 158, g = 24, b = 158 }
  , { r = 170, g = 24, b = 170 }
  , { r = 178, g = 28, b = 178 }
  , { r = 190, g = 28, b = 190 }
  , { r = 199, g = 28, b = 199 }
  , { r = 211, g = 32, b = 211 }
  , { r = 223, g = 32, b = 223 }
  , { r = 231, g = 36, b = 231 }
  , { r = 243, g = 36, b = 243 }
  , { r = 255, g = 40, b = 255 }
  ]

colorCount : Int
colorCount = 20

bandWidth : Int
bandWidth = 18
