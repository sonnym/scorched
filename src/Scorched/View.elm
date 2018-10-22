module Scorched.View exposing (..)

import Html exposing (Html)

-- import Graphics.Element exposing (Element)

import Scorched.Model exposing (Model, View(..))

import Scorched.View.Menu exposing (renderMenu)
-- import Scorched.View.GamePlay exposing (renderWorld)

scene : Model -> Html msg
scene model =
  case model.view of
    Menu -> renderMenu model
    -- Game -> renderWorld model
