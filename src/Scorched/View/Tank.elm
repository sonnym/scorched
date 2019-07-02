module Scorched.View.Tank exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Player, Msg, Dimension)

build : Dimension -> Player -> Svg msg
build {height} {position} =
  Svg.circle
    [ Attr.cx (String.fromInt position.x)
    , Attr.cy (String.fromInt (height - position.y))
    , Attr.r "10"
    ] []
