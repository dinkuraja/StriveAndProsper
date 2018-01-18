
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

stars = {951,1134,1244}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=05, order={'BT','S','C'}  }
orders[#orders+1] = { customer=04, order={'B','F','S'}  }
orders[#orders+1] = { customer=03, order={'CM','B','F'}  }
orders[#orders+1] = { customer=02, order={'S','F','S'}  }
orders[#orders+1] = { customer=01, order={'BLT','S','F'}  }
orders[#orders+1] = { customer=06, order={'CM','B','B'}  }
orders[#orders+1] = { customer=07, order={'S','F','S'}  }
orders[#orders+1] = { customer=08, order={'C','BL','BLT'}  }
orders[#orders+1] = { customer=09, order={'BT','CM','S'}  }
orders[#orders+1] = { customer=05, order={'CM','BLT','F'}  }
orders[#orders+1] = { customer=04, order={'C','S','B'}  }
orders[#orders+1] = { customer=06, order={'S','C','BLT'}  }
orders[#orders+1] = { customer=03, order={'F','CM','S'}  }
orders[#orders+1] = { customer=01, order={'CM','B','S'}  }
orders[#orders+1] = { customer=02, order={'F','S','BT'}  }
orders[#orders+1] = { customer=07, order={'B','B','S'}  }
orders[#orders+1] = { customer=05, order={'S','F','S'}  }
orders[#orders+1] = { customer=09, order={'BT','BLT','F'}  }
orders[#orders+1] = { customer=06, order={'C','S','S'}  }
orders[#orders+1] = { customer=08, order={'CM','F','F'}  }

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