import Signal (Signal, map)
import Graphics.Element (Element)

import Scorched.State as State
import Scorched.View as View

main : Signal Element
main = map View.scene State.state
