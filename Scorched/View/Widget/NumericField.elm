module Scorched.View.Widget.NumericField where

import Text (fromString, justified, monospace)

import Graphics.Collage (Form, collage, toForm, moveX, move)
import Graphics.Element (Element, widthOf)

import Graphics.Input (customButton)

import Scorched.Model.View.NumericField (..)

import Scorched.View.Widget.BorderTriangle as BorderTriangle
import Scorched.View.Widget.KeyedLabel as KeyedLabel

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
button ({messenger} as settings) direction =
  let
    btn = collage 15 15 [BorderTriangle.build 7 False direction]
    btnPressed = collage 15 15 [BorderTriangle.build 7 True direction]

    operation = if direction == BorderTriangle.Up then Increment else Decrement
  in
    toForm (customButton (message settings messenger operation) btn btn btnPressed)

label : Settings -> Element
label {text,key,value} =
  KeyedLabel.build (text ++ ":" ++ (toString value)) key
