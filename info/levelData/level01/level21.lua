
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

stars = {928,1106,1213}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=09, order={'CM','S','S'}  }
orders[#orders+1] = { customer=07, order={'BLT','F'}  }
orders[#orders+1] = { customer=02, order={'BL','S','BT'}  }
orders[#orders+1] = { customer=05, order={'S','F','C'}  }
orders[#orders+1] = { customer=08, order={'CM','S','C'}  }
orders[#orders+1] = { customer=06, order={'S','BL','B'}  }
orders[#orders+1] = { customer=04, order={'CM','F','S'}  }
orders[#orders+1] = { customer=02, order={'B','C','BT'}  }
orders[#orders+1] = { customer=01, order={'S','F','S'}  }
orders[#orders+1] = { customer=03, order={'S','F','F'}  }
orders[#orders+1] = { customer=05, order={'CM','S','BT'}  }
orders[#orders+1] = { customer=07, order={'S','C','F'}  }
orders[#orders+1] = { customer=09, order={'B','CM','S'}  }
orders[#orders+1] = { customer=06, order={'C','BLT','S'}  }
orders[#orders+1] = { customer=01, order={'BL','S','F'}  }
orders[#orders+1] = { customer=04, order={'BT','C','S'}  }
orders[#orders+1] = { customer=03, order={'S','C','F'}  }
orders[#orders+1] = { customer=07, order={'S','S','BL'}  }
orders[#orders+1] = { customer=05, order={'CM','C','B'}  }
orders[#orders+1] = { customer=05, order={'BLT','F','S'}  }

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