module Scorched.View.Widget.BorderBox where

import List
import List ((::))

import Color
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)

backgroundColor = Color.rgb 182 182 182

shadowColorDark = Color.rgb 0 0 0
shadowColorLight = Color.rgb 60 60 60

highlightColorDark = Color.rgb 223 223 223
highlightColorLight = Color.rgb 255 255 255

build : Dimension -> Element
build {width, height} =
  layers
    [ color backgroundColor (size width height empty)
    , collage width height (highlights (toFloat width) (toFloat height))
    ]

highlights : Float -> Float -> List Form
highlights width height =
  List.map (\form -> move (-(width / 2), -(height / 2) + 1.0) form)
    [ filled shadowColorDark (polygon [(width - 3.0, 0.0), (width, 0.0), (width, height), ((width - 3.0), height)])
    , filled highlightColorLight (polygon [(0.0, 0.0), (2.0, 0.0), (2.0, height), (0.0, height)])

    , filled shadowColorLight (polygon [(0.0, 0.0), (2.0, 2.0), (width - 3.0, 2.0), (width, 0.0)])
    , filled highlightColorDark (polygon [(0.0, height - 1.0), (2.0, height - 3.0), (width - 3.0, height - 3.0), (width, height)])
    ]
