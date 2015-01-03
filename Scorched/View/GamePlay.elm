module Scorched.View.GamePlay where

import Graphics.Collage (collage)
import Graphics.Element (Element, empty)

import Scorched.Input (Input)
import Scorched.Model (Model)

import Scorched.View.Helper.World as WorldHelper

renderWorld : Model -> Input -> Element
renderWorld {viewData,dimensions} input =
  case viewData of
    Just data ->
      collage
        dimensions.width
        dimensions.height
        [WorldHelper.toForm data.game.world dimensions]

    Nothing -> empty
