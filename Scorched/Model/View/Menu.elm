module Scorched.Model.View.Menu where

import Scorched.Action (Hook, Action(Start))

import Scorched.Model.Geometry (Dimension)

hooks : List Hook
hooks = [('S', Start)]

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
