module Scorched.View.Modal exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, Modal(..))

import Scorched.View.Menu.Main as MainMenu
import Scorched.View.Transition as Transition

import Scorched.View.Modal.Landscape as Landscape
import Scorched.View.Modal.PlayerSelection as PlayerSelection

build : Modal -> Model -> Svg Msg
build modal ({dimensions} as model) =
  Svg.g
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    ]
    [ background modal model, (build_ modal model) ]

background : Modal -> Model -> Svg Msg
background modal model =
  case modal of
    Landscape -> MainMenu.build model
    PlayerSelection color -> Transition.build model color

build_ : Modal -> Model -> Svg Msg
build_ modal model =
  case modal of
    Landscape -> Landscape.build model
    PlayerSelection _ -> PlayerSelection.build model
