module Scorched.View.GamePlay where

import Graphics.Collage (collage)
import Graphics.Element (Element, empty)

import Scorched.Model (Model)

import Scorched.View.Helper.World as WorldHelper

renderWorld : Model -> Element
renderWorld {viewData,dimensions} =
  collage
    dimensions.width
    dimensions.height
    [WorldHelper.toForm viewData.game.world dimensions]
