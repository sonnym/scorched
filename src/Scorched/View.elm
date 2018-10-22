module Scorched.View exposing (..)

import Html exposing (Html)

-- import Graphics.Element exposing (Element)

import Scorched.Model exposing (Model, View(..))

import Scorched.View.Menu as Menu
-- import Scorched.View.GamePlay exposing (renderWorld)

render : Model -> Html msg
render model =
  case model.view of
    Menu -> Menu.render model
    -- Game -> renderWorld model
