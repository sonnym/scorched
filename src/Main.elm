import Graphics.Element exposing (Element)

import Scorched.State as State
import Scorched.View as View

main : Signal Element
main = Signal.map View.scene State.state
