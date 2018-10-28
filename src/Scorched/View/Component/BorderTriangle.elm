module Scorched.View.Component.BorderTriangle exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.View.Palette as Palette

type Direction = Up | Down

build : Int -> Bool -> Direction -> Svg msg
build size invert direction = Svg.g [] []
{--
build size invert direction = group
  [ backdrop (toFloat size)
  , border (toFloat size) invert direction
  ]

backdrop : Float -> Form
backdrop size =
  filled background (ngon 3 size)

border : Float -> Bool -> Direction -> Form
border size invert direction =
  group (highlights size invert direction)

highlights : Float -> Bool -> Direction -> List Form
highlights size invert direction =
  List.map2
    traced
    (List.map solid (colors invert direction))
    (paths size direction)

colors : Bool -> Direction -> List Color
colors invert direction =
  case direction of
    Up ->
      if | invert -> [highlightLight, highlightDark, shadowDark]
         | otherwise -> [shadowDark, shadowLight, highlightLight]
    Down ->
      if | invert -> [shadowLight, highlightLight, shadowDark]
         | otherwise -> [highlightDark, shadowDark, highlightLight]

paths : Float -> Direction -> List Path
paths size direction =
  let
    vertices = points size direction

    first = List.head vertices
    rest = List.drop 1 vertices
  in
    List.map2 segment vertices (List.append rest [first])

points : Float -> Direction -> List (Float, Float)
points size direction =
  let
    half = size / 2
  in
    case direction of
      Up ->
        [(0, half), (half, -half), (-half, -half)]

      Down ->
        [(-half, half), (half, half), (0, -half)]
--}
