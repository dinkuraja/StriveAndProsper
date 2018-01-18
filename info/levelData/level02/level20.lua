
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

stars = {852,988,1125}

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

orders[#orders+1] = { customer=06, order={'M','J4','H1A'}  }
orders[#orders+1] = { customer=07, order={'J2C','H5','S'}  }
orders[#orders+1] = { customer=08, order={'S','T5B','J5'}  }
orders[#orders+1] = { customer=09, order={'P','H4','H3'}  }
orders[#orders+1] = { customer=05, order={'J4A','M','S'}  }
orders[#orders+1] = { customer=04, order={'T2B','J5C','C'}  }
orders[#orders+1] = { customer=03, order={'J6','M','T1C'}  }
orders[#orders+1] = { customer=02, order={'P','H5C','S'}  }
orders[#orders+1] = { customer=01, order={'P','H2B','J1A'}  }
orders[#orders+1] = { customer=05, order={'H3B','P'}  }
orders[#orders+1] = { customer=06, order={'J2B','T1','C'}  }
orders[#orders+1] = { customer=04, order={'S','J2A','P'}  }
orders[#orders+1] = { customer=07, order={'T2','M','J2C'}  }
orders[#orders+1] = { customer=03, order={'M','P','S'}  }
orders[#orders+1] = { customer=08, order={'H4B','C','H2C'}  }
orders[#orders+1] = { customer=02, order={'J6B','T3','S'}  }
orders[#orders+1] = { customer=09, order={'H1','S','P'}  }
orders[#orders+1] = { customer=01, order={'J2','H5A'}  }
orders[#orders+1] = { customer=04, order={'C','J1','J4B'}  }
orders[#orders+1] = { customer=03, order={'T1C','H3','T6A'}  }

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