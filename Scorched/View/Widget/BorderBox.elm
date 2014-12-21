module Scorched.View.Widget.BorderBox where

import List

import Color
import Graphics.Element (color, size, empty)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)
import Scorched.Model.Window (transformCoordinates)

backgroundColor = Color.rgb 182 182 182

shadowColorDark = Color.rgb 0 0 0
shadowColorLight = Color.rgb 60 60 60

highlightColorDark = Color.rgb 223 223 223
highlightColorLight = Color.rgb 255 255 255

build : Dimension -> Bool -> Form
build {width, height} invert = group
  [ background width height
  , border (toFloat width) (toFloat height) invert
  ]

background : Int -> Int -> Form
background width height = toForm (color backgroundColor (size width height empty))

border : Float -> Float -> Bool -> Form
border width height invert =
  (group >> (transformCoordinates width -height))
    (highlights width height invert)

highlights : Float -> Float -> Bool -> List Form
highlights width height invert =
  if invert then invertedLines width height else lines width height

lines : Float -> Float -> List Form
lines width height =
  [ filled shadowColorDark (leftLine width height)
  , filled highlightColorLight (rightLine width height)

  , filled shadowColorLight (bottomLine width height)
  , filled highlightColorDark (topLine width height)
  ]

invertedLines : Float -> Float -> List Form
invertedLines width height =
  [ filled shadowColorDark (rightLine width height)
  , filled highlightColorLight (leftLine width height)

  , filled shadowColorLight (topLine width height)
  , filled highlightColorDark (bottomLine width height)
  ]

leftLine : Float -> Float -> Shape
leftLine width height =
  polygon [(width - 3.0, 0.0), (width, 0.0), (width, height), ((width - 3.0), height)]

rightLine : Float -> Float -> Shape
rightLine width height =
  polygon [(0.0, 0.0), (2.0, 0.0), (2.0, height), (0.0, height)]

bottomLine : Float -> Float -> Shape
bottomLine width height =
  polygon [(0.0, 0.0), (2.0, 2.0), (width - 3.0, 2.0), (width, 0.0)]

topLine : Float -> Float -> Shape
topLine width height =
  polygon [(0.0, height - 1.0), (2.0, height - 3.0), (width - 3.0, height - 3.0), (width, height)]
