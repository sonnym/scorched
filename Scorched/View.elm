module Scorched.View where

import Graphics.Element exposing (Element)

import Scorched.Model exposing (Model, View(Menu, Game))

import Scorched.View.Menu exposing (renderMenu)
import Scorched.View.GamePlay exposing (renderWorld)

scene : Model -> Element
scene model =
  case model.view of
    Menu -> renderMenu model
    Game -> renderWorld model
