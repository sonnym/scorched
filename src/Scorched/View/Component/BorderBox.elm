module Scorched.View.Component.BorderBox exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Palette as Palette exposing(Color)

build : Dimension -> Int -> Bool -> Svg msg
build dimensions stroke invert =
  Svg.g [] (background dimensions :: border dimensions stroke invert)

background : Dimension -> Svg msg
background {width, height} =
  Svg.rect
    [ Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    , Attr.fill (Palette.toString Palette.background)
    ]
    []

border : Dimension -> Int -> Bool -> List (Svg msg)
border {width, height} stroke invert =
  let
    colors = if invert then invertedColors else regularColors
  in
    List.map2
      (<|)
      [ topLine width stroke
      , rightLine width height stroke
      , bottomLine height width stroke
      , leftLine height stroke
      ]
      colors

invertedColors : List Color
invertedColors =
  [ Palette.shadowLight, Palette.highlightLight, Palette.highlightDark, Palette.shadowDark ]

regularColors : List Color
regularColors =
  [ Palette.highlightDark, Palette.shadowDark, Palette.shadowLight, Palette.highlightLight ]

topLine : Int -> Int -> Color -> Svg msg
topLine width stroke color =
  Svg.line
    [ Attr.x1 "0"
    , Attr.x2 (String.fromInt width)
    , Attr.y1 "0"
    , Attr.y2 "0"
    , Attr.strokeWidth (String.fromInt stroke)
    , Attr.stroke (Palette.toString color)
    ]
    []

leftLine : Int -> Int -> Color -> Svg msg
leftLine height stroke color =
  Svg.line
    [ Attr.x1 "0"
    , Attr.x2 "0"
    , Attr.y1 "0"
    , Attr.y2 (String.fromInt height)
    , Attr.strokeWidth (String.fromInt stroke)
    , Attr.stroke (Palette.toString color)
    ]
    []

rightLine : Int -> Int -> Int -> Color -> Svg msg
rightLine offset height stroke color =
  let
    offsetAttr = String.fromInt (offset - stroke)
  in
    Svg.line
      [ Attr.x1 offsetAttr
      , Attr.x2 offsetAttr
      , Attr.y1 "0"
      , Attr.y2 (String.fromInt (height - 1))
      , Attr.strokeWidth (String.fromInt stroke)
      , Attr.stroke (Palette.toString color)
      ]
      []

bottomLine : Int -> Int -> Int -> Color -> Svg msg
bottomLine offset width stroke color =
  let
    offsetAttr = String.fromInt (offset - stroke)
  in
    Svg.line
      [ Attr.x1 "0"
      , Attr.x2 (String.fromInt (width - 1))
      , Attr.y1 offsetAttr
      , Attr.y2 offsetAttr
      , Attr.strokeWidth (String.fromInt stroke)
      , Attr.stroke (Palette.toString color)
      ]
      []
