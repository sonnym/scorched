module Scorched.View.Component.NumericField exposing (NumericField, build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Action exposing (Action)
import Scorched.Model.Geometry exposing (Offset)

import Scorched.View.Helper as Helper

import Scorched.View.Component.BorderTriangle as BorderTriangle exposing (Direction(..))
import Scorched.View.Component.KeyedLabel as KeyedLabel

type alias NumericField =
  { label: String
  , key: Char
  , offset: Offset
  }

build : NumericField -> Svg Action
build {label, key, offset} =
  Svg.g
    [ Attr.transform (Helper.translate offset)
    , Attr.fontWeight "600"
    , Attr.letterSpacing "-1px"
    ]
    [ BorderTriangle.build False BorderTriangle.Up {x=0, y=0}
    , BorderTriangle.build False BorderTriangle.Down {x=0, y=12}
    , Svg.text_ [ Attr.x "17", Attr.y "13" ] (KeyedLabel.build label key)
    ]
