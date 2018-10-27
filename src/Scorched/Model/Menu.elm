module Scorched.Model.Menu exposing (..)

import Scorched.Action as Action exposing (Action(..))
import Scorched.View.Component.Button exposing (Button)

type alias MenuData = { buttons: List Button }

default : MenuData
default = { buttons = buttons }

buttons : List Button
buttons = [ Button "Start" 'S' {width=80, height=19} {x=13, y=12} False Action.NoOp ]

updateMenuData : MenuData -> String -> MenuData
updateMenuData menuData label = menuData
