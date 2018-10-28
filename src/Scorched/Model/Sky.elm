module Scorched.Model.Sky exposing (..)

import Array
import Random

import Scorched.Model.Types exposing (Action(..), Sky(..))

import Maybe exposing (withDefault)
import Array exposing (Array, fromList, get, length)

random : Cmd Action
random = Random.generate MenuSky (Random.map getSky (Random.int 0 2))

getSky : Int -> Sky
getSky n =
  let
    types = Array.fromList [ Plain, Sunset, PitchBlack ]
  in
    Maybe.withDefault PitchBlack (Array.get n types)

empty : Sky
empty = PitchBlack
