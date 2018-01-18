
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

stars = {997,1188,1303}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=09, order={'CM','BLT','S'}  }
orders[#orders+1] = { customer=08, order={'C','F','F'}  }
orders[#orders+1] = { customer=07, order={'BT','S','S'}  }
orders[#orders+1] = { customer=01, order={'F','B','C'}  }
orders[#orders+1] = { customer=02, order={'C','BL','S'}  }
orders[#orders+1] = { customer=03, order={'F','F','S'}  }
orders[#orders+1] = { customer=06, order={'BT','S','BLT'}  }
orders[#orders+1] = { customer=05, order={'C','C'}  }
orders[#orders+1] = { customer=04, order={'BL','CM','F'}  }
orders[#orders+1] = { customer=07, order={'S','S','B'}  }
orders[#orders+1] = { customer=03, order={'C','BT'}  }
orders[#orders+1] = { customer=08, order={'F','BLT','F'}  }
orders[#orders+1] = { customer=01, order={'F','C','S'}  }
orders[#orders+1] = { customer=09, order={'CM','BL','BT'}  }
orders[#orders+1] = { customer=02, order={'C','F','C'}  }
orders[#orders+1] = { customer=06, order={'F','BL','BLT'}  }
orders[#orders+1] = { customer=07, order={'S','B','S'}  }
orders[#orders+1] = { customer=03, order={'C','S','F'}  }
orders[#orders+1] = { customer=04, order={'BT','C','S'}  }
orders[#orders+1] = { customer=05, order={'BLT','CM','S'}  }
orders[#orders+1] = { customer=08, order={'S','F','BT'}  }

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