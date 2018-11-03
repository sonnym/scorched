module Scorched.View.Component.KeyedLabel exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Palette as Palette

build : String -> Char -> Offset -> Svg msg
build label key {x, y} =
  let
    location = Maybe.withDefault 0 (List.head (String.indices (String.fromChar key) label))
    prefix = String.left location label
    suffix = String.right ((String.length label) - location - 1) label
  in
    Svg.text_
      [ Attr.class "keyedlabel"
      , Attr.x (String.fromInt x)
      , Attr.y (String.fromInt y)
      ]
      [ Svg.text prefix
      , Svg.tspan [ Attr.fill (Palette.toString Palette.cyan) ] [ Svg.text (String.fromChar key) ]
      , Svg.text suffix
      ]
