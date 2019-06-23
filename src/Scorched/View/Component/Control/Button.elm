module Scorched.View.Component.Control.Button exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (
  Msg,
  Specification(..),
  ButtonSpec,
  Control,
  Direction(..),
  Dimension,
  Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Control -> Bool -> Svg Msg
build ({spec} as control) disabled =
  case spec of
    Button buttonSpec ->
      case disabled of
        True -> buildDisabled control buttonSpec
        False -> buildEnabled control buttonSpec
    _ -> Svg.g [] []

buildEnabled : Control -> ButtonSpec -> Svg Msg
buildEnabled {label, key, offset, spec} {dimensions, invert, action, toggle} =
  Svg.g
    [ Attr.class "button"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    , Events.onClick action
    , Events.onMouseDown (toggle label)
    , Events.onMouseUp (toggle label)
    ]
    [ BorderBox.build dimensions 2 invert
    , KeyedLabel.build label key {x=5, y=12}
    ]

buildDisabled : Control -> ButtonSpec -> Svg Msg
buildDisabled {label, offset} {dimensions} =
  Svg.g
    [ Attr.class "button"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    ]
    [ BorderBox.build dimensions 2 False
    , Svg.text_ [ Attr.x "5" , Attr.y "12" ] [ Svg.text label ]
    ]
