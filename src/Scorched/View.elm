module Scorched.View exposing (build)

import Html exposing (Html)

import Scorched.Model.Types exposing (Model, Msg, View(..))

import Scorched.View.MainMenu as MainMenu

build : Model -> Html Msg
build model =
  case model.view of
    MainMenu -> MainMenu.build model
    -- Game -> renderWorld model
