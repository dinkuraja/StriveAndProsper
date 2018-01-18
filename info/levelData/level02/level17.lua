
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

stars = {730,846,963}

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

orders[#orders+1] = { customer=07, order={'S','T3B','M'}  }
orders[#orders+1] = { customer=05, order={'H3A','J2'}  }
orders[#orders+1] = { customer=03, order={'T1B','C','S'}  }
orders[#orders+1] = { customer=01, order={'J5','C','H4'}  }
orders[#orders+1] = { customer=02, order={'S','J4B','M'}  }
orders[#orders+1] = { customer=04, order={'H1A','C'}  }
orders[#orders+1] = { customer=06, order={'C','J5A','T6C'}  }
orders[#orders+1] = { customer=09, order={'T1B','H3','S'}  }
orders[#orders+1] = { customer=08, order={'J2A','T2'}  }
orders[#orders+1] = { customer=01, order={'J5','H3B','J1'}  }
orders[#orders+1] = { customer=05, order={'J6','S','H2A'}  }
orders[#orders+1] = { customer=06, order={'C','J2','H2'}  }
orders[#orders+1] = { customer=07, order={'T1B','S'}  }
orders[#orders+1] = { customer=04, order={'J3','C','T3'}  }
orders[#orders+1] = { customer=03, order={'C','H2','T5C'}  }
orders[#orders+1] = { customer=08, order={'J6','S','H1'}  }
orders[#orders+1] = { customer=01, order={'H2C','M','S'}  }
orders[#orders+1] = { customer=09, order={'S','J3C','M'}  }
orders[#orders+1] = { customer=06, order={'T3','H1A'}  }

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