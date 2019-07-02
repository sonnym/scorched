module Scorched.Model.Sky exposing (empty, default, all, generator, toString, fromString)

import Dict exposing (Dict)
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
fromString name =
  case Dict.get name mapping of
    Just sky -> sky
    Nothing -> empty

names : List String
names = ["Random", "Pitch Black", "Plain", "Sunset"]

mapping : Dict String Sky
mapping = Dict.fromList (List.map2 Tuple.pair names all)
