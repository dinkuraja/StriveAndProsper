
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

stars = {1222,1440,1658}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=03, order={'B','C','S'}  }
orders[#orders+1] = { customer=02, order={'F','BL','S'}  }
orders[#orders+1] = { customer=01, order={'F','S','F'}  }
orders[#orders+1] = { customer=09, order={'F','BLT','CM'}  }
orders[#orders+1] = { customer=08, order={'BLT','S','CM'}  }
orders[#orders+1] = { customer=07, order={'S','F','C'}  }
orders[#orders+1] = { customer=06, order={'F','BT','CM'}  }
orders[#orders+1] = { customer=05, order={'B','B','S'}  }
orders[#orders+1] = { customer=04, order={'BL','C','CM'}  }
orders[#orders+1] = { customer=09, order={'BLT','S','F'}  }
orders[#orders+1] = { customer=03, order={'BT','S','BT'}  }
orders[#orders+1] = { customer=06, order={'F','S','F'}  }
orders[#orders+1] = { customer=02, order={'BL','S','C'}  }
orders[#orders+1] = { customer=07, order={'CM','S','CM'}  }
orders[#orders+1] = { customer=05, order={'C','F','F'}  }
orders[#orders+1] = { customer=08, order={'S','S','CM'}  }
orders[#orders+1] = { customer=01, order={'S','F','B'}  }
orders[#orders+1] = { customer=04, order={'BT','S','BL'}  }
orders[#orders+1] = { customer=02, order={'BLT','F','CM'}  }
orders[#orders+1] = { customer=03, order={'B','BL','S'}  }
orders[#orders+1] = { customer=09, order={'F','S','CM'}  }
orders[#orders+1] = { customer=06, order={'S','F','C'}  }
orders[#orders+1] = { customer=07, order={'S','S','B'}  }
orders[#orders+1] = { customer=05, order={'F','S','C'}  }

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