
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

stars = {966,1145,1253}

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

orders[#orders+1] = { customer=01, order={'H6','T1','S'}  }
orders[#orders+1] = { customer=04, order={'H2','J2C','P'}  }
orders[#orders+1] = { customer=07, order={'S','T5B','M'}  }
orders[#orders+1] = { customer=02, order={'J2','H1A','T6B'}  }
orders[#orders+1] = { customer=05, order={'J4A','M','H3A'}  }
orders[#orders+1] = { customer=08, order={'T2B','P','H6C'}  }
orders[#orders+1] = { customer=03, order={'J4','J5','T1C'}  }
orders[#orders+1] = { customer=06, order={'T3A','H5C','S'}  }
orders[#orders+1] = { customer=09, order={'J1A','H2B','P'}  }
orders[#orders+1] = { customer=02, order={'H3B','S'}  }
orders[#orders+1] = { customer=01, order={'J2B','T1','M'}  }
orders[#orders+1] = { customer=03, order={'S','T2A','P'}  }
orders[#orders+1] = { customer=07, order={'H2','C','J2C'}  }
orders[#orders+1] = { customer=05, order={'M','J4','S'}  }
orders[#orders+1] = { customer=04, order={'T4A','J1B','S'}  }
orders[#orders+1] = { customer=08, order={'J2C','T5','H1C'}  }
orders[#orders+1] = { customer=01, order={'H1','S','P'}  }
orders[#orders+1] = { customer=06, order={'T4C','H2A','C'}  }
orders[#orders+1] = { customer=07, order={'J5','C','T4B'}  }
orders[#orders+1] = { customer=09, order={'T4C','H3','S'}  }
orders[#orders+1] = { customer=04, order={'M','T6A'}  }

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