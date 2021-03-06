module Scorched exposing (main)

import Browser

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.Model as Model
import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = Model.update
    , subscriptions = Model.subscriptions
    , view = View.build
    }

init : () -> (Model, Cmd Msg)
init flags =
  ( Model.default
  , Model.init
  )
