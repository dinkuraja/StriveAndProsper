
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

stars = {786,917,1048}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=09, order={'B','S','CM'}  }
orders[#orders+1] = { customer=07, order={'BT','B','S'}  }
orders[#orders+1] = { customer=02, order={'F','C','S'}  }
orders[#orders+1] = { customer=05, order={'CM','F','S'}  }
orders[#orders+1] = { customer=08, order={'BLT','S','C'}  }
orders[#orders+1] = { customer=06, order={'S','CM','B'}  }
orders[#orders+1] = { customer=04, order={'F','S'}  }
orders[#orders+1] = { customer=02, order={'CM','C','S'}  }
orders[#orders+1] = { customer=01, order={'S','F'}  }
orders[#orders+1] = { customer=03, order={'BT','F','B'}  }
orders[#orders+1] = { customer=05, order={'C','S','S'}  }
orders[#orders+1] = { customer=07, order={'B','CM','F'}  }
orders[#orders+1] = { customer=09, order={'S','BT','S'}  }
orders[#orders+1] = { customer=06, order={'CM','F','BLT'}  }
orders[#orders+1] = { customer=01, order={'BT','S','C'}  }
orders[#orders+1] = { customer=04, order={'B','CM','S'}  }
orders[#orders+1] = { customer=03, order={'S','C','F'}  }
orders[#orders+1] = { customer=07, order={'S','BT'}  }
orders[#orders+1] = { customer=05, order={'CM','S','S'}  }

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