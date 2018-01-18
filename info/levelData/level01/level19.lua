
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

stars = {751,876,1001}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=04, order={'F','S'}  }
orders[#orders+1] = { customer=06, order={'BL','C','S'}  }
orders[#orders+1] = { customer=08, order={'S','CM','S'}  }
orders[#orders+1] = { customer=05, order={'C','B','F'}  }
orders[#orders+1] = { customer=02, order={'S','BLT','BL'}  }
orders[#orders+1] = { customer=03, order={'S','F'}  }
orders[#orders+1] = { customer=07, order={'C','B'}  }
orders[#orders+1] = { customer=01, order={'S','B','S'}  }
orders[#orders+1] = { customer=09, order={'BL','F'}  }
orders[#orders+1] = { customer=08, order={'C','CM','S'}  }
orders[#orders+1] = { customer=05, order={'S','B','S'}  }
orders[#orders+1] = { customer=06, order={'F','BL','C'}  }
orders[#orders+1] = { customer=04, order={'C','BLT','S'}  }
orders[#orders+1] = { customer=07, order={'CM','C'}  }
orders[#orders+1] = { customer=03, order={'BLT','S','B'}  }
orders[#orders+1] = { customer=08, order={'S','CM','BT'}  }
orders[#orders+1] = { customer=02, order={'C','S','F'}  }
orders[#orders+1] = { customer=09, order={'S','CM'}  }
orders[#orders+1] = { customer=01, order={'BLT','F','S'}  }

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