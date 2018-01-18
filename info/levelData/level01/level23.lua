
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

stars = {975,1162,1275}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=01, order={'S','F','F'}  }
orders[#orders+1] = { customer=03, order={'B','S','CM'}  }
orders[#orders+1] = { customer=05, order={'S','BL','B'}  }
orders[#orders+1] = { customer=07, order={'F','C','S'}  }
orders[#orders+1] = { customer=09, order={'S','CM'}  }
orders[#orders+1] = { customer=02, order={'F','BL','BT'}  }
orders[#orders+1] = { customer=04, order={'C','S','B'}  }
orders[#orders+1] = { customer=06, order={'C','CM','F'}  }
orders[#orders+1] = { customer=08, order={'BT','F','S'}  }
orders[#orders+1] = { customer=03, order={'S','BLT','F'}  }
orders[#orders+1] = { customer=09, order={'B','S','BT'}  }
orders[#orders+1] = { customer=02, order={'CM','BL','F'}  }
orders[#orders+1] = { customer=01, order={'F','C','S'}  }
orders[#orders+1] = { customer=04, order={'C','BT'}  }
orders[#orders+1] = { customer=08, order={'S','S','F'}  }
orders[#orders+1] = { customer=06, order={'F','BL','BLT'}  }
orders[#orders+1] = { customer=05, order={'S','C','B'}  }
orders[#orders+1] = { customer=03, order={'BL','BT','S'}  }
orders[#orders+1] = { customer=09, order={'CM','B','F'}  }
orders[#orders+1] = { customer=02, order={'B','C','S'}  }
orders[#orders+1] = { customer=07, order={'BLT','S','F'}  }

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