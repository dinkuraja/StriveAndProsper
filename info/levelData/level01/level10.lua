
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

stars = {336,370,420}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=05, order={'S','B'}  }
orders[#orders+1] = { customer=04, order={'CM','B'}  }
orders[#orders+1] = { customer=03, order={'C','S'}  }
orders[#orders+1] = { customer=02, order={'S','C'}  }
orders[#orders+1] = { customer=01, order={'S'}  }
orders[#orders+1] = { customer=09, order={'CM','S'}  }
orders[#orders+1] = { customer=08, order={'S','C'}  }
orders[#orders+1] = { customer=07, order={'B','S'}  }
orders[#orders+1] = { customer=04, order={'S','B'}  }
orders[#orders+1] = { customer=06, order={'C','CM'}  }
orders[#orders+1] = { customer=05, order={'B','B'}  }
orders[#orders+1] = { customer=01, order={'S','S'}  }
orders[#orders+1] = { customer=07, order={'B','CM'}  }
orders[#orders+1] = { customer=03, order={'S','B'}  }

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