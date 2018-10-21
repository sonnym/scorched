module Scorched.View.Menu exposing (..)

import Html exposing (Html, h1, text)
import Char exposing (toCode)

-- import Graphics.Element exposing (..)
-- import Graphics.Collage exposing (..)

import Scorched.State exposing (..)
import Scorched.Model exposing (Model)

import Scorched.Action exposing (Action(..), updates)
import Scorched.Model.Configuration exposing (Action(..))

import Scorched.Model.Geometry exposing (Dimension)

-- import Scorched.Model.GameState as GameState

import Scorched.Model.View.Menu exposing (hooks, worldDimensions)

-- import Scorched.View.Widget.BorderBox as BorderBox
-- import Scorched.View.Widget.Button as Button

-- import Scorched.View.Widget.NumericField as NumericField exposing (defaultSettings)

-- import Scorched.View.Helper.World as WorldHelper

renderMenu : Model -> Html msg
renderMenu ({dimensions} as model) = h1 [] [ text "" ]
{--
  collage
    dimensions.width
    dimensions.height
      [ BorderBox.build dimensions 2 False
      , sample model dimensions
      , buttons model dimensions
      ]

sample : Model -> Dimension -> Form
sample model {width,height} =
  let
    world = WorldHelper.toForm model.viewData.game.world worldDimensions
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
    { defaultSettings | value = value
    , text = "Players"
    , key = 'P'
    , messenger = (\value -> send updates (Configuration (PlayerCount value)))
    }

roundCount : Int -> Element
roundCount value =
  NumericField.build
    { defaultSettings | value = value
    , min = 5
    , max = 1000
    , step = 5
    , text = "Rounds"
    , key = 'R'
    , messenger = (\value -> send updates (Configuration (RoundCount value)))
    }
--}
