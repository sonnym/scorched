import Browser
import Html exposing (Html, h1, text)
-- import Graphics.Element exposing (Element)

-- import Scorched.State as State
-- import Scorched.View as View

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : () -> (Int, Cmd msg)
init flags =
  ( 1
  , Cmd.none
  )

update : msg -> Int -> (Int, Cmd msg)
update msg model =
  ( 1
  , Cmd.none
  )

subscriptions : Int -> Sub msg
subscriptions model = Sub.none

view : Int -> Html msg
view model = h1 [] [ text (String.fromInt model) ]
