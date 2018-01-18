
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

stars = {1452,1703,1953}

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

orders[#orders+1] = { customer=04, order={'P','H3A','H6C'}  }
orders[#orders+1] = { customer=03, order={'T5A','H4A','S'}  }
orders[#orders+1] = { customer=02, order={'J2A','T1A','J6C'}  }
orders[#orders+1] = { customer=01, order={'J5B','H2B','C'}  }
orders[#orders+1] = { customer=05, order={'S','J4C','H6B'}  }
orders[#orders+1] = { customer=06, order={'H5C','S','T6A'}  }
orders[#orders+1] = { customer=07, order={'S','H2B','T2C'}  }
orders[#orders+1] = { customer=08, order={'T3A','H1','T5A'}  }
orders[#orders+1] = { customer=09, order={'S','S','J5B'}  }
orders[#orders+1] = { customer=06, order={'H5A','H3B','S'}  }
orders[#orders+1] = { customer=01, order={'S','H5C','J1'}  }
orders[#orders+1] = { customer=03, order={'H3A','T5C','T4B'}  }
orders[#orders+1] = { customer=07, order={'S','H4C','J6A'}  }
orders[#orders+1] = { customer=05, order={'H5','J6A','T3B'}  }
orders[#orders+1] = { customer=02, order={'S','H5B','H4'}  }
orders[#orders+1] = { customer=04, order={'J1C','J4A','S'}  }
orders[#orders+1] = { customer=08, order={'H3B','T4C','J6B'}  }
orders[#orders+1] = { customer=06, order={'J2B','T5B','P'}  }
orders[#orders+1] = { customer=09, order={'J3C','S','T4A'}  }
orders[#orders+1] = { customer=07, order={'J2A','T5A','H4B'}  }
orders[#orders+1] = { customer=04, order={'S','T4C','H5B'}  }
orders[#orders+1] = { customer=03, order={'H5C','S','T6A'}  }
orders[#orders+1] = { customer=02, order={'H6A','H2A','J3C'}  }
orders[#orders+1] = { customer=01, order={'T1B','H3C','J1B'}  }
orders[#orders+1] = { customer=05, order={'T2','S','H1A'}  }

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