module Scorched.View.Menu where

import Signal (send)

import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Input (Input)

import Scorched.Model (Model)
import Scorched.Action (Action(PlayerCount), updates)

import Scorched.Model.World as World
import Scorched.Model.World (Dimension)

import Scorched.View.Helper.Terrain as TerrainHelper

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.Button as Button

import Scorched.View.Widget.NumericField (defaultSettings)
import Scorched.View.Widget.NumericField as NumericField

renderMenu : Model -> Input -> Element
renderMenu ({dimensions} as model) input =
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
    outline = BorderBox.build {width=908, height=726} 1 True

    terrain = TerrainHelper.toForm
      (World.generate {width=906, height=724}).terrain
      {width=906, height=724}
  in
    group
      [ outline
         |> move (-(toFloat width) / 2 + 563, -(toFloat height) / 2 + 397)
      , terrain
         |> move (-(toFloat width) / 2 + 563, -(toFloat height) / 2 + 397)
      ]

buttons : Model -> Dimension -> Form
buttons model {width, height} =
  let
    btns = [ playButton
           , (playerCount model.playerCount)
           , (roundCount model.roundCount)
           ]
    elem = flow down btns
  in
    toForm elem
      |> move
        ( toFloat (-(((width - (widthOf elem)) // 2)) + 15)
        , toFloat (((height - (heightOf elem)) // 2) - 15)
        )

playButton : Element
playButton = Button.build Start "Start" 'S' {width=90, height=25}

playerCount : Int -> Element
playerCount value =
  NumericField.build
    {defaultSettings | value <- value
                     , text <- "Players"
                     , key <- 'P'
                     , messenger <- (\value -> send updates (PlayerCount value))}

roundCount : Int -> Element
roundCount value =
  NumericField.build
    {defaultSettings | value <- value
                     , min <- 5
                     , max <- 1000
                     , step <- 5
                     , text <- "Rounds"
                     , key <- 'R'
                     , messenger <- (\value -> send updates (RoundCount value))}
