
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

stars = {1159,1366,1573}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=01, order={'C','S','F'}  }
orders[#orders+1] = { customer=03, order={'F','CM','B'}  }
orders[#orders+1] = { customer=05, order={'S','BT','S'}  }
orders[#orders+1] = { customer=07, order={'F','C','B'}  }
orders[#orders+1] = { customer=09, order={'BT','S','BT'}  }
orders[#orders+1] = { customer=02, order={'S','B','CM'}  }
orders[#orders+1] = { customer=04, order={'F','BT','S'}  }
orders[#orders+1] = { customer=06, order={'F','BL','S'}  }
orders[#orders+1] = { customer=08, order={'C','B','S'}  }
orders[#orders+1] = { customer=03, order={'BL','S','F'}  }
orders[#orders+1] = { customer=06, order={'B','F','C'}  }
orders[#orders+1] = { customer=09, order={'S','CM','S'}  }
orders[#orders+1] = { customer=07, order={'BT','C','S'}  }
orders[#orders+1] = { customer=01, order={'F','B','S'}  }
orders[#orders+1] = { customer=02, order={'BL','F','BT'}  }
orders[#orders+1] = { customer=04, order={'F','S','CM'}  }
orders[#orders+1] = { customer=03, order={'S','BL','S'}  }
orders[#orders+1] = { customer=05, order={'CM','S','B'}  }
orders[#orders+1] = { customer=08, order={'C','C','S'}  }
orders[#orders+1] = { customer=06, order={'F','BT','S'}  }
orders[#orders+1] = { customer=07, order={'S','C','BL'}  }
orders[#orders+1] = { customer=09, order={'S','F','BT'}  }
orders[#orders+1] = { customer=02, order={'CM','S','F'}  }

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