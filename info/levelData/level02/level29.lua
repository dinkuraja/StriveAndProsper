
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

stars = {1342,1574,1805}

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

orders[#orders+1] = { customer=02, order={'H2B','P','H6'}  }
orders[#orders+1] = { customer=08, order={'S','H3A','T3A'}  }
orders[#orders+1] = { customer=03, order={'J2A','T5','J6C'}  }
orders[#orders+1] = { customer=05, order={'J5B','C','J1'}  }
orders[#orders+1] = { customer=07, order={'T4C','J3C','S'}  }
orders[#orders+1] = { customer=01, order={'T2','S','T6A'}  }
orders[#orders+1] = { customer=09, order={'S','H2B','T2'}  }
orders[#orders+1] = { customer=04, order={'T3A','S','J5B'}  }
orders[#orders+1] = { customer=02, order={'S','H1','T5A'}  }
orders[#orders+1] = { customer=06, order={'H6B','S','H5B'}  }
orders[#orders+1] = { customer=07, order={'S','H2B','C'}  }
orders[#orders+1] = { customer=08, order={'H3A','T5C','T4'}  }
orders[#orders+1] = { customer=09, order={'P','H4C','J6'}  }
orders[#orders+1] = { customer=05, order={'H5','C','T3B'}  }
orders[#orders+1] = { customer=04, order={'C','H5B','H4'}  }
orders[#orders+1] = { customer=03, order={'J1C','J4A','M'}  }
orders[#orders+1] = { customer=01, order={'C','T4C','M'}  }
orders[#orders+1] = { customer=02, order={'J2B','H5C','S'}  }
orders[#orders+1] = { customer=09, order={'S','H3B','T4A'}  }
orders[#orders+1] = { customer=03, order={'J2A','P','H4B'}  }
orders[#orders+1] = { customer=08, order={'J4C','S','H5B'}  }
orders[#orders+1] = { customer=04, order={'T6A','T5B','P'}  }
orders[#orders+1] = { customer=07, order={'P','H2A','J3C'}  }
orders[#orders+1] = { customer=05, order={'T1B','M','J1B'}  }
orders[#orders+1] = { customer=06, order={'H5C','S'}  }

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