module Scorched.View.Sky exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Sky exposing (Sky(..))

-- import Scorched.View.Helper.Sky.Sunset as SunsetHelper
-- import Scorched.View.Helper.Sky.Plain as PlainHelper

build : Sky -> Dimension -> Svg msg
build sky dimensions =
  case sky of
    -- Sunset sunset -> SunsetHelper.toForm sunset dimensions
    -- Plain pitchblack -> PlainHelper.toForm pitchblack dimensions
    PitchBlack pitchblack -> buildPitchBlack dimensions

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
