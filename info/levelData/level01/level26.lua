
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

stars = {1138,1341,1544}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=01, order={'B','S','F'}  }
orders[#orders+1] = { customer=02, order={'BLT','S','B'}  }
orders[#orders+1] = { customer=05, order={'S','BL','F'}  }
orders[#orders+1] = { customer=06, order={'B','S','C'}  }
orders[#orders+1] = { customer=03, order={'BT','S','F'}  }
orders[#orders+1] = { customer=04, order={'S','B','BL'}  }
orders[#orders+1] = { customer=07, order={'F','BT','B'}  }
orders[#orders+1] = { customer=08, order={'F','CM','S'}  }
orders[#orders+1] = { customer=09, order={'BT','B','F'}  }
orders[#orders+1] = { customer=06, order={'BL','S','B'}  }
orders[#orders+1] = { customer=02, order={'B','F','B'}  }
orders[#orders+1] = { customer=08, order={'F','C','S'}  }
orders[#orders+1] = { customer=04, order={'BT','BLT','S'}  }
orders[#orders+1] = { customer=01, order={'S','BL','F'}  }
orders[#orders+1] = { customer=03, order={'B','F','BL'}  }
orders[#orders+1] = { customer=05, order={'F','B','CM'}  }
orders[#orders+1] = { customer=07, order={'S','B','S'}  }
orders[#orders+1] = { customer=09, order={'C','S','B'}  }
orders[#orders+1] = { customer=06, order={'CM','C','S'}  }
orders[#orders+1] = { customer=04, order={'F','S','S'}  }
orders[#orders+1] = { customer=03, order={'S','BL','B'}  }
orders[#orders+1] = { customer=02, order={'BT','F','BLT'}  }

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