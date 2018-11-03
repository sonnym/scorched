module Scorched.View.Component.Control exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (Msg, Configuration, Direction(..), Control)
import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderTriangle as BorderTriangle
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Configuration -> Control -> Svg Msg
build config {label, key, offset, invert, spec} =
  Svg.g
    [ Attr.class "control"
    , Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    , Attr.wordSpacing "-3px"
    ]
    [ BorderTriangle.build spec (invert == Up) Up {x=0, y=0} label
    , BorderTriangle.build spec (invert == Down) Down {x=0, y=12} label
    , Svg.text_ [ Attr.x "17", Attr.y "13" ]  [ buildLabel label key (spec.getter config) ]
    ]

buildLabel : String -> Char -> Int -> Svg msg
buildLabel label key value =
  let
    labelWithValue = label ++ ": " ++ (String.fromInt value)
  in
    KeyedLabel.build labelWithValue key
