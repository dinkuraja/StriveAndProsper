
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

stars = {1255,1472,1688}

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

orders[#orders+1] = { customer=01, order={'P','H5','T5C'}  }
orders[#orders+1] = { customer=05, order={'S','H5B','J2'}  }
orders[#orders+1] = { customer=09, order={'J2A','C','T4C'}  }
orders[#orders+1] = { customer=02, order={'S','T6','J1'}  }
orders[#orders+1] = { customer=06, order={'T4C','S','J3C'}  }
orders[#orders+1] = { customer=03, order={'T1A','M','T4'}  }
orders[#orders+1] = { customer=07, order={'S','H2B','T2'}  }
orders[#orders+1] = { customer=04, order={'T3A','C','T6A'}  }
orders[#orders+1] = { customer=08, order={'S','P','H2A'}  }
orders[#orders+1] = { customer=09, order={'H1','M','H6'}  }
orders[#orders+1] = { customer=01, order={'P','J2','C'}  }
orders[#orders+1] = { customer=02, order={'J5B','J2A','P'}  }
orders[#orders+1] = { customer=03, order={'H2C','T5'}  }
orders[#orders+1] = { customer=04, order={'T3B','P','C'}  }
orders[#orders+1] = { customer=05, order={'H4','J4A','M'}  }
orders[#orders+1] = { customer=06, order={'J1C','M','H5C'}  }
orders[#orders+1] = { customer=07, order={'J5A','H6B','P'}  }
orders[#orders+1] = { customer=08, order={'C','H3A','J1B',}  }
orders[#orders+1] = { customer=03, order={'T4A','H3B','S'}  }
orders[#orders+1] = { customer=01, order={'H3A','S','H4B'}  }
orders[#orders+1] = { customer=05, order={'S','H2B','H5B'}  }
orders[#orders+1] = { customer=09, order={'J3C','S','J5'}  }
orders[#orders+1] = { customer=07, order={'J6A','H5C','S'}  }
orders[#orders+1] = { customer=04, order={'M','T5','J6C'}  }

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