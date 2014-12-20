module Scorched.View.GamePlay where

import List

import Color (..)
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model.World (..)

renderWorld : World -> Dimension -> Element
renderWorld {terrain} {width, height} = collage width height (drawTerrain terrain)

drawTerrain : Terrain -> List Form
drawTerrain terrain = List.indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
