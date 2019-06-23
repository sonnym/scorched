module Scorched.Model.Menu exposing (handleKeyDown, handleKeyUp, handleKeyPress)

import Scorched.Model.Types exposing (Model, Msg, Menu_(..), Configuration, MainMenuData)

import Scorched.Model.Control as Control
import Scorched.Model.Menu.Main as MainMenu

handleKeyDown : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyDown menu model key =
  case menu of
    Main -> ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyUp : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyUp menu model key =
  case menu of
    Main -> ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyPress : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyPress menu ({config} as model) key =
  case menu of
    Main -> (model, (Control.handleKeyPress MainMenu.default.controls) config key)

toggleControlByKey : MainMenuData -> String -> MainMenuData
toggleControlByKey menuData key =
  (Control.toggleControlByKey MainMenu.default.controls) menuData key
