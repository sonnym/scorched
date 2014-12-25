module Scorched.View.Widget.BorderBox where

import List

import Graphics.Element (color, size, empty)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)

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
  group (highlights width height invert)

highlights : Float -> Float -> Bool -> List Form
highlights width height invert =
  let
    halfWidth = width / 2
    halfHeight = height /2
  in
    if invert then invertedLines halfWidth halfHeight else lines halfWidth halfHeight

lines : Float -> Float -> List Form
lines x y =
  [ filled shadowDark (rightLine x y)
  , filled highlightLight (leftLine x y)

  , filled shadowLight (bottomLine x y)
  , filled highlightDark (topLine x y)
  ]

invertedLines : Float -> Float -> List Form
invertedLines x y =
  [ filled shadowDark (leftLine x y)
  , filled highlightLight (rightLine x y)

  , filled shadowLight (topLine x y)
  , filled highlightDark (bottomLine x y)
  ]

leftLine : Float -> Float -> Shape
leftLine x y =
  polygon
    [ (-x, -y)
    , (-x + 2.0, -y)
    , (-x + 2.0, y)
    , (-x, y)
    ]

rightLine : Float -> Float -> Shape
rightLine x y =
  polygon
    [ (x - 3.0, -y)
    , (x, -y)
    , (x, y)
    , ((x - 3.0), y)
    ]

topLine : Float -> Float -> Shape
topLine x y =
  polygon
    [ (-x, y)
    , (-x + 2.0, y - 3.0)
    , (x - 3.0, y - 3.0)
    , (x, y)]

bottomLine : Float -> Float -> Shape
bottomLine x y =
  polygon
    [ (-x, -y)
    , (-x + 2.0, -y + 3.0)
    , (x - 3.0, -y + 3.0)
    , (x, -y)
    ]
