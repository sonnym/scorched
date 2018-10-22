module Scorched.View.Component.BorderBox exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Palette as Palette

build : Int -> Int -> Int -> Bool -> Svg msg
build width height stroke invert =
  Svg.g [] (background width height :: border width height stroke)

background : Int -> Int -> Svg msg
background width height =
  Svg.rect
    [ Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    , Attr.fill (Palette.toString Palette.background)
    ]
    []

border : Int -> Int -> Int -> List (Svg msg)
border width height stroke =
  [ topLine width stroke
  , rightLine width height stroke
  , bottomLine height width stroke
  , leftLine height stroke
  ]

topLine : Int -> Int -> Svg msg
topLine width stroke =
  Svg.line
    [ Attr.x1 "0"
    , Attr.x2 (String.fromInt width)
    , Attr.y1 "0"
    , Attr.y2 "0"
    , Attr.strokeWidth (String.fromInt stroke)
    , Attr.stroke (Palette.toString Palette.highlightDark)
    ]
    []

leftLine : Int -> Int -> Svg msg
leftLine height stroke =
  Svg.line
    [ Attr.x1 "0"
    , Attr.x2 "0"
    , Attr.y1 "0"
    , Attr.y2 (String.fromInt height)
    , Attr.strokeWidth (String.fromInt stroke)
    , Attr.stroke (Palette.toString Palette.highlightLight)
    ]
    []

rightLine : Int -> Int -> Int -> Svg msg
rightLine offset height stroke =
  let
    offsetAttr = String.fromInt (offset - stroke)
  in
    Svg.line
      [ Attr.x1 offsetAttr
      , Attr.x2 offsetAttr
      , Attr.y1 "0"
      , Attr.y2 (String.fromInt (height - 1))
      , Attr.strokeWidth (String.fromInt stroke)
      , Attr.stroke (Palette.toString Palette.shadowDark)
      ]
      []

bottomLine : Int -> Int -> Int -> Svg msg
bottomLine offset width stroke =
  let
    offsetAttr = String.fromInt (offset - stroke)
  in
    Svg.line
      [ Attr.x1 "0"
      , Attr.x2 (String.fromInt (width - 1))
      , Attr.y1 offsetAttr
      , Attr.y2 offsetAttr
      , Attr.strokeWidth (String.fromInt stroke)
      , Attr.stroke (Palette.toString Palette.shadowLight)
      ]
      []
