module Scorched.View.Menu where

import List
import Signal

import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Action as Action

import Scorched.Model.World (Dimension)

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
      |> move
        ( toFloat (-(((width - (widthOf elem)) // 2)) + 15)
        , toFloat (((height - (heightOf elem)) // 2) - 15)
        )

playButton : Element
playButton = Button.build Action.Start "Start" {width=100, height=25}
