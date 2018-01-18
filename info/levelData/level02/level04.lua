
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

stars = {197,206,216}

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
orders[#orders+1] = { customer=09, order={'T2'}  }
orders[#orders+1] = { customer=07, order={'J6','C'}  }
orders[#orders+1] = { customer=01, order={'T4'}  }
orders[#orders+1] = { customer=06, order={'J2','C'}  }
orders[#orders+1] = { customer=02, order={'C','J6A'}  }
orders[#orders+1] = { customer=05, order={'J1'}  }
orders[#orders+1] = { customer=03, order={'J3','C'}  }
orders[#orders+1] = { customer=04, order={'C','J4B'}  }
orders[#orders+1] = { customer=08, order={'J4','C'}  }
orders[#orders+1] = { customer=01, order={'C','T3C'}  }
orders[#orders+1] = { customer=06, order={'J1','C'}  }
orders[#orders+1] = { customer=03, order={'C'}  }

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