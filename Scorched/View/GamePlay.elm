module Scorched.View.GamePlay where

import Graphics.Collage (collage)
import Graphics.Element (Element)

import Scorched.Input (Input)
import Scorched.Model (Model)

import Scorched.View.Helper.Terrain as TerrainHelper

renderWorld : Model -> Input -> Element
renderWorld {game,dimensions} input =
  collage
    dimensions.width
    dimensions.height
    [TerrainHelper.toForm game.world.terrain dimensions]
