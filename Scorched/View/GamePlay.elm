module Scorched.View.GamePlay where

import List

import Color (..)
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model (Model)
import Scorched.Model.World (..)

renderWorld : Model -> Dimension -> Element
renderWorld {game} ({width, height} as dimensions) =
  collage width height [placeWorld game.world.terrain dimensions]

placeWorld : Terrain -> Dimension -> Form
placeWorld terrain {width, height} =
  move
    ((toFloat -(width // 2)), (toFloat -(height // 2) + 300))
    (group (drawTerrain terrain))

drawTerrain : Terrain -> List Form
drawTerrain terrain = List.indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
