
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

stars = {1031,1222,1337}

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

orders[#orders+1] = { customer=05, order={'S','H2','J1C'}  }
orders[#orders+1] = { customer=08, order={'J1C','J6B','P'}  }
orders[#orders+1] = { customer=09, order={'J2A','S','H1B'}  }
orders[#orders+1] = { customer=01, order={'H5','C','T6B'}  }
orders[#orders+1] = { customer=07, order={'J4A','H3A','M'}  }
orders[#orders+1] = { customer=02, order={'T5A','T4','H6B'}  }
orders[#orders+1] = { customer=06, order={'P','J5','T1C'}  }
orders[#orders+1] = { customer=05, order={'T3A','S','H5C'}  }
orders[#orders+1] = { customer=01, order={'J2A','H4B','P'}  }
orders[#orders+1] = { customer=04, order={'H3B','S','H6C'}  }
orders[#orders+1] = { customer=09, order={'S','T1','M'}  }
orders[#orders+1] = { customer=03, order={'J5B','P','H2A'}  }
orders[#orders+1] = { customer=08, order={'H2C','M','J2'}  }
orders[#orders+1] = { customer=06, order={'P','T5','S'}  }
orders[#orders+1] = { customer=04, order={'T4A','H6A','J1B'}  }
orders[#orders+1] = { customer=02, order={'J2C','T5','M'}  }
orders[#orders+1] = { customer=09, order={'S','H4','P'}  }
orders[#orders+1] = { customer=07, order={'J5A','T4C','H1A'}  }
orders[#orders+1] = { customer=05, order={'J2','C','T5B'}  }
orders[#orders+1] = { customer=03, order={'H5','J3C','S'}  }
orders[#orders+1] = { customer=01, order={'S','T6A','C'}  }

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