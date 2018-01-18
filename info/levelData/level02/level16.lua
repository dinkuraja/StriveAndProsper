
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

stars = {685,794,904}

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

orders[#orders+1] = { customer=09, order={'S','T3B','H5A'}  }
orders[#orders+1] = { customer=08, order={'H3','T2'}  }
orders[#orders+1] = { customer=01, order={'M','T1','C'}  }
orders[#orders+1] = { customer=02, order={'H3B','C','J2'}  }
orders[#orders+1] = { customer=03, order={'S','J4B'}  }
orders[#orders+1] = { customer=04, order={'H1','M'}  }
orders[#orders+1] = { customer=05, order={'C','J2','T6C'}  }
orders[#orders+1] = { customer=06, order={'J1','H3'}  }
orders[#orders+1] = { customer=07, order={'S','T2','J6A'}  }
orders[#orders+1] = { customer=01, order={'J5','H3B'}  }
orders[#orders+1] = { customer=09, order={'T4','M'}  }
orders[#orders+1] = { customer=06, order={'S','J5','H2'}  }
orders[#orders+1] = { customer=04, order={'T1B','S','H6'}  }
orders[#orders+1] = { customer=05, order={'J3','C','M'}  }
orders[#orders+1] = { customer=03, order={'M','H2'}  }
orders[#orders+1] = { customer=02, order={'J6','S','H1'}  }
orders[#orders+1] = { customer=07, order={'H6B','M'}  }
orders[#orders+1] = { customer=08, order={'S','J3C'}  }

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