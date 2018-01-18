
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

stars = {1302,1526,1751}

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

orders[#orders+1] = { customer=04, order={'H1A','S','H5B'}  }
orders[#orders+1] = { customer=03, order={'T3A','J2C','M'}  }
orders[#orders+1] = { customer=02, order={'J2A','C','T4C'}  }
orders[#orders+1] = { customer=05, order={'S','H2A','J1'}  }
orders[#orders+1] = { customer=06, order={'T4C','S','J3C'}  }
orders[#orders+1] = { customer=07, order={'H5','C','T6A'}  }
orders[#orders+1] = { customer=01, order={'S','H2B','T2'}  }
orders[#orders+1] = { customer=09, order={'T3A','T5C','T4'}  }
orders[#orders+1] = { customer=08, order={'S','T5','J6C'}  }
orders[#orders+1] = { customer=07, order={'H6B','P','H6'}  }
orders[#orders+1] = { customer=05, order={'S','H2B','C'}  }
orders[#orders+1] = { customer=03, order={'J3C','C','J5B'}  }
orders[#orders+1] = { customer=01, order={'S','H2C','J5'}  }
orders[#orders+1] = { customer=06, order={'J2A','P','T3B'}  }
orders[#orders+1] = { customer=02, order={'H4','J4A','M'}  }
orders[#orders+1] = { customer=04, order={'J1C','C','H5B'}  }
orders[#orders+1] = { customer=08, order={'H1','T5A','M'}  }
orders[#orders+1] = { customer=05, order={'S','H3A','J1B'}  }
orders[#orders+1] = { customer=09, order={'T4A','H3B','S'}  }
orders[#orders+1] = { customer=01, order={'S','T6','H4B'}  }
orders[#orders+1] = { customer=06, order={'P','J2B','H5B'}  }
orders[#orders+1] = { customer=03, order={'P','T5B','T6A'}  }
orders[#orders+1] = { customer=04, order={'J6A','P','H2A'}  }
orders[#orders+1] = { customer=02, order={'T1B','H5C','S'}  }

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