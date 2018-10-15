module Scorched.View.GamePlay exposing (..)

import Graphics.Collage exposing (collage)
import Graphics.Element exposing (Element, empty)

import Scorched.Model exposing (Model)

import Scorched.View.Helper.World as WorldHelper

renderWorld : Model -> Element
renderWorld {viewData,dimensions} =
  collage
    dimensions.width
    dimensions.height
    [WorldHelper.toForm viewData.game.world dimensions]
