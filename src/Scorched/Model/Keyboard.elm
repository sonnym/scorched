module Scorched.Model.Keyboard exposing (subscriptions, update)

import Browser.Events
import Json.Decode as Json

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  KeyMsg(..),
  View(..),
  Menu(..),
  Modal(..),
  Model)

import Scorched.Model.Control as Control
import Scorched.Model.Player as Player

import Scorched.Model.Helper as Helper

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
handleKeyDown ({controls, view, config} as model) key =
  if key == "ESCAPE" then
    case view of
      ModalView _ -> (model, Helper.send (BasicMsg_ (UpdateView (MenuView Main))))
      _ -> (model, Cmd.none)

  else if key == "ENTER" then
    case view of
      ModalView modal ->
        case modal of
          PlayerSelection playerColor -> Player.cycleSelection model playerColor
          _ -> (model, Cmd.none)

      _ -> (model, Cmd.none)

  else
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
toKeyDown key = KeyMsg_ (KeyDown (String.toUpper key))

toKeyUp : String -> Msg
toKeyUp key = KeyMsg_ (KeyUp (String.toUpper key))

toKeyPress : String -> Msg
toKeyPress key = KeyMsg_ (KeyPress (String.toUpper key))
