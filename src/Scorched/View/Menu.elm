module Scorched.View.Menu exposing (..)

-- import Char exposing (toCode)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.State exposing (..)
import Scorched.Model exposing (Model)

import Scorched.Action as Action exposing (Action(..))
-- import Scorched.Model.Configuration exposing (Action(..))

import Scorched.Model.Geometry exposing (Dimension, Offset)
import Scorched.Model.World exposing (World)

-- import Scorched.Model.GameState as GameState

-- import Scorched.Model.View.Menu exposing (hooks, worldDimensions)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.Button as Button

-- import Scorched.View.Widget.NumericField as NumericField exposing (defaultSettings)

import Scorched.View.World as WorldView

type alias Button =
  { label: String
  , key: Char
  , dimensions: Dimension
  , offset: Offset
  , inverted: Bool
  , action: Action
  }

render : Model -> Svg msg
render ({dimensions} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    ]
    (List.append (background model) buttons)

background : Model -> List (Svg msg)
background {dimensions, sampleWorld} =
  [ BorderBox.build dimensions 2 False, sample sampleWorld ]

sample : World -> Svg msg
sample sampleWorld =
  let
     world = WorldView.build sampleWorld worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : List (Svg msg)
buttons =
  List.map
    (\button -> Button.build button.action button.label button.key button.dimensions button.offset)
    buttonDefinitions

buttonDefinitions : List Button
buttonDefinitions = [ Button "Start" 'S' {width=80, height=19} {x=13, y=12} False Action.NoOp ]

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
