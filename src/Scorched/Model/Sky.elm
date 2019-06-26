module Scorched.Model.Sky exposing (empty, default, all, generator, toString, fromString)

import Random

import Scorched.Model.Types exposing (Config, Sky(..))

empty : Sky
empty = PitchBlack

default : Sky
default = Random

all : List Sky
all = Random :: exceptRandom

generator : Config -> Random.Generator Sky
generator config =
  case config.worldConfig.sky of
    Random -> Random.uniform empty exceptRandom
    _ -> Random.constant config.worldConfig.sky

exceptRandom : List Sky
exceptRandom = [ PitchBlack, Plain, Sunset ]

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
