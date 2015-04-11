module Scorched.View.Widget.Button where

import Signal exposing (send)
import Text exposing (leftAligned, fromString, monospace)

import Graphics.Input exposing (customButton)

import Graphics.Collage exposing (..)
import Graphics.Element exposing (Element, size)

import Scorched.Action exposing (Action, updates)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.KeyedLabel as KeyedLabel

build : Action -> String -> Char -> Dimension -> Element
build action content key ({width, height} as dimensions) =
  let
    label = KeyedLabel.build content key
    positionedText = move (6, -3) (toForm (size width height label))

    btnUp = collage width height [BorderBox.build dimensions 2 False, positionedText]
    btnDown = collage width height [BorderBox.build dimensions 2 True, positionedText]
  in
    customButton (send updates action) btnUp btnUp btnDown
