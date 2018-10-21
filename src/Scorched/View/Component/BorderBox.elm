module Scorched.View.Component.BorderBox exposing (..)

import Svg exposing(..)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)

-- import Scorched.View.Palette exposing (..)

build : Int -> Int -> Int -> Bool -> List (Svg msg) -> Svg msg
build width height stroke invert children =
  rect
    [ Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    , Attr.fill "rgb(182, 182, 182)"
    ]
    children

{--
  [ backdrop width height
  , border (toFloat width) (toFloat height) (toFloat stroke) invert
  ]

backdrop : Int -> Int -> Form
backdrop width height = toForm (color background (size width height empty))

border : Float -> Float -> Float -> Bool -> Form
border width height stroke invert =
  group (highlights width height stroke invert)

highlights : Float -> Float -> Float -> Bool -> List Form
highlights width height stroke invert =
  let
    halfWidth = width / 2
    halfHeight = height /2
  in
    if | invert -> invertedLines halfWidth halfHeight stroke
       | otherwise -> lines halfWidth halfHeight stroke

lines : Float -> Float -> Float -> List Form
lines x y stroke =
  [ filled shadowDark (rightLine x y stroke)
  , filled highlightLight (leftLine x y stroke)

  , filled shadowLight (bottomLine x y stroke)
  , filled highlightDark (topLine x y stroke)
  ]

invertedLines : Float -> Float -> Float -> List Form
invertedLines x y stroke =
  [ filled shadowDark (leftLine x y stroke)
  , filled highlightLight (rightLine x y stroke)

  , filled shadowLight (topLine x y stroke)
  , filled highlightDark (bottomLine x y stroke)
  ]

leftLine : Float -> Float -> Float -> Shape
leftLine x y stroke =
  polygon
    [ (-x, -y)
    , (-x + stroke, -y)
    , (-x + stroke, y)
    , (-x, y)
    ]

rightLine : Float -> Float -> Float -> Shape
rightLine x y stroke =
  polygon
    [ (x - stroke, -y)
    , (x, -y)
    , (x, y)
    , ((x - stroke), y)
    ]

topLine : Float -> Float -> Float -> Shape
topLine x y stroke =
  polygon
    [ (-x, y)
    , (-x + stroke, y - stroke)
    , (x - stroke, y - stroke)
    , (x, y)]

bottomLine : Float -> Float -> Float -> Shape
bottomLine x y stroke =
  polygon
    [ (-x, -y)
    , (-x + stroke, -y + stroke)
    , (x - stroke, -y + stroke)
    , (x, -y)
    ]
--}
