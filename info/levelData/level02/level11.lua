
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

stars = {466,507,609}

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

orders[#orders+1] = { customer=03, order={'T5','S'}  }
orders[#orders+1] = { customer=01, order={'T2B','J5'}  }
orders[#orders+1] = { customer=02, order={'H4','C','H1'}  }
orders[#orders+1] = { customer=07, order={'J3','H4B'}  }
orders[#orders+1] = { customer=08, order={'T4','J1'}  }
orders[#orders+1] = { customer=09, order={'H1','T2A','C'}  }
orders[#orders+1] = { customer=04, order={'J6','H4'}  }
orders[#orders+1] = { customer=05, order={'S','C'}  }
orders[#orders+1] = { customer=06, order={'J5','T5','C'}  }
orders[#orders+1] = { customer=03, order={'H2C','C'}  }
orders[#orders+1] = { customer=09, order={'C','J5','S'}  }
orders[#orders+1] = { customer=01, order={'H4','C'}  }
orders[#orders+1] = { customer=04, order={'J2B','S'}  }
orders[#orders+1] = { customer=02, order={'J2','C',}  }
orders[#orders+1] = { customer=07, order={'C','H2','C'}  }
orders[#orders+1] = { customer=08, order={'C','J2C'}  }

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