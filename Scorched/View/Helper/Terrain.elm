module Scorched.View.Helper.Terrain where

import List (indexedMap, maximum)

import Color (..)

import Graphics.Collage (..)
import Graphics.Collage as Collage

import Graphics.Element as Element
import Graphics.Element (Element)

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
