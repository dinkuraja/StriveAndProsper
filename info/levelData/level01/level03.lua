
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

stars = {144,168,185}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=05, order={'S','B'}  }
orders[#orders+1] = { customer=09, order={'B'}  }
orders[#orders+1] = { customer=03, order={'S'}  }
orders[#orders+1] = { customer=08, order={'S','B'}  }
orders[#orders+1] = { customer=07, order={'B'}  }
orders[#orders+1] = { customer=01, order={'B','S'}  }
orders[#orders+1] = { customer=04, order={'S'}  }
orders[#orders+1] = { customer=02, order={'B','S'}  }
orders[#orders+1] = { customer=05, order={'S'}  }
orders[#orders+1] = { customer=06, order={'S','B'}  }
orders[#orders+1] = { customer=03, order={'B','S'}  }

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