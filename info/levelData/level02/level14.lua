
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

stars = {538,585,702}

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

orders[#orders+1] = { customer=07, order={'H6C','J2','S'}  }
orders[#orders+1] = { customer=03, order={'T5A','C'}  }
orders[#orders+1] = { customer=05, order={'J5','S'}  }
orders[#orders+1] = { customer=01, order={'H2B','C'}  }
orders[#orders+1] = { customer=02, order={'S','T4','J1'}  }
orders[#orders+1] = { customer=04, order={'J3','T5'}  }
orders[#orders+1] = { customer=09, order={'H3','H6B'}  }
orders[#orders+1] = { customer=08, order={'J2','T5','S'}  }
orders[#orders+1] = { customer=06, order={'J1','H5'}  }
orders[#orders+1] = { customer=05, order={'J2C','S','C'}  }
orders[#orders+1] = { customer=04, order={'C','T3A','H3'}  }
orders[#orders+1] = { customer=07, order={'T6','J5','C'}  }
orders[#orders+1] = { customer=09, order={'S','J2'}  }
orders[#orders+1] = { customer=03, order={'H1','C'}  }
orders[#orders+1] = { customer=02, order={'H2A','C'}  }
orders[#orders+1] = { customer=01, order={'C','J2B'}  }
orders[#orders+1] = { customer=08, order={'C','H2','S'}  }

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