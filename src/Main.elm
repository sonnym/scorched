import Browser

import Scorched.Model.Types exposing (Model, Action)

import Scorched.Model as Model
import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = Model.update
    , subscriptions = subscriptions
    , view = View.build
    }

init : () -> (Model, Cmd Action)
init flags =
  ( Model.default
  , Model.init
  )

subscriptions : Model -> Sub Action
subscriptions model = Sub.none
