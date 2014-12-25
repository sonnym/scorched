module Scorched.View.Widget.NumericField where

import Signal (Message, send)
import Text (fromString, leftAligned, monospace)

import Graphics.Collage (Form, collage, toForm, moveX, move)
import Graphics.Element (Element, widthOf)

import Graphics.Input (customButton)

import Scorched.Action (Action(NoOp), updates)

import Scorched.View.Widget.BorderTriangle as BorderTriangle

import Scorched.Action (PlayerCount)

type Operation = Increment | Decrement

type alias Settings = {
  messenger: (Int -> Message),
  text: String,
  value: Int,
  min: Int,
  max: Int,
  step: Int
}

defaultSettings : Settings
defaultSettings =
  { messenger = (\v -> send updates NoOp)
  , text = "Number"
  , value = 2
  , min = 2
  , max = 10
  , step = 1
  }

build : Settings -> Element
build settings =
  let
    labelElement = label settings.text settings.value
  in
    collage 100 30
      [ increment settings |> moveX -45
      , decrement settings |> move (-45, -10)
      , labelElement |> toForm |> move (-(toFloat (widthOf labelElement) / 2) + 35, -3)
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

label : String -> Int -> Element
label text value =
  let
    formattedText = monospace (fromString (text ++ ": " ++ (toString value)))
  in
    leftAligned formattedText

guard : Settings -> Operation -> Int
guard {value,min,max,step} operation =
  clamp min max (new operation value step)

new : Operation -> Int -> Int -> Int
new operation current step =
  case operation of
    Increment -> current + step
    Decrement -> current - step
