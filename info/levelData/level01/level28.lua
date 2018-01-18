
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

stars = {1178,1389,1599}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=07, order={'S','C','F'}  }
orders[#orders+1] = { customer=06, order={'CM','BT','S'}  }
orders[#orders+1] = { customer=05, order={'S','S','F'}  }
orders[#orders+1] = { customer=04, order={'F','BL','C'}  }
orders[#orders+1] = { customer=03, order={'BLT','S','S'}  }
orders[#orders+1] = { customer=02, order={'S','BT','CM'}  }
orders[#orders+1] = { customer=01, order={'F','B','C'}  }
orders[#orders+1] = { customer=09, order={'S','S','S'}  }
orders[#orders+1] = { customer=08, order={'F','F','BL'}  }
orders[#orders+1] = { customer=05, order={'BLT','C','F'}  }
orders[#orders+1] = { customer=03, order={'CM','CM','C'}  }
orders[#orders+1] = { customer=06, order={'S','F','B'}  }
orders[#orders+1] = { customer=02, order={'BLT','F','F'}  }
orders[#orders+1] = { customer=07, order={'CM','C','S'}  }
orders[#orders+1] = { customer=01, order={'BT','F','B'}  }
orders[#orders+1] = { customer=05, order={'F','S','S'}  }
orders[#orders+1] = { customer=08, order={'S','F','F'}  }
orders[#orders+1] = { customer=03, order={'BT','S','BL'}  }
orders[#orders+1] = { customer=09, order={'B','C','BLT'}  }
orders[#orders+1] = { customer=04, order={'F','BL','S'}  }
orders[#orders+1] = { customer=02, order={'BT','BLT','B'}  }
orders[#orders+1] = { customer=01, order={'S','C','CM'}  }
orders[#orders+1] = { customer=06, order={'CM','S','C'}  }

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