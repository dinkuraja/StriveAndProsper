
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

stars = {802,930,1059}

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

orders[#orders+1] = { customer=05, order={'T6A','M','P'}  }
orders[#orders+1] = { customer=03, order={'S','J5A','H1'}  }
orders[#orders+1] = { customer=01, order={'T2','T3','M'}  }
orders[#orders+1] = { customer=07, order={'H1','P'}  }
orders[#orders+1] = { customer=09, order={'S','J4C','M'}  }
orders[#orders+1] = { customer=06, order={'T2A','T2C','S'}  }
orders[#orders+1] = { customer=04, order={'J4A','C','T3C'}  }
orders[#orders+1] = { customer=02, order={'P','H2C','S'}  }
orders[#orders+1] = { customer=08, order={'H1','C','H2B'}  }
orders[#orders+1] = { customer=09, order={'H3B','H1C'}  }
orders[#orders+1] = { customer=05, order={'J6','S','H2A'}  }
orders[#orders+1] = { customer=02, order={'M','P','H6'}  }
orders[#orders+1] = { customer=03, order={'T1B','S','J5'}  }
orders[#orders+1] = { customer=07, order={'P','C','M'}  }
orders[#orders+1] = { customer=06, order={'H4','C','T2'}  }
orders[#orders+1] = { customer=04, order={'J6B','T3','S'}  }
orders[#orders+1] = { customer=08, order={'C','P','M'}  }
orders[#orders+1] = { customer=01, order={'J3','H3A'}  }
orders[#orders+1] = { customer=02, order={'P','J6','T2'}  }
orders[#orders+1] = { customer=05, order={'C','H4B'}  }

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