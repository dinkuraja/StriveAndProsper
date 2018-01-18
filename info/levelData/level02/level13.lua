
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

stars = {515,560,672}

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

orders[#orders+1] = { customer=07, order={'S','J2'}  }
orders[#orders+1] = { customer=06, order={'C','H1C'}  }
orders[#orders+1] = { customer=05, order={'C','J5'}  }
orders[#orders+1] = { customer=08, order={'T6','H2A'}  }
orders[#orders+1] = { customer=09, order={'T2C','J6','S'}  }
orders[#orders+1] = { customer=01, order={'H1','J3'}  }
orders[#orders+1] = { customer=04, order={'C','H3','H4'}  }
orders[#orders+1] = { customer=03, order={'J2B','T5','S'}  }
orders[#orders+1] = { customer=02, order={'J1','J2C'}  }
orders[#orders+1] = { customer=08, order={'C','T3'}  }
orders[#orders+1] = { customer=06, order={'H1','J5','C'}  }
orders[#orders+1] = { customer=01, order={'S','C','T6'}  }
orders[#orders+1] = { customer=05, order={'S','J5'}  }
orders[#orders+1] = { customer=07, order={'H5C','C'}  }
orders[#orders+1] = { customer=04, order={'S','T4'}  }
orders[#orders+1] = { customer=09, order={'C','J5','J3B'}  }
orders[#orders+1] = { customer=08, order={'T2','J5'}  }

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