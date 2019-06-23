module Scorched.Model.Menu exposing (handleKeyDown, handleKeyUp, handleKeyPress)

import Scorched.Model.Types exposing (Model, Msg, Menu_(..))

import Scorched.Model.Menu.Main as MainMenu

handleKeyDown : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyDown menu model key = (model, Cmd.none)
      -- ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyUp : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyUp menu model key = (model, Cmd.none)
      -- ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyPress : Menu_ -> Model -> String -> (Model, Cmd Msg)
handleKeyPress menu model key = (model, Cmd.none)
      -- (model, handleKeyPress model.config key)

{--
handleKeyPress : Configuration -> String -> Cmd Msg
handleKeyPress configuration label =
  (Control.handleKeyPress defaultControls) configuration label

toggleControlByKey : MainMenuData -> String -> MainMenuData
toggleControlByKey menuData key =
  (Control.toggleControlByKey defaultControls) menuData key
--}
