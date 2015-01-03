module Scorched.View where

import Graphics.Element (Element)

import Scorched.Model (Model, View(Menu, Game))

import Scorched.View.Menu (renderMenu)
import Scorched.View.GamePlay (renderWorld)

scene : Model -> Element
scene model =
  case model.view of
    Menu -> renderMenu model
    Game -> renderWorld model
