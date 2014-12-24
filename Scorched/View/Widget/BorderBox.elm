module Scorched.View.Widget.BorderBox where

import List

import Graphics.Element (color, size, empty)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)
import Scorched.Model.Window (transformCoordinates)

import Scorched.View.Palette (..)

build : Dimension -> Bool -> Form
build {width, height} invert = group
  [ backdrop width height
  , border (toFloat width) (toFloat height) invert
  ]

backdrop : Int -> Int -> Form
backdrop width height = toForm (color background (size width height empty))

border : Float -> Float -> Bool -> Form
border width height invert =
  (group >> (transformCoordinates width -height))
    (highlights width height invert)

highlights : Float -> Float -> Bool -> List Form
highlights width height invert =
  if invert then invertedLines width height else lines width height

lines : Float -> Float -> List Form
lines width height =
  [ filled shadowDark (leftLine width height)
  , filled highlightLight (rightLine width height)

  , filled shadowLight (bottomLine width height)
  , filled highlightDark (topLine width height)
  ]

invertedLines : Float -> Float -> List Form
invertedLines width height =
  [ filled shadowDark (rightLine width height)
  , filled highlightLight (leftLine width height)

  , filled shadowLight (topLine width height)
  , filled highlightDark (bottomLine width height)
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
