
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

stars = {259,271,306}

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

orders[#orders+1] = { customer=05, order={'C'}  }
orders[#orders+1] = { customer=04, order={'J2A','C','T2'}  }
orders[#orders+1] = { customer=03, order={'J1','C'}  }
orders[#orders+1] = { customer=02, order={'C','T5'}  }
orders[#orders+1] = { customer=01, order={'J3B','C'}  }
orders[#orders+1] = { customer=06, order={'T4C','C'}  }
orders[#orders+1] = { customer=07, order={'C','T5'}  }
orders[#orders+1] = { customer=08, order={'J4','T1'}  }
orders[#orders+1] = { customer=09, order={'T3','C'}  }
orders[#orders+1] = { customer=02, order={'J5','C'}  }
orders[#orders+1] = { customer=05, order={'C'}  }
orders[#orders+1] = { customer=07, order={'C','J2B'}  }
orders[#orders+1] = { customer=04, order={'T4','J1'}  }

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