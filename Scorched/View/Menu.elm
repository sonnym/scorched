module Scorched.View.Menu where

import Signal

import Graphics.Element (..)

import Scorched.Model.World (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox
import Scorched.View.Widget.Button as Button

renderMenu : Dimension -> Element
renderMenu dimensions = layers
  [ BorderBox.build dimensions
  , buttons
  ]

buttons : Element
buttons = flow down [(spacer 10 10), playButton]

playChannel : Signal.Channel ()
playChannel = Signal.channel ()

playButton : Element
playButton = Button.build playChannel "Play" {width=100, height=25}
