
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

stars = {1014,1209,1326}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=05, order={'S','CM','S'}  }
orders[#orders+1] = { customer=06, order={'S','BLT','F'}  }
orders[#orders+1] = { customer=07, order={'S','BL','CM'}  }
orders[#orders+1] = { customer=08, order={'S','BL','F'}  }
orders[#orders+1] = { customer=09, order={'C','F'}  }
orders[#orders+1] = { customer=01, order={'S','BLT','F'}  }
orders[#orders+1] = { customer=02, order={'CM','C','BL'}  }
orders[#orders+1] = { customer=03, order={'F','B','S'}  }
orders[#orders+1] = { customer=04, order={'BT','F','C'}  }
orders[#orders+1] = { customer=06, order={'S','F','C'}  }
orders[#orders+1] = { customer=05, order={'F','BL','S'}  }
orders[#orders+1] = { customer=01, order={'F','CM','F'}  }
orders[#orders+1] = { customer=08, order={'F','C','BLT'}  }
orders[#orders+1] = { customer=03, order={'S','BT'}  }
orders[#orders+1] = { customer=09, order={'BLT','BL'}  }
orders[#orders+1] = { customer=02, order={'F','C','CM'}  }
orders[#orders+1] = { customer=07, order={'S','C','F'}  }
orders[#orders+1] = { customer=04, order={'S','F','BT'}  }
orders[#orders+1] = { customer=05, order={'CM','C','S'}  }
orders[#orders+1] = { customer=06, order={'C','CM','F'}  }
orders[#orders+1] = { customer=08, order={'S','B','BL'}  }
orders[#orders+1] = { customer=01, order={'S','F','BLT'}  }

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