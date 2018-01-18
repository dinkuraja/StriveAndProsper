
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

stars = {312,327,370}

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

orders[#orders+1] = { customer=01, order={'H1','T6'}  }
orders[#orders+1] = { customer=03, order={'H2B','C'}  }
orders[#orders+1] = { customer=05, order={'C','J2'}  }
orders[#orders+1] = { customer=07, order={'T3'}  }
orders[#orders+1] = { customer=09, order={'H4','C'}  }
orders[#orders+1] = { customer=02, order={'T5'}  }
orders[#orders+1] = { customer=04, order={'C','J2A'}  }
orders[#orders+1] = { customer=06, order={'T4','C'}  }
orders[#orders+1] = { customer=08, order={'H6B','C'}  }
orders[#orders+1] = { customer=05, order={'H3','C'}  }
orders[#orders+1] = { customer=09, order={'C','J6'}  }
orders[#orders+1] = { customer=01, order={'T5','C'}  }
orders[#orders+1] = { customer=04, order={'H5','J1A'}  }
orders[#orders+1] = { customer=02, order={'J4','C'}  }

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