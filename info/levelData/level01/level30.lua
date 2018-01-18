
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

stars = {1395,1645,1894}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=07, order={'F','B','S'}  }
orders[#orders+1] = { customer=01, order={'S','C','BL'}  }
orders[#orders+1] = { customer=06, order={'BT','S','F'}  }
orders[#orders+1] = { customer=02, order={'S','BL','CM'}  }
orders[#orders+1] = { customer=05, order={'BLT','S','CM'}  }
orders[#orders+1] = { customer=03, order={'BL','F','CM'}  }
orders[#orders+1] = { customer=04, order={'F','BT','CM'}  }
orders[#orders+1] = { customer=09, order={'B','BLT','C'}  }
orders[#orders+1] = { customer=08, order={'BL','S','CM'}  }
orders[#orders+1] = { customer=01, order={'BLT','F','B'}  }
orders[#orders+1] = { customer=03, order={'BT','S','C'}  }
orders[#orders+1] = { customer=07, order={'F','S','CM'}  }
orders[#orders+1] = { customer=09, order={'B','S','C'}  }
orders[#orders+1] = { customer=02, order={'CM','S','BLT'}  }
orders[#orders+1] = { customer=04, order={'C','F','BT'}  }
orders[#orders+1] = { customer=08, order={'S','BL','CM'}  }
orders[#orders+1] = { customer=06, order={'S','C','B'}  }
orders[#orders+1] = { customer=05, order={'BT','BL','F'}  }
orders[#orders+1] = { customer=07, order={'BLT','S','CM'}  }
orders[#orders+1] = { customer=03, order={'BT','BLT','S'}  }
orders[#orders+1] = { customer=01, order={'F','C','CM'}  }
orders[#orders+1] = { customer=09, order={'BL','CM','B'}  }
orders[#orders+1] = { customer=04, order={'C','BT','B'}  }
orders[#orders+1] = { customer=06, order={'C','C','BLT'}  }

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