module Scorched.View.Component.Control exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Action exposing (Action, Direction(..))
import Scorched.Model.Types exposing (Control)
import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderTriangle as BorderTriangle
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Control -> Svg Action
build {label, key, offset, invert} =
  Svg.g
    [ Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    ]
    [ BorderTriangle.build (invert == Up) Up {x=0, y=0} label
    , BorderTriangle.build (invert == Down) Down {x=0, y=12} label
    , Svg.text_ [ Attr.x "17", Attr.y "13" ] (KeyedLabel.build label key)
    ]
