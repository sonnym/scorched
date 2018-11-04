module Scorched.View.Component.Button exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (Msg(..), Specification(..), Control, Direction(..))
import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Control -> Svg Msg
build {label, key, offset, spec} =
  case spec of
    Button {dimensions, inverted, action} ->
      Svg.g
        [ Attr.class "button"
        , Attr.transform (Helper.translate offset)
        , Attr.fontWeight "600"
        , Attr.letterSpacing "-1px"
        , Attr.wordSpacing "-3px"
        , Events.onClick action
        , Events.onMouseDown (ControlToggle label None)
        , Events.onMouseUp (ControlToggle label None)
        ]
        [ BorderBox.build dimensions 2 inverted
        , KeyedLabel.build label key {x=5, y=12}
        ]
    _ -> Svg.g [] []
