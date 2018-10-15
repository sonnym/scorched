module Scorched.Model.View.NumericField exposing (..)

import Signal exposing (Message, send)

import Scorched.Action exposing (Action(NoOp), Messenger, updates)

type Operation = Increment | Decrement

type alias Settings = {
  messenger: Messenger,
  text: String,
  key: Char,
  value: Int,
  min: Int,
  max: Int,
  step: Int
}

defaultSettings : Settings
defaultSettings =
  { messenger = (\v -> send updates NoOp)
  , text = "Number"
  , key = ' '
  , value = 2
  , min = 2
  , max = 10
  , step = 1
  }

message : Settings -> Messenger -> Operation -> Message
message settings messenger operation =
  messenger (guard settings operation)

guard : Settings -> Operation -> Int
guard {value,min,max,step} operation =
  let
    newVal = new operation value step
  in
    if | newVal > max -> min
       | newVal < min -> max
       | otherwise -> newVal

new : Operation -> Int -> Int -> Int
new operation current step =
  case operation of
    Increment -> current + step
    Decrement -> current - step
