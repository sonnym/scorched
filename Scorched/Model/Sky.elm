module Scorched.Model.Sky where

import Color (Color)

import Random
import Random (Seed)

import Maybe (withDefault)
import Array (Array, fromList, get, length)

import Scorched.Model.Sky.Sunset as SunsetModel
import Scorched.Model.Sky.PitchBlack as PitchBlackModel

type SkyType
  = SunsetType
  | PitchBlackType

type Sky
  = Sunset SunsetModel.Sunset
  | PitchBlack PitchBlackModel.PitchBlack
  | Empty

generate : Seed -> Sky
generate seed =
  let
    (random, _) = Random.generate (Random.int 0 ((length types) - 1)) seed
    skyType = withDefault SunsetType (get random types)
  in
    case skyType of
      SunsetType -> Sunset (SunsetModel.generate)
      PitchBlackType -> PitchBlack (PitchBlackModel.generate)

types : Array SkyType
types =
  fromList [SunsetType, PitchBlackType]

empty : Sky
empty = Empty
