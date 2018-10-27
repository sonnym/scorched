module Scorched.Model.Menu exposing (..)

import Dict exposing (Dict)

import Scorched.Action as Action exposing (Action(..))
import Scorched.View.Component.Button exposing (Button)

type alias MenuData = { buttons: Dict String Button }

default : MenuData
default = { buttons = defaultButtons }

defaultButtons : Dict String Button
defaultButtons =
  Dict.fromList
    (List.map
      (\button -> (button.label, button))
      [ Button "Start" 'S' {width=80, height=19} {x=13, y=12} False Action.NoOp ]
    )

updateMenuData : MenuData -> String -> MenuData
updateMenuData menuData label =
  { menuData | buttons = updateButtons menuData.buttons label }

updateButtons : Dict String Button -> String -> Dict String Button
updateButtons buttons label = Dict.update label updateButton buttons

updateButton : Maybe Button -> Maybe Button
updateButton maybeButton =
  case maybeButton of
    Just button -> Just { button | inverted = not button.inverted }
    Nothing -> Nothing
