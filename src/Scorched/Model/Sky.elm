module Scorched.Model.Sky exposing (..)

import Array
import Random

import Maybe exposing (withDefault)
import Array exposing (Array, fromList, get, length)

-- import Scorched.Model.Sky.Sunset as SunsetModel
-- import Scorched.Model.Sky.Plain as PlainModel
import Scorched.Model.Sky.PitchBlack as PitchBlackModel

type Sky
  = PitchBlack PitchBlackModel.PitchBlack
  | Empty

type Msg
  = MenuSky Int

random : Cmd Msg
random =
  Random.generate MenuSky (Random.int 0 0)

getSky : Int -> Sky
getSky n =
  let
    types = Array.fromList [ PitchBlack 0 ]
  in
    case Array.get n types of
      Just (PitchBlack m) -> PitchBlack m
      Just Empty -> PitchBlack 0
      Nothing -> PitchBlack 0

empty : Sky
empty = Empty
