module Scorched.Model.Sky exposing (empty, random)

import Random

import Scorched.Model.Types exposing (Action(..), Sky(..))

import Maybe exposing (withDefault)
import Array exposing (Array, fromList, get, length)

random : Cmd Action
random = Random.generate MenuSky generator

generator : Random.Generator Sky
generator = Random.uniform empty [ PitchBlack, Plain, Sunset ]

empty : Sky
empty = PitchBlack
