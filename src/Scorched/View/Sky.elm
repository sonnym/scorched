module Scorched.View.Sky exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Sky(..), Dimension)

import Scorched.View.Palette as Palette

build : Sky -> Dimension -> Svg msg
build sky dimensions =
  case sky of
    Plain -> buildPlain dimensions
    Sunset -> buildSunset dimensions
    PitchBlack -> buildPitchBlack dimensions
    Random -> Svg.g [] []

buildPlain : Dimension -> Svg msg
buildPlain {width, height} =
  Svg.rect
    [ Attr.id "sky-plain"
    , Attr.fill "rgb(36, 36, 125)"
    , Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    ]
    []

buildPitchBlack : Dimension -> Svg msg
buildPitchBlack {width, height} =
  Svg.rect
    [ Attr.id "sky-pitchblack"
    , Attr.fill "black"
    , Attr.x "0"
    , Attr.y "0"
    , Attr.width (String.fromInt width)
    , Attr.height (String.fromInt height)
    ]
    []

buildSunset : Dimension -> Svg msg
buildSunset dimensions =
  Svg.g
    [ Attr.id "sky-sunset" ]
    [ sunsetBands dimensions, sun dimensions ]

sunsetBands : Dimension -> Svg msg
sunsetBands {width, height} =
  let
    count = List.length Palette.sunset
    bandHeight = toFloat height / toFloat count
  in
    Svg.g
      [ Attr.id "sky-sunset-bands" ]
      (List.map2
        (\color offset ->
          Svg.rect
            [ Attr.fill (Palette.toString color)
            , Attr.x "0"
            , Attr.y (String.fromFloat (toFloat offset * bandHeight))
            , Attr.width (String.fromInt width)
            , Attr.height (String.fromFloat bandHeight)
            ]
            []
        ) Palette.sunset (List.range 0 (count - 1)))

sun : Dimension -> Svg msg
sun {width, height} =
  Svg.g
    [ Attr.id "sky-sunset-sun"
    , Attr.transform "translate(156, 414)"
    ]
    [ Svg.defs [] [
        Svg.clipPath
          [ Attr.id "truncate-sun" ]
          [ Svg.rect
            [ Attr.x "0"
            , Attr.y "0"
            , Attr.width "620"
            , Attr.height "310"
            ]
            []
          ]
      ]
    , Svg.circle
      [ Attr.r "310"
      , Attr.cx "310"
      , Attr.cy "310"
      , Attr.fill "rgb(255, 255, 0)"
      , Attr.clipPath "url(#truncate-sun)"
      ]
      []
    ]
