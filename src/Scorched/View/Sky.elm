module Scorched.View.Sky exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Sky exposing (Sky(..))

build : Sky -> Dimension -> Svg msg
build sky dimensions =
  case sky of
    Plain -> buildPlain dimensions
    Sunset -> buildSunset dimensions
    PitchBlack -> buildPitchBlack dimensions

buildPlain : Dimension -> Svg msg
buildPlain {width, height} =
  Svg.rect
    [ Attr.fill "rgb(36, 36, 125)"
    , Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    ]
    []

buildPitchBlack : Dimension -> Svg msg
buildPitchBlack {width, height} =
  Svg.rect
    [ Attr.fill "black"
    , Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    ]
    []

buildSunset : Dimension -> Svg msg
buildSunset {width, height} =
  Svg.rect [] []
  {--
  gradient (rgb 51 52 150) (rgb 255 235 4) 28

  let
    bandHeight = (toFloat height) / (toFloat (List.length sky))
    translationY = ((toFloat height) - bandHeight) / 2.0
  in
    groupTransform
      (translation 0.0 translationY)
      (List.indexedMap (\i color ->
        rect (toFloat width) bandHeight
          |> filled color
          |> moveY -(bandHeight * (toFloat i))) sky)
--}
