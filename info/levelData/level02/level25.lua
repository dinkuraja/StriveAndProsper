
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

stars = {1120,1328,1452}

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

orders[#orders+1] = { customer=09, order={'J2A','P','H5C'}  }
orders[#orders+1] = { customer=08, order={'S','H2B','P'}  }
orders[#orders+1] = { customer=07, order={'J2A','H3B','S'}  }
orders[#orders+1] = { customer=06, order={'H1','M'}  }
orders[#orders+1] = { customer=05, order={'J4A','H5C','J3C'}  }
orders[#orders+1] = { customer=04, order={'S','C','H1A'}  }
orders[#orders+1] = { customer=03, order={'H4B','T5B','P'}  }
orders[#orders+1] = { customer=02, order={'T3A','H5A','H2'}  }
orders[#orders+1] = { customer=01, order={'S','M','J5'}  }
orders[#orders+1] = { customer=05, order={'H4A','J1B','J2'}  }
orders[#orders+1] = { customer=07, order={'S','P','T5C'}  }
orders[#orders+1] = { customer=09, order={'J5B','T4','H6B'}  }
orders[#orders+1] = { customer=02, order={'H2C','J3C','S'}  }
orders[#orders+1] = { customer=04, order={'P','T2','C'}  }
orders[#orders+1] = { customer=06, order={'H4','J1C','M'}  }
orders[#orders+1] = { customer=08, order={'J6C','T5','M'}  }
orders[#orders+1] = { customer=01, order={'J5A','C','T6A'}  }
orders[#orders+1] = { customer=03, order={'S','J6B','J2'}  }
orders[#orders+1] = { customer=02, order={'T4A','S','H2B'}  }
orders[#orders+1] = { customer=07, order={'S','T1','T6B'}  }
orders[#orders+1] = { customer=08, order={'H5','C','T3C'}  }
orders[#orders+1] = { customer=04, order={'T6A','P','H2A'}  }
orders[#orders+1] = { customer=06, order={'H4B','S'}  }

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