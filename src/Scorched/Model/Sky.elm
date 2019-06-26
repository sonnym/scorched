module Scorched.Model.Sky exposing (empty, default, all, generator, toString, fromString)

import Random

import Scorched.Model.Types exposing (Sky(..))

empty : Sky
empty = PitchBlack

default : Sky
default = Random

all : List Sky
all = [ Random, PitchBlack, Plain, Sunset ]

generator : Random.Generator Sky
generator = Random.uniform empty all

toString : Sky -> String
toString sky =
  case sky of
    Random -> "Random"
    PitchBlack -> "Pitch Black"
    Plain -> "Plain"
    Sunset -> "Sunset"

fromString : String -> Sky
fromString sky =
  case sky of
    "Random" -> Random
    "Pitch Black" -> PitchBlack
    "Plain" -> Plain
    "Sunset" -> Sunset
    _ -> empty
