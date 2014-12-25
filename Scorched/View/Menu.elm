module Scorched.View.Menu where

import Signal (send)

import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model (Model)
import Scorched.Action (Action(PlayerCount), updates)

import Scorched.Model.World (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.Button as Button

import Scorched.View.Widget.NumericField (defaultSettings)
import Scorched.View.Widget.NumericField as NumericField

renderMenu : Model -> Dimension -> Element
renderMenu model ({width, height} as dimensions) =
  collage width height
    [ BorderBox.build dimensions False
    , buttons model dimensions
    ]

buttons : Model -> Dimension -> Form
buttons model {width, height} =
  let
    btns = [playButton, (playerCount model.playerCount)]
    elem = flow down btns
  in
    toForm elem
      |> move
        ( toFloat (-(((width - (widthOf elem)) // 2)) + 15)
        , toFloat (((height - (heightOf elem)) // 2) - 15)
        )

playButton : Element
playButton = Button.build Start "Start" {width=100, height=25}

playerCount : Int -> Element
playerCount value =
  NumericField.build
    {defaultSettings | value <- value
                     , text <- "Players"
                     , messenger <- (\value -> send updates (PlayerCount value))}
