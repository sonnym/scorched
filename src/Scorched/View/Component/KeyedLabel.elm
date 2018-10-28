module Scorched.View.Component.KeyedLabel exposing (build)

import Svg exposing (..)
import Svg.Attributes as Attr

import Scorched.View.Palette as Palette

build : String -> Char -> List (Svg msg)
build label key =
  let
    location = Maybe.withDefault 0 (List.head (String.indices (String.fromChar key) label))
    prefix = String.left location label
    suffix = String.right ((String.length label) - location - 1) label
  in
    [ Svg.text prefix
    , Svg.tspan [ Attr.fill (Palette.toString Palette.cyan) ] [ Svg.text (String.fromChar key) ]
    , Svg.text suffix
    ]
