module Scorched.View.Modal.Landscape exposing (build)

import Dict exposing (Dict)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg(..), Control, Direction(..), Specification(..), TypeSpec)

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
  [ Control "Sky" 'S' {x=7, y=12} (Type (TypeSpec None (\_ -> "Random") (\a _ -> a))) ]
