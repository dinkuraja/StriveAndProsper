
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

stars = {395,440,532}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=09, order={'S','BL'}  }
orders[#orders+1] = { customer=02, order={'C','S'}  }
orders[#orders+1] = { customer=06, order={'S','S'}  }
orders[#orders+1] = { customer=03, order={'B','C'}  }
orders[#orders+1] = { customer=01, order={'CM'}  }
orders[#orders+1] = { customer=05, order={'C','BL'}  }
orders[#orders+1] = { customer=02, order={'S','B'}  }
orders[#orders+1] = { customer=04, order={'CM','S'}  }
orders[#orders+1] = { customer=06, order={'S','B'}  }
orders[#orders+1] = { customer=07, order={'S','S'}  }
orders[#orders+1] = { customer=08, order={'BL','CM'}  }
orders[#orders+1] = { customer=09, order={'C','S'}  }
orders[#orders+1] = { customer=03, order={'S','B'}  }
orders[#orders+1] = { customer=01, order={'C','BL'}  }
orders[#orders+1] = { customer=02, order={'S','CM'}  }

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