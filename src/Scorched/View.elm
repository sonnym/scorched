module Scorched.View exposing (build)

import Html exposing (Html)

import Scorched.Model.Types exposing (Model, Msg, View(..))

import Scorched.View.MainMenu as MainMenu
import Scorched.View.SubMenu as SubMenu

build : Model -> Html Msg
build model =
  case model.view of
    MainMenu -> MainMenu.build model
    SubMenu _ -> SubMenu.build model
