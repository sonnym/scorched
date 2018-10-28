module Scorched.View.Component.Button exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Action as Action exposing (Action)

import Scorched.Model.Geometry exposing (Dimension, Offset)

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
  [ Attr.transform ("translate(" ++ String.fromInt offset.x ++ ", " ++ String.fromInt offset.y ++ ")")
  , Attr.fontWeight "bold"
  , Events.onMouseDown (Action.ButtonDown label)
  , Events.onMouseUp (Action.ButtonUp label)
  ]
  [ BorderBox.build dimensions 2 inverted
  , Svg.text_ [ Attr.x "10", Attr.y "12.5" ] (KeyedLabel.build label key)
  ]