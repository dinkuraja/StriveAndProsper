
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

stars = {648,756,864}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=07, order={'S','S'}  }
orders[#orders+1] = { customer=02, order={'C','BL'}  }
orders[#orders+1] = { customer=03, order={'S','CM','BLT'}  }
orders[#orders+1] = { customer=09, order={'B','C'}  }
orders[#orders+1] = { customer=01, order={'S','S','B'}  }
orders[#orders+1] = { customer=08, order={'C','S'}  }
orders[#orders+1] = { customer=04, order={'BL','BT'}  }
orders[#orders+1] = { customer=06, order={'S','CM'}  }
orders[#orders+1] = { customer=05, order={'B','B'}  }
orders[#orders+1] = { customer=07, order={'S','C','S'}  }
orders[#orders+1] = { customer=09, order={'BLT','CM','C'}  }
orders[#orders+1] = { customer=08, order={'S','B'}  }
orders[#orders+1] = { customer=02, order={'BT','S','CM'}  }
orders[#orders+1] = { customer=01, order={'C','S'}  }
orders[#orders+1] = { customer=06, order={'S','CM','BT'}  }
orders[#orders+1] = { customer=04, order={'B','S','S'}  }
orders[#orders+1] = { customer=05, order={'C','BT'}  }

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