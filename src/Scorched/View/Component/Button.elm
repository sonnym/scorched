module Scorched.View.Component.Button exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Action exposing (Action, updates)

import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Action -> String -> Char -> Dimension -> Offset -> Svg Action
build action label key dimensions offset =
  Svg.g
  [ Attr.transform ("translate(" ++ String.fromInt offset.x ++ ", " ++ String.fromInt offset.y ++ ")")
  , Events.onMouseDown action
  ]
  [ BorderBox.build dimensions 2 False
  , Svg.text_ [ Attr.x "10", Attr.y "12.5" ] (KeyedLabel.build label key)
  ]
