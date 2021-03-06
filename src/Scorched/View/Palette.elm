module Scorched.View.Palette exposing (..)

import String exposing (fromInt)

type alias Color = { r: Int , g: Int , b: Int }

background : Color
background = { r = 182, g = 182, b = 182 }

toString : Color -> String
toString {r, g, b} =
  "rgb(" ++ fromInt r ++ ", " ++ fromInt g ++ ", " ++ fromInt b ++ ")"

shadowDark : Color
shadowDark = { r = 20, g = 20, b = 20 }

shadowLight : Color
shadowLight = { r = 60, g = 60, b = 60 }

highlightDark : Color
highlightDark = { r = 223, g = 223, b = 223 }

highlightLight : Color
highlightLight = { r = 255, g = 255, b = 255 }

sunset : List Color
sunset =
  [ { r = 52, g = 52, b = 150 }
  , { r = 60, g = 60, b = 162 }
  , { r = 69, g = 69, b = 174 }
  , { r = 77, g = 77, b = 190 }
  , { r = 85, g = 85, b = 203 }
  , { r = 89, g = 89, b = 215 }
  , { r = 101, g = 101, b = 227 }
  , { r = 109, g = 109, b = 239 }
  , { r = 117, g = 117, b = 255 }
  , { r = 130, g = 117, b = 235 }
  , { r = 142, g = 109, b = 219 }
  , { r = 158, g = 105, b = 203 }
  , { r = 170, g = 101, b = 182 }
  , { r = 199, g = 93, b = 150 }
  , { r = 255, g = 81, b = 81 }
  , { r = 251, g = 130, b = 56 }
  , { r = 255, g = 150, b = 48 }
  , { r = 255, g = 166, b = 40 }
  , { r = 255, g = 182, b = 32 }
  , { r = 255, g = 203, b = 24 }
  ]

cyan : Color
cyan = { r = 40, g = 255, b = 255 }

shadows : List Color
shadows =
  [ { r = 13, g = 13, b = 37 }
  , { r = 15, g = 15, b = 15 }
  , { r = 45, g = 45, b = 45 }
  , { r = 75, g = 75, b = 75 }
  , { r = 106, g = 106, b = 106 }
  , { r = 136, g = 136, b = 136 }
  , { r = 167, g = 167, b = 167 }
  , { r = 200, g = 200, b = 200 }
  , { r = 255, g = 255, b = 255 }
  ]

redPlayer : Color
redPlayer = { r = 255, g = 40, b = 40 }

greenPlayer : Color
greenPlayer = { r = 142, g = 223, b = 40 }

purplePlayer : Color
purplePlayer = { r = 162, g = 81, b = 255 }

yellowPlayer : Color
yellowPlayer = { r = 255, g = 255, b = 40 }

aquaPlayer : Color
aquaPlayer = { r = 40, g = 255, b = 255 }

fuchsiaPlayer : Color
fuchsiaPlayer = { r = 255, g = 40, b = 255 }

whitePlayer : Color
whitePlayer = { r = 243, g = 243, b = 243 }

orangePlayer : Color
orangePlayer = { r = 255, g = 162, b = 81 }

mintPlayer : Color
mintPlayer = { r = 81, g = 255, b = 162 }

bluePlayer : Color
bluePlayer = { r = 0, g = 0, b = 255 }
