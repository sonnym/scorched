module Scorched.View exposing (..)

import Html exposing (Html)

import Scorched.Model.Types exposing (Model, View(..))
import Scorched.Model.Action exposing (Action(..))

import Scorched.View.Menu as Menu
-- import Scorched.View.GamePlay exposing (renderWorld)

render : Model -> Html Action
render model =
  case model.view of
    Menu -> Menu.render model
    -- Game -> renderWorld model
