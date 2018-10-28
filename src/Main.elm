import Browser

import Scorched.Model as Model exposing (Model)
import Scorched.Model.Action exposing (Action(..))

import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = Model.update
    , subscriptions = subscriptions
    , view = View.render
    }

init : () -> (Model, Cmd Action)
init flags =
  ( Model.default
  , Model.init
  )

subscriptions : Model -> Sub Action
subscriptions model = Sub.none
