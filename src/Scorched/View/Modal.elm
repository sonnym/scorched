module Scorched.View.Modal exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, View(..), Menu(..))

import Scorched.View.MainMenu as MainMenu
import Scorched.View.Component.BorderBox as BorderBox

build : Menu -> Model -> Svg Msg
build subMenu ({dimensions} as model) =
  Svg.g
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    ]
    [ MainMenu.build model, (buildInternal subMenu model) ]

buildInternal : Menu -> Model -> Svg Msg
buildInternal subMenu model =
  case subMenu of
    Landscape -> buildLandscape model

buildLandscape : Model -> Svg Msg
buildLandscape model =
  Svg.g
    [ Attr.transform "translate(410, 345)" ]
    [ BorderBox.build {width=300, height=240} 2 False ]
