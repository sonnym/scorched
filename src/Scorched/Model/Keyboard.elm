module Scorched.Model.Keyboard exposing (subscriptions, update)

import Browser.Events
import Json.Decode as Json

import Scorched.Model.Types exposing (Model, Msg(..), KeyMsg(..))

import Scorched.Model.Control as Control

subscriptions : List (Sub Msg)
subscriptions =
  [ Browser.Events.onKeyDown (Json.map toKeyDown keyDecoder)
  , Browser.Events.onKeyUp (Json.map toKeyUp keyDecoder)
  , Browser.Events.onKeyPress (Json.map toKeyPress keyDecoder)
  ]

update : KeyMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    KeyDown key -> handleKeyDown model key
    KeyUp key -> handleKeyUp model key
    KeyPress key -> handleKeyPress model key

handleKeyDown : Model -> String -> (Model, Cmd Msg)
handleKeyDown ({controls, config} as model) key =
    ({ model | controls = Control.toggleControlByKey controls key }, Cmd.none)

handleKeyUp : Model -> String -> (Model, Cmd Msg)
handleKeyUp ({controls, config} as model) key =
    ({ model | controls = Control.toggleControlByKey controls key }, Cmd.none)

handleKeyPress : Model -> String -> (Model, Cmd Msg)
handleKeyPress ({config, controls} as model) key =
  (model, (Control.handleKeyPress controls) config key)

keyDecoder : Json.Decoder String
keyDecoder = Json.field "key" Json.string

toKeyDown : String -> Msg
toKeyDown key = KeyMsg_ (KeyDown key)

toKeyUp : String -> Msg
toKeyUp key = KeyMsg_ (KeyUp key)

toKeyPress : String -> Msg
toKeyPress key = KeyMsg_ (KeyPress key)
