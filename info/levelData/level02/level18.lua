
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

stars = {742,861,980}

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

orders[#orders+1] = { customer=05, order={'P','C','H4'}  }
orders[#orders+1] = { customer=06, order={'H6','J1A','M'}  }
orders[#orders+1] = { customer=07, order={'S','J5A'}  }
orders[#orders+1] = { customer=08, order={'C','H3','M'}  }
orders[#orders+1] = { customer=04, order={'S','J4B','M'}  }
orders[#orders+1] = { customer=03, order={'H2A','T2'}  }
orders[#orders+1] = { customer=09, order={'J4A','C','T3C'}  }
orders[#orders+1] = { customer=01, order={'P','H2C','S'}  }
orders[#orders+1] = { customer=02, order={'H1','S','H2B'}  }
orders[#orders+1] = { customer=03, order={'J5','H3B'}  }
orders[#orders+1] = { customer=08, order={'J6','C'}  }
orders[#orders+1] = { customer=05, order={'H2C','M','P'}  }
orders[#orders+1] = { customer=07, order={'T1B','S'}  }
orders[#orders+1] = { customer=06, order={'J3','P','M'}  }
orders[#orders+1] = { customer=09, order={'C','H2C','P'}  }
orders[#orders+1] = { customer=04, order={'J6A','S','T1'}  }
orders[#orders+1] = { customer=01, order={'P','H6','J2'}  }
orders[#orders+1] = { customer=08, order={'S','J3C','H1'}  }
orders[#orders+1] = { customer=02, order={'H2','T5A','M'}  }

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