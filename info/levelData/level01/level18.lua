
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

stars = {704,821,939}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=02, order={'F'}  }
orders[#orders+1] = { customer=09, order={'CM','B','S'}  }
orders[#orders+1] = { customer=04, order={'BL','C','S'}  }
orders[#orders+1] = { customer=01, order={'S','CM','S'}  }
orders[#orders+1] = { customer=05, order={'C','F','BLT'}  }
orders[#orders+1] = { customer=06, order={'S','BT'}  }
orders[#orders+1] = { customer=07, order={'C','S','B'}  }
orders[#orders+1] = { customer=09, order={'BL','CM','S'}  }
orders[#orders+1] = { customer=04, order={'S','F'}  }
orders[#orders+1] = { customer=08, order={'S','CM','S'}  }
orders[#orders+1] = { customer=03, order={'BL','BT','S'}  }
orders[#orders+1] = { customer=05, order={'S','B','C'}  }
orders[#orders+1] = { customer=02, order={'F','S',}  }
orders[#orders+1] = { customer=01, order={'CM','B'}  }
orders[#orders+1] = { customer=07, order={'BL','S','BLT'}  }
orders[#orders+1] = { customer=04, order={'S','CM','BT'}  }
orders[#orders+1] = { customer=06, order={'C','S'}  }
orders[#orders+1] = { customer=03, order={'B','F','S'}  }

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