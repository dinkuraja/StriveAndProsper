
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

stars = {616,670,804}

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

orders[#orders+1] = { customer=05, order={'T5B','M'}  }
orders[#orders+1] = { customer=08, order={'J2','T3','H1B'}  }
orders[#orders+1] = { customer=04, order={'J3','M','H2A'}  }
orders[#orders+1] = { customer=06, order={'T4','J5','S'}  }
orders[#orders+1] = { customer=02, order={'H4','C','J6'}  }
orders[#orders+1] = { customer=01, order={'T3','J3C'}  }
orders[#orders+1] = { customer=03, order={'J5','S'}  }
orders[#orders+1] = { customer=05, order={'M','T3A','J1'}  }
orders[#orders+1] = { customer=09, order={'J6','H2'}  }
orders[#orders+1] = { customer=08, order={'T1C','C','H3'}  }
orders[#orders+1] = { customer=04, order={'S','H1'}  }
orders[#orders+1] = { customer=07, order={'C','T4','H5A'}  }
orders[#orders+1] = { customer=03, order={'J2A','J3','C'}  }
orders[#orders+1] = { customer=01, order={'M','T2','H5'}  }
orders[#orders+1] = { customer=09, order={'T5','S'}  }
orders[#orders+1] = { customer=06, order={'C','H1','H3A'}  }
orders[#orders+1] = { customer=08, order={'J6','T2'}  }
orders[#orders+1] = { customer=02, order={'H2A','T6'}  }

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