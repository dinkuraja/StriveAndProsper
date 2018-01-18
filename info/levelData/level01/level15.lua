
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

stars = {568,629,760}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=06, order={'B','C','S'}  }
orders[#orders+1] = { customer=01, order={'C','CM','S'}  }
orders[#orders+1] = { customer=09, order={'S','BLT','B'}  }
orders[#orders+1] = { customer=03, order={'C','S','B'}  }
orders[#orders+1] = { customer=04, order={'S'}  }
orders[#orders+1] = { customer=07, order={'B','CM'}  }
orders[#orders+1] = { customer=05, order={'BLT','S','C'}  }
orders[#orders+1] = { customer=08, order={'S','C'}  }
orders[#orders+1] = { customer=06, order={'BT','C'}  }
orders[#orders+1] = { customer=04, order={'S','CM'}  }
orders[#orders+1] = { customer=02, order={'BT','C','S'}  }
orders[#orders+1] = { customer=09, order={'S','S'}  }
orders[#orders+1] = { customer=08, order={'BL','C'}  }
orders[#orders+1] = { customer=01, order={'CM','B'}  }
orders[#orders+1] = { customer=03, order={'S','S','BLT'}  }
orders[#orders+1] = { customer=02, order={'CM','S'}  }
orders[#orders+1] = { customer=05, order={'CM','S'}  }

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