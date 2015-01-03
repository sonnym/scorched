import Signal (Signal, map)
import Graphics.Element (Element)

import Scorched.Model as Model
import Scorched.View as View

main : Signal Element
main = map View.scene Model.state
