module Scorched.View.Component.Numeric exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (Msg, Configuration, Control, Specification(..), NumericSpec, Direction(..))
import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderTriangle as BorderTriangle
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Configuration -> Control -> Bool -> Svg Msg
build config ({spec} as control) disabled =
  case spec of
    Numeric numericSpec ->
      case disabled of
        True -> buildDisabled config control numericSpec
        False -> buildEnabled config control numericSpec
    _ -> Svg.g [] []

buildEnabled : Configuration -> Control -> NumericSpec -> Svg Msg
buildEnabled config {label, key, offset} ({invert, getter, setter} as spec) =
  Svg.g
    [ Attr.class "control"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    ]
    [ BorderTriangle.build spec (invert == Up) Up {x=0, y=0} label
    , BorderTriangle.build spec (invert == Down) Down {x=0, y=12} label
    , buildLabel label key (getter config)
    ]

buildDisabled : Configuration -> Control -> NumericSpec -> Svg Msg
buildDisabled config {label, offset} ({getter} as spec) =
  Svg.g
    [ Attr.class "control"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    ]
    [ BorderTriangle.build spec False Up {x=0, y=0} label
    , BorderTriangle.build spec False Down {x=0, y=12} label
    , Svg.text_ [ Attr.x "17" , Attr.y "13" ] [ Svg.text (fullLabel label (getter config)) ]
    ]

buildLabel : String -> Char -> Int -> Svg msg
buildLabel label key value =
  KeyedLabel.build (fullLabel label value) key {x=17, y=13}

fullLabel : String -> Int -> String
fullLabel label value = label ++ ": " ++ (String.fromInt value)
