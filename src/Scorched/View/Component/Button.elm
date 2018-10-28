module Scorched.View.Component.Button exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Action as Action exposing (Action)

import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

type alias Button =
  { label: String
  , key: Char
  , dimensions: Dimension
  , offset: Offset
  , inverted: Bool
  , action: Action
  }

build : Button -> Svg Action
build {label, key, dimensions, offset, inverted, action} =
  Svg.g
    [ Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Events.onMouseDown (Action.ButtonDown label)
    , Events.onMouseUp (Action.ButtonUp label)
    ]
    [ BorderBox.build dimensions 2 inverted
    , Svg.text_ [ Attr.x "5", Attr.y "12" ] (KeyedLabel.build label key)
    ]
