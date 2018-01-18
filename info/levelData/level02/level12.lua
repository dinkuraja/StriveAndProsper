
------------------------------------------------------------
-- NEVER TOUCH THIS ----------------------------------------
------------------------------------------------------------

local levelData = {}
local stars = {}
local orders = {}

------------------------------------------------------------
-- EDIT THIS DATA ------------------------------------------
------------------------------------------------------------

-- Star Information ---------------------------------------> Star Information:
-- 3 Scores: Positive Numbers

stars = {494,537,645}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- C = Coffee, S = Sketch, M = Mug, P = Phone Case, 
-- T = T-Shirt, J = Jeans, H = Hat
-- Colors: 1-6 (see refernce)
-- Stencils: A,B,C (a = Trap Lord, b = ASAP, c = Uptown )
-- Example: {'C','S','T1'}
-- Example: {'T2','T2A','J4C'}
-- IMPORTANT: Any clothing item MUST HAVE a color number, but does not need a stencil

orders[#orders+1] = { customer=04, order={'H2','S'}  }
orders[#orders+1] = { customer=06, order={'J4A','H1'}  }
orders[#orders+1] = { customer=01, order={'T3','C','T6C'}  }
orders[#orders+1] = { customer=02, order={'J5B','H2','S'}  }
orders[#orders+1] = { customer=07, order={'T2','T6'}  }
orders[#orders+1] = { customer=05, order={'J3','H2'}  }
orders[#orders+1] = { customer=09, order={'C','H4A'}  }
orders[#orders+1] = { customer=03, order={'T4','C'}  }
orders[#orders+1] = { customer=08, order={'H5','J2'}  }
orders[#orders+1] = { customer=06, order={'J3','C','T1'}  }
orders[#orders+1] = { customer=02, order={'C','J5A','H2'}  }
orders[#orders+1] = { customer=09, order={'S','C','T6'}  }
orders[#orders+1] = { customer=04, order={'J1C','S'}  }
orders[#orders+1] = { customer=07, order={'T2','T5'}  }
orders[#orders+1] = { customer=05, order={'S','H4B','C'}  }
orders[#orders+1] = { customer=01, order={'C','H2'}  }

------------------------------------------------------------
-- NEVER TOUCH THIS ----------------------------------------
------------------------------------------------------------

levelData['stars'] = stars
levelData['orders'] = orders

local Public = {}
Public.getData = function()

	return levelData
	
end 

return Public

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------