module Scorched.Model.Keyboard exposing (subscriptions, update)

import Browser.Events
import Json.Decode as Json

import Scorched.Model.Types exposing (Model, Msg(..), KeyMsg(..), View(..), Configuration, MainMenuData)

import Scorched.Model.Control as Control

import Scorched.Model.Menu as Menu
import Scorched.Model.Modal as Modal

subscriptions : List (Sub Msg)
subscriptions =
  [ Browser.Events.onKeyDown (Json.map toKeyDown keyDecoder)
  , Browser.Events.onKeyUp (Json.map toKeyUp keyDecoder)
  , Browser.Events.onKeyPress (Json.map toKeyPress keyDecoder)
  ]

update : KeyMsg -> Model -> (Model, Cmd Msg)
update msg ({view} as model) =
  case msg of
    KeyDown key -> handleKeyDown view model key
    KeyUp key -> handleKeyUp view model key
    KeyPress key -> handleKeyPress view model key

handleKeyDown : View -> Model -> String -> (Model, Cmd Msg)
handleKeyDown view model key =
  case view of
    MenuView menu -> Menu.handleKeyDown menu model key
    ModalView modal -> Modal.handleKeyDown modal model key

handleKeyUp : View -> Model -> String -> (Model, Cmd Msg)
handleKeyUp view model key =
  case view of
    MenuView menu -> Menu.handleKeyUp menu model key
    ModalView modal -> Modal.handleKeyUp modal model key

handleKeyPress : View -> Model -> String -> (Model, Cmd Msg)
handleKeyPress view model key =
  case view of
    MenuView menu -> Menu.handleKeyPress menu model key
    ModalView modal -> Modal.handleKeyPress modal model key

keyDecoder : Json.Decoder String
keyDecoder = Json.field "key" Json.string

toKeyDown : String -> Msg
toKeyDown key = KeyMsg_ (KeyDown key)

toKeyUp : String -> Msg
toKeyUp key = KeyMsg_ (KeyUp key)

toKeyPress : String -> Msg
toKeyPress key = KeyMsg_ (KeyPress key)
