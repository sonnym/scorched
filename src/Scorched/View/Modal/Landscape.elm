module Scorched.View.Modal.Landscape exposing (build)

import Dict exposing (Dict)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg(..), Control, Specification(..), ButtonSpec)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.Control as Control

build : Model -> Svg Msg
build {config} =
  Svg.g
    [ Attr.transform "translate(410, 345)" ]
    [ BorderBox.build {width=300, height=240} 2 False
    , Svg.g
      [ Attr.id "landscape-controls" ]
      (List.map (Control.build config False) controls)
    ]

controls : List Control
controls =
  [ Control "Bumpiness" 'B' {x=7, y=12} (Button (ButtonSpec {width=82, height=19} False NoOp)) ]
