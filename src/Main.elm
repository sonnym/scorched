import Browser
-- import Graphics.Element exposing (Element)

import Scorched.Model as Model exposing (Model)
import Scorched.Model.Sky as Sky
-- import Scorched.State as State
import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = Model.update
    , subscriptions = subscriptions
    , view = View.scene
    }

init : () -> (Model, Cmd Sky.Msg)
init flags =
  ( Model.default
  , Model.init
  )

subscriptions : Model -> Sub msg
subscriptions model = Sub.none
