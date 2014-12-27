import Signal (Signal, map2)
import Graphics.Element (Element)

import Scorched.Input as Input
import Scorched.Model as Model
import Scorched.View as View

main : Signal Element
main = map2 View.scene Model.state Input.keypress
