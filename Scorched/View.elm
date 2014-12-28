module Scorched.View where

import Graphics.Element (Element)

import Scorched.Input (Input)

import Scorched.Model (Model, View(Menu, Game))

import Scorched.View.Menu (renderMenu)
import Scorched.View.GamePlay (renderWorld)

scene : Model -> Input -> Element
scene model input =
  case model.view of
    Menu -> renderMenu model input
    Game -> renderWorld model input
