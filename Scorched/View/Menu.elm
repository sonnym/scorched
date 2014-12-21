module Scorched.View.Menu where

import Signal

import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)
import Scorched.Model.Window (transformCoordinates)

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.Button as Button

renderMenu : Dimension -> Element
renderMenu ({width, height} as dimensions) =
  collage width height
    [ BorderBox.build dimensions False
    , buttons dimensions
    ]

buttons : Dimension -> Form
buttons {width, height} =
  let
    elem = flow down [playButton]
  in
    toForm elem
      |> transformCoordinates (toFloat (width - (widthOf elem))) (toFloat (height - (heightOf elem)))
      |> move (10, -10)

playChannel : Signal.Channel ()
playChannel = Signal.channel ()

playButton : Element
playButton = Button.build playChannel "Play" {width=100, height=25}
