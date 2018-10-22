module Scorched.View.Menu exposing (..)

-- import Char exposing (toCode)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.State exposing (..)
import Scorched.Model exposing (Model)

import Scorched.Action as Action exposing (Action(..), updates)
import Scorched.Model.Configuration exposing (Action(..))

import Scorched.Model.Geometry exposing (Dimension)

-- import Scorched.Model.GameState as GameState

-- import Scorched.Model.View.Menu exposing (hooks, worldDimensions)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.Button as Button

-- import Scorched.View.Widget.NumericField as NumericField exposing (defaultSettings)

import Scorched.View.Helper.World as WorldHelper

renderMenu : Model -> Svg msg
renderMenu ({dimensions} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    ]
    [ BorderBox.build dimensions 2 False
    , buttons
    , sample model
    ]

sample : Model -> Svg msg
sample model =
  let
     world = WorldHelper.build model.viewData.game.world worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : Svg msg
buttons =
  playButton
  {--
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
  --}

playButton : Svg msg
playButton = Button.build Action.NoOp "Start" 'S' {width=80, height=19} {x=13, y=12}
-- playButton = Button.build (lookup hooks (toCode 'S')) "Start" 'S' {width=90, height=25}

{--

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

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
