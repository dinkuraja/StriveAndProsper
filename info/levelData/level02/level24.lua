
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

stars = {1082,1283,1403}

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

orders[#orders+1] = { customer=06, order={'S','M','H6C'}  }
orders[#orders+1] = { customer=07, order={'S','H1B','P'}  }
orders[#orders+1] = { customer=08, order={'J2A','H3B','S'}  }
orders[#orders+1] = { customer=09, order={'H5','J3C','S'}  }
orders[#orders+1] = { customer=05, order={'J4A','P','T5'}  }
orders[#orders+1] = { customer=04, order={'S','T4','H6B'}  }
orders[#orders+1] = { customer=03, order={'H4B','P','T1C'}  }
orders[#orders+1] = { customer=02, order={'T3A','H3A','H2'}  }
orders[#orders+1] = { customer=01, order={'J2A','P','J5'}  }
orders[#orders+1] = { customer=09, order={'S','H5C','J1C'}  }
orders[#orders+1] = { customer=04, order={'J2','C','M'}  }
orders[#orders+1] = { customer=07, order={'J5B','P','H2A'}  }
orders[#orders+1] = { customer=03, order={'H2C','M'}  }
orders[#orders+1] = { customer=06, order={'J1C','H6A','J1B'}  }
orders[#orders+1] = { customer=02, order={'T4A','H4','P'}  }
orders[#orders+1] = { customer=08, order={'J2C','T5','M'}  }
orders[#orders+1] = { customer=01, order={'S','J6B','T5A'}  }
orders[#orders+1] = { customer=05, order={'J5A','C','J2'}  }
orders[#orders+1] = { customer=07, order={'S','T1','T5B'}  }
orders[#orders+1] = { customer=03, order={'H5','C','T6B'}  }
orders[#orders+1] = { customer=04, order={'S','T6A','C'}  }
orders[#orders+1] = { customer=02, order={'H2B','T4C','H1A'}  }

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