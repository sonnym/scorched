module Scorched.View exposing (build)

import Html exposing (Html)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg)
import Scorched.Model.Types.View exposing (..)

import Scorched.View.MainMenu as MainMenu
import Scorched.View.Modal as Modal

build : Model -> Html Msg
build ({dimensions} as model) =
  Svg.svg
    [ Attr.id "main"
    , Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    , Attr.style "user-select: none; -moz-user-select: none;"
    ]
    [ (buildInternal model) ]

buildInternal : Model -> Svg Msg
buildInternal model =
  case model.view of
    Menu_ _ -> MainMenu.build model
    Modal_ subMenu -> Modal.build subMenu model
