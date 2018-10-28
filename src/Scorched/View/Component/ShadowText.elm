module Scorched.View.Component.ShadowText exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Palette as Palette exposing (Color)

build : String -> Offset -> Svg msg
build text {x, y} =
  Svg.g
    [ Attr.transform ("translate(" ++ String.fromInt x ++ ", " ++ String.fromInt y ++ ")")
    , Attr.fontSize "32"
    ]
    (List.map2
      (buildText text)
      (List.range 0 ((List.length Palette.shadows) - 1))
      Palette.shadows)

buildText : String -> Int -> Color -> Svg msg
buildText label offset color =
  Svg.text_
    [ Attr.fill (Palette.toString color)
    , Attr.x (String.fromInt offset)
    , Attr.y (String.fromInt offset)
    ]
    [ Svg.text label ]