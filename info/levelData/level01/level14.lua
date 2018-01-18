
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

stars = {515,572,692}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=09, order={'S'}  }
orders[#orders+1] = { customer=07, order={'BLT','S','S'}  }
orders[#orders+1] = { customer=01, order={'B','CM','C'}  }
orders[#orders+1] = { customer=04, order={'BL','S'}  }
orders[#orders+1] = { customer=03, order={'S','C'}  }
orders[#orders+1] = { customer=02, order={'S','B'}  }
orders[#orders+1] = { customer=05, order={'BT','C','S'}  }
orders[#orders+1] = { customer=06, order={'B','CM'}  }
orders[#orders+1] = { customer=07, order={'S','BLT'}  }
orders[#orders+1] = { customer=08, order={'B','BL','S'}  }
orders[#orders+1] = { customer=09, order={'BT'}  }
orders[#orders+1] = { customer=04, order={'C','B'}  }
orders[#orders+1] = { customer=02, order={'S','BT','CM'}  }
orders[#orders+1] = { customer=01, order={'C','S','B'}  }
orders[#orders+1] = { customer=06, order={'BTL','S'}  }
orders[#orders+1] = { customer=07, order={'BT','S'}  }

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