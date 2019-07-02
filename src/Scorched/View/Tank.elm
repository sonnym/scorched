module Scorched.View.Tank exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Msg, Dimension, Player, PlayerColor(..))

import Scorched.View.Palette as Palette exposing (
  Color,
  redPlayer,
  greenPlayer,
  purplePlayer,
  yellowPlayer,
  aquaPlayer,
  fuchsiaPlayer,
  whitePlayer,
  orangePlayer,
  mintPlayer,
  bluePlayer)

build : Dimension -> Player -> Svg msg
build {height} ({position} as player) =
  Svg.circle
    [ Attr.cx (String.fromInt position.x)
    , Attr.cy (String.fromInt (height - position.y))
    , Attr.r "10"
    , Attr.fill (Palette.toString (color player))
    ] []

color : Player -> Color
color player =
  case player.color of
    Red -> redPlayer
    Green -> greenPlayer
    Purple -> purplePlayer
    Yellow -> yellowPlayer
    Aqua -> aquaPlayer
    Fuchsia -> fuchsiaPlayer
    White -> whitePlayer
    Orange -> orangePlayer
    Mint -> mintPlayer
    Blue -> bluePlayer
