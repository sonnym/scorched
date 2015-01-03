module Scorched.View.GamePlay where

import Graphics.Collage (collage)
import Graphics.Element (Element, empty)

import Scorched.Input (Input)
import Scorched.Model (Model)

import Scorched.View.Helper.Terrain as TerrainHelper

renderWorld : Model -> Input -> Element
renderWorld {viewData,dimensions} input =
  case viewData of
    Just data ->
      collage
        dimensions.width
        dimensions.height
        [TerrainHelper.toForm data.game.world.terrain dimensions]

    Nothing -> empty
