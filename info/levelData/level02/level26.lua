
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

stars = {1229,1441,1653}

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

orders[#orders+1] = { customer=01, order={'J2A','P','T5C'}  }
orders[#orders+1] = { customer=02, order={'S','C','T4C'}  }
orders[#orders+1] = { customer=03, order={'J2A','H5B','H6'}  }
orders[#orders+1] = { customer=07, order={'H1','M','J1'}  }
orders[#orders+1] = { customer=08, order={'C','H3A','J3C'}  }
orders[#orders+1] = { customer=09, order={'J3C','S','S'}  }
orders[#orders+1] = { customer=04, order={'H6B','P','T2'}  }
orders[#orders+1] = { customer=05, order={'T3A','H3B','S'}  }
orders[#orders+1] = { customer=06, order={'S','P','H2A'}  }
orders[#orders+1] = { customer=02, order={'T6','S','J2'}  }
orders[#orders+1] = { customer=08, order={'P','H5C','S'}  }
orders[#orders+1] = { customer=03, order={'J5B','P','H5'}  }
orders[#orders+1] = { customer=09, order={'H2C','J6C','T5'}  }
orders[#orders+1] = { customer=05, order={'T3B','P','C'}  }
orders[#orders+1] = { customer=01, order={'H4','J1C','M'}  }
orders[#orders+1] = { customer=07, order={'J4A','H5C','M'}  }
orders[#orders+1] = { customer=04, order={'J5A','S','H2B'}  }
orders[#orders+1] = { customer=06, order={'S','H4B','S'}  }
orders[#orders+1] = { customer=08, order={'T4A','C','T6A'}  }
orders[#orders+1] = { customer=05, order={'H3A','J1B','T4C'}  }
orders[#orders+1] = { customer=07, order={'H2B','T4','H5B'}  }
orders[#orders+1] = { customer=02, order={'T1A','M','J5'}  }
orders[#orders+1] = { customer=03, order={'J6A','J2','C'}  }

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