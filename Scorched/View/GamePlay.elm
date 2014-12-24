module Scorched.View.GamePlay where

import List

import Color (..)
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model.World (..)
import Scorched.Model.Window (transformCoordinates)

renderWorld : World -> Dimension -> Element
renderWorld {terrain} ({width, height} as dimensions) =
  collage width height [placeWorld terrain dimensions]

placeWorld : Terrain -> Dimension -> Form
placeWorld terrain {width, height} =
  transformCoordinates
    (toFloat width)
    (toFloat -(height // 2))
    (group (drawTerrain terrain))

drawTerrain : Terrain -> List Form
drawTerrain terrain = List.indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
