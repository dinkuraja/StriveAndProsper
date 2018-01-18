
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

stars = {485,539,651}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=04, order={'B','S'}  }
orders[#orders+1] = { customer=01, order={'C','S'}  }
orders[#orders+1] = { customer=02, order={'S','CM'}  }
orders[#orders+1] = { customer=08, order={'BLT','S'}  }
orders[#orders+1] = { customer=07, order={'S','BL'}  }
orders[#orders+1] = { customer=06, order={'BT','S'}  }
orders[#orders+1] = { customer=03, order={'S','CM','S'}  }
orders[#orders+1] = { customer=05, order={'BL','C'}  }
orders[#orders+1] = { customer=09, order={'B','C','S'}  }
orders[#orders+1] = { customer=02, order={'S','BT','CM'}  }
orders[#orders+1] = { customer=07, order={'BL','S'}  }
orders[#orders+1] = { customer=08, order={'C','B'}  }
orders[#orders+1] = { customer=04, order={'S','BT'}  }
orders[#orders+1] = { customer=09, order={'CM','S'}  }
orders[#orders+1] = { customer=03, order={'BTL'}  }
orders[#orders+1] = { customer=01, order={'B','CM'}  }

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