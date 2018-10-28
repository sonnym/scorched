module Scorched.View.Component.Button exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (Action(..), Button)
import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Button -> Svg Action
build {label, key, dimensions, offset, inverted, action} =
  Svg.g
    [ Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    , Events.onMouseDown (ButtonToggle label)
    , Events.onMouseUp (ButtonToggle label)
    ]
    [ BorderBox.build dimensions 2 inverted
    , Svg.text_ [ Attr.x "5", Attr.y "12" ] (KeyedLabel.build label key)
    ]
