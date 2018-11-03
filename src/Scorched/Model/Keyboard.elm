module Scorched.Model.Keyboard exposing (subscriptions)

import Browser.Events
import Json.Decode as Json

import Scorched.Model.Types exposing (Model, Msg(..))

subscriptions : List (Sub Msg)
subscriptions = [Sub.none]
{--
  [ Browser.Events.onKeyDown (Json.map toKeyDown keyDecoder)
  , Browser.Events.onKeyUp (Json.map toKeyUp keyDecoder)
  , Browser.Events.onKeyPress (Json.map toKeyPress keyDecoder)
  ]

keyDecoder : Json.Decoder String
keyDecoder = Json.field "key" Json.string

toKeyDown : String -> Msg
toKeyDown key = KeyDown key

toKeyUp : String -> Msg
toKeyUp key = KeyUp key

toKeyPress : String -> Msg
toKeyPress key = KeyPress key
--}
