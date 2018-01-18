
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

stars = {1063,1260,1379}

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

orders[#orders+1] = { customer=05, order={'S','J5','H4A'}  }
orders[#orders+1] = { customer=04, order={'H4','J3C','P'}  }
orders[#orders+1] = { customer=03, order={'J1A','P','T5'}  }
orders[#orders+1] = { customer=02, order={'S','H5C','S'}  }
orders[#orders+1] = { customer=01, order={'J5A','H3A','S'}  }
orders[#orders+1] = { customer=06, order={'T6A','T4','H6B'}  }
orders[#orders+1] = { customer=07, order={'J3B','S','T5'}  }
orders[#orders+1] = { customer=08, order={'T2A','H3A','H2'}  }
orders[#orders+1] = { customer=09, order={'J5A','J3B','P'}  }
orders[#orders+1] = { customer=01, order={'S','H5C','J1A'}  }
orders[#orders+1] = { customer=05, order={'J2','C','H2'}  }
orders[#orders+1] = { customer=06, order={'H1','M','H2B'}  }
orders[#orders+1] = { customer=04, order={'H6A','H2B','T3C'}  }
orders[#orders+1] = { customer=07, order={'J1C','C'}  }
orders[#orders+1] = { customer=03, order={'T4A','H4','P'}  }
orders[#orders+1] = { customer=08, order={'P','T1C','M'}  }
orders[#orders+1] = { customer=02, order={'S','H5A','J4B'}  }
orders[#orders+1] = { customer=09, order={'J5A','H4B','J1C'}  }
orders[#orders+1] = { customer=04, order={'S','T1','T3B'}  }
orders[#orders+1] = { customer=01, order={'H5','J2','T2B'}  }
orders[#orders+1] = { customer=06, order={'S','T1A','C'}  }
orders[#orders+1] = { customer=05, order={'J4A','H6A','M'}  }

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