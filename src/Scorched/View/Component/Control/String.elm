module Scorched.View.Component.Control.String exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (
  Msg,
  Config,
  Control,
  Specification(..),
  StringControlSpec,
  Direction(..),
  Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderTriangle as BorderTriangle
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Config -> Control -> Bool -> Svg Msg
build config ({spec} as control) disabled =
  case spec of
    String typeSpec ->
      buildEnabled config control typeSpec
    _ -> Svg.g [] []

buildEnabled : Config -> Control -> StringControlSpec -> Svg Msg
buildEnabled config ({label, key, offset} as control) ({invert, getter, setter} as spec) =
  Svg.g
    [ Attr.class "type"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    ]
    [ BorderTriangle.build control (invert == Up) Up {x=0, y=0} label
    , BorderTriangle.build control (invert == Down) Down {x=0, y=12} label
    , buildLabel label key (getter config)
    ]

buildLabel : String -> Char -> String -> Svg msg
buildLabel label key value =
  KeyedLabel.build (fullLabel label value) key {x=17, y=13}

fullLabel : String -> String -> String
fullLabel label value = label ++ ": " ++ value
