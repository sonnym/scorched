module Scorched.View.Widget.NumericField where

import Signal (Message, send)
import Text (fromString, justified, monospace)

import Graphics.Collage (Form, collage, toForm, moveX, move)
import Graphics.Element (Element, widthOf)

import Graphics.Input (customButton)

import Scorched.Action (Action(NoOp), updates)

import Scorched.View.Widget.BorderTriangle as BorderTriangle
import Scorched.View.Widget.KeyedLabel as KeyedLabel

type Operation = Increment | Decrement

type alias Settings = {
  messenger: (Int -> Message),
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

build : Settings -> Element
build settings =
  let
    width = 100
    labelElement = label settings
  in
    collage width 30
      [ increment settings |> moveX -45
      , decrement settings |> move (-45, -10)
      , labelElement |> toForm |> move (-(toFloat (width - (widthOf labelElement)) / 2) + 14, -3)
      ]

increment : Settings -> Form
increment settings = button settings BorderTriangle.Up

decrement : Settings -> Form
decrement settings = button settings BorderTriangle.Down

button : Settings -> BorderTriangle.Direction -> Form
button ({value,messenger} as settings) direction =
  let
    btn = collage 15 15 [BorderTriangle.build 7 False direction]
    btnPressed = collage 15 15 [BorderTriangle.build 7 True direction]

    operation = if direction == BorderTriangle.Up then Increment else Decrement
  in
    toForm (customButton (messenger (guard settings operation)) btn btn btnPressed)

label : Settings -> Element
label {text,key,value} =
  KeyedLabel.build (text ++ ":" ++ (toString value)) key

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
