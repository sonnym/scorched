module Scorched.View.Helper.Terrain where

import List (indexedMap, maximum)

import Color (black)
import Graphics.Collage (Form, Path, groupTransform, traced, solid, moveX, rect)

import Transform2D (translation)

import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Terrain (Terrain)

toForm : Terrain -> Dimension -> Form
toForm terrain {width, height} =
  groupTransform
    (translation -(toFloat width / 2) 0.0)
    (drawTerrain terrain)

height : Terrain -> Int
height terrain = maximum terrain

drawTerrain : Terrain -> List Form
drawTerrain terrain = indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
