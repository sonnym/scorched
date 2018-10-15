module Scorched.View.Helper.Terrain where

import Color exposing (rgb)
import Graphics.Collage exposing (Form, Path, groupTransform, traced, solid, move, rect)

import Transform2D exposing (translation)

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Terrain exposing (Terrain)

toForm : Terrain -> Dimension -> Form
toForm terrain {width, height} =
  groupTransform
    (translation -(toFloat width / 2) 0.0)
    (drawTerrain terrain)

maxHeight : Terrain -> Int
maxHeight terrain = List.maximum terrain

drawTerrain : Terrain -> List Form
drawTerrain terrain =
  let
    max = maxHeight terrain
  in
    List.indexedMap (drawLine max) terrain

drawLine : Int -> Int -> Int -> Form
drawLine max x height =
  terrainLine height
    |> traced (solid (rgb 154 101 69))
    |> move (toFloat x, -(toFloat (max - height)) / 2)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)
