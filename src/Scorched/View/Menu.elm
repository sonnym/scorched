module Scorched.View.Menu exposing (..)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Action as Action exposing (Action(..))

import Scorched.Model exposing (Model)
import Scorched.Model.Geometry exposing (Dimension, Offset)
import Scorched.Model.World exposing (World)

import Scorched.Model.Menu as Menu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.Button as Button exposing (Button)

import Scorched.View.World as WorldView

render : Model -> Svg Action
render ({dimensions, menuData} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    ]
    (List.append (background model) (buttons (Dict.values menuData.buttons)))

background : Model -> List (Svg Action)
background {dimensions, menuData} =
  [ BorderBox.build dimensions 2 False, sample menuData.world ]

sample : World -> Svg Action
sample sampleWorld =
  let
     world = WorldView.build sampleWorld worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : List Button -> List (Svg Action)
buttons definitions = List.map Button.build definitions

worldDimensions : Dimension
worldDimensions = {width=906, height=724}

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
