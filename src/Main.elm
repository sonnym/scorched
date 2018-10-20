import Browser
import Html exposing (Html, h1, text)
-- import Graphics.Element exposing (Element)

import Scorched.Model as Model exposing (Model)
-- import Scorched.State as State
-- import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : () -> (Model, Cmd msg)
init flags =
  ( Model.default
  , Cmd.none
  )

update : msg -> Model -> (Model, Cmd msg)
update msg model =
  ( Model.default
  , Cmd.none
  )

subscriptions : Model -> Sub msg
subscriptions model = Sub.none

view : Model -> Html msg
view model = h1 [] [ text "" ]
