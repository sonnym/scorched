module Scorched.View exposing (build)

import Html exposing (Html)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, View(..))

import Scorched.View.Menu as Menu
import Scorched.View.Modal as Modal
import Scorched.View.Transition as Transition

build : Model -> Html Msg
build ({dimensions} as model) =
  Svg.svg
    [ Attr.id "main"
    , Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    , Attr.style "user-select: none; -moz-user-select: none;"
    ]
    [ (build_ model) ]

build_ : Model -> Svg Msg
build_ model =
  case model.view of
    MenuView menu -> Menu.build menu model
    ModalView modal -> Modal.build modal model
