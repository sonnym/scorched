module Scorched.View.Widget.NumericField where

import Signal
import Text (fromString, leftAligned, monospace)

import Graphics.Collage (Form, collage, toForm, moveX, move)
import Graphics.Element (Element, widthOf)

import Graphics.Input (customButton)

import Scorched.Action (Action(NoOp), updates)

import Scorched.View.Widget.BorderTriangle as BorderTriangle

type alias Settings = {
  actionInc: Action,
  actionDec: Action,
  text: String
}

defaultSettings : Settings
defaultSettings =
  { actionInc = NoOp
  , actionDec = NoOp
  , text = "Number"
  }

build : Settings -> Element
build settings  =
  let
    labelElement = label settings.text
  in
    collage 100 30
      [ increment settings.actionInc |> moveX -45
      , decrement settings.actionDec |> move (-45, -10)
      , labelElement |> toForm |> move (-(toFloat (widthOf labelElement) / 2) + 25, -5)
      ]

increment : Action -> Form
increment action = button action BorderTriangle.Up

decrement : Action -> Form
decrement action = button action BorderTriangle.Down

button : Action -> BorderTriangle.Direction -> Form
button action direction =
  let
    btn = collage 15 15 [BorderTriangle.build 7 False direction]
    btnPressed = collage 15 15 [BorderTriangle.build 7 True direction]
  in
    toForm (customButton (Signal.send updates action) btn btn btnPressed)

label : String -> Element
label text =
  let
    formattedText = monospace (fromString (text ++ ":"))
  in
    leftAligned formattedText
