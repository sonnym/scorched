import Signal (Signal, map)
import Graphics.Element (Element)

import Scorched.View as View
import Scorched.Model as Model

main : Signal Element
main = map View.scene Model.state
