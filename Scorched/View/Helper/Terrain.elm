module Scorched.View.Helper.Terrain where

import List (indexedMap)

import Color (..)
import Graphics.Collage (..)
import Graphics.Element (Element)

import Scorched.Model.World (Dimension, Terrain)

toForm : Terrain -> Dimension -> Form
toForm terrain {width, height} =
  move
    ((toFloat -(width // 2)), (toFloat -(height // 2) + 300))
    (group (drawTerrain terrain))

drawTerrain : Terrain -> List Form
drawTerrain terrain = indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
