module Scorched.View.Menu where

import Char (toCode)
import Signal (send)

import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model (Model, lookup)

import Scorched.Action (Action(Configuration), updates)
import Scorched.Model.Configuration (Action(PlayerCount, RoundCount))

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World as World

import Scorched.Model.View.Menu (hooks)

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.Button as Button

import Scorched.Model.View.NumericField (defaultSettings)
import Scorched.View.Widget.NumericField as NumericField

import Scorched.View.Helper.World as WorldHelper

renderMenu : Model -> Element
renderMenu ({dimensions} as model) =
  collage
    dimensions.width
    dimensions.height
      [ BorderBox.build dimensions 2 False
      , sample dimensions
      , buttons model dimensions
      ]

sample : Dimension -> Form
sample {width,height} =
  let
    innerDimensions = {width=906, height=724}

    world = WorldHelper.toForm (World.generate innerDimensions) innerDimensions
    outline = BorderBox.build {width=908, height=726} 1 True
  in
    group
      [ outline
         |> move (-(toFloat width) / 2 + 563, -(toFloat height) / 2 + 397)
      , world
         |> move (-(toFloat width) /2 + 563, -(toFloat height) / 2 + 397)
      ]

buttons : Model -> Dimension -> Form
buttons model {width, height} =
  let
    btns = [ playButton
           , (playerCount model.config.playerCount)
           , (roundCount model.config.roundCount)
           ]
    elem = flow down btns
  in
    toForm elem
      |> move
        ( toFloat (-(((width - (widthOf elem)) // 2)) + 15)
        , toFloat (((height - (heightOf elem)) // 2) - 15)
        )

playButton : Element
playButton = Button.build (lookup hooks (toCode 'S')) "Start" 'S' {width=90, height=25}

playerCount : Int -> Element
playerCount value =
  NumericField.build
    {defaultSettings | value <- value
                     , text <- "Players"
                     , key <- 'P'
                     , messenger <- (\value -> send updates (Configuration (PlayerCount value)))}

roundCount : Int -> Element
roundCount value =
  NumericField.build
    {defaultSettings | value <- value
                     , min <- 5
                     , max <- 1000
                     , step <- 5
                     , text <- "Rounds"
                     , key <- 'R'
                     , messenger <- (\value -> send updates (Configuration (RoundCount value)))}
