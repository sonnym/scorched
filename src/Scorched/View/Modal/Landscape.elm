module Scorched.View.Modal.Landscape exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.View.Component.BorderBox as BorderBox

build : Model -> Svg Msg
build model =
  Svg.g
    [ Attr.transform "translate(410, 345)" ]
    [ BorderBox.build {width=300, height=240} 2 False ]
