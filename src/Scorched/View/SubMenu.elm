module Scorched.View.SubMenu exposing (build)

import Svg exposing (Svg)

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.View.MainMenu as MainMenu

build : Model -> Svg Msg
build model = MainMenu.build model
