module Scorched.View.Modal exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, Modal_(..))

import Scorched.View.Menu.Main as MainMenu
import Scorched.View.Modal.Landscape as Landscape

build : Modal_ -> Model -> Svg Msg
build modal ({dimensions} as model) =
  Svg.g
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    ]
    [ MainMenu.build model, (build_ modal model) ]

build_ : Modal_ -> Model -> Svg Msg
build_ modal model =
  case modal of
    Landscape -> Landscape.build model
