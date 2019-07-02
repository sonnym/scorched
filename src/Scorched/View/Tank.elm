module Scorched.View.Tank exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Player, Msg)

build : Player -> Svg msg
build {position} =
  Svg.circle
    [ Attr.cx (String.fromInt position.x)
    , Attr.cy (String.fromInt position.y)
    , Attr.r "10"
    ] []
