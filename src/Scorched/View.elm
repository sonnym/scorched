module Scorched.View exposing (..)

import Graphics.Element exposing (Element)

import Scorched.Model exposing (Model, View(..))

import Scorched.View.Menu exposing (renderMenu)
import Scorched.View.GamePlay exposing (renderWorld)

scene : Model -> Element
scene model =
  case model.view of
    Menu -> renderMenu model
    Game -> renderWorld model
