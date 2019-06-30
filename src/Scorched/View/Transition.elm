module Scorched.View.Transition exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.View.Palette as Palette exposing (Color)
import Scorched.Model.Types exposing (Model, Msg)

build : Model -> Svg Msg
build {dimensions, ticks} =
  Svg.g
    [ Attr.id "transition" ]
    (List.indexedMap (band ticks dimensions.height) (bands dimensions.width))

bands : Int -> List Color
bands width =
  List.repeat (round (toFloat (repeats width) / 2)) colors
    |> List.intersperse (List.reverse colors)
    |> List.concat

band : Int -> Int -> Int -> Color -> Svg Msg
band ticks height offset color =
  Svg.rect
    [ Attr.x (String.fromInt (offset * bandWidth + (timeOffset ticks)))
    , Attr.y "0"
    , Attr.width (String.fromInt bandWidth)
    , Attr.height (String.fromInt height)
    , Attr.fill (Palette.toString color)
    ]
    []

timeOffset : Int -> Int
timeOffset ticks = 0 -
  modBy ((List.length colors) * bandWidth * 2) (ticks * 10)

colors : List Color
colors =
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

bandWidth : Int
bandWidth = 18

repeats : Int -> Int
repeats width = 2 + round (toFloat width / toFloat ((List.length colors) * bandWidth))
