module Scorched.View.Modal exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, View(..), Menu(..))

import Scorched.View.MainMenu as MainMenu
import Scorched.View.Modal.Landscape as Landscape

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
    Landscape -> Landscape.build  model
