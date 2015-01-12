module Scorched.View.Helper.Terrain where

import List (indexedMap, maximum)

import Color (rgb)
import Graphics.Collage (Form, Path, groupTransform, traced, solid, move, rect)

import Transform2D (translation)

import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Terrain (Terrain)

toForm : Terrain -> Dimension -> Form
toForm terrain {width, height} =
  groupTransform
    (translation -(toFloat width / 2) 0.0)
    (drawTerrain terrain)

maxHeight : Terrain -> Int
maxHeight terrain = maximum terrain

drawTerrain : Terrain -> List Form
drawTerrain terrain =
  let
    max = maxHeight terrain
  in
    indexedMap (drawLine max) terrain

drawLine : Int -> Int -> Int -> Form
drawLine max x height =
  terrainLine height
    |> traced (solid (rgb 154 101 69))
    |> move (toFloat x, -(toFloat (max - height)) / 2)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
