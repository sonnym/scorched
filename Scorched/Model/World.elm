module Scorched.Model.World where

import List
import Color (rgb)

import Graphics.Collage (Form, toForm)
import Graphics.Element (flow, down, empty, size, color)

import Scorched.View.Palette (gradient)

type alias Dimension = {width:Int, height:Int}

type alias Sky = Form
type alias Terrain = List Int

type alias World = {
  terrain: Terrain,
  sky: Sky
}

generate : Dimension -> World
generate ({width, height} as dimensions) = {
  terrain = (List.repeat width (height // 2)),
  sky = generateSky dimensions}

generateSky : Dimension -> Form
generateSky {width, height} =
  let
    steps = 28
    bandHeight = ceiling ((toFloat height) / (toFloat steps))
    bands = gradient (rgb 52 52 150) (rgb 255 235 4) steps
  in
    toForm (flow down
      (List.map (\band -> color band (size width bandHeight empty)) bands))
