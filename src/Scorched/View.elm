module Scorched.View exposing (build)

import Html exposing (Html)

import Scorched.Model.Types exposing (Model, Action, View(..))

import Scorched.View.Menu as Menu

build : Model -> Html Action
build model =
  case model.view of
    Menu -> Menu.build model
    -- Game -> renderWorld model
