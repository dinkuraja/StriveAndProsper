
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

stars = {299,331,376}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=04, order={'S','B'}  }
orders[#orders+1] = { customer=07, order={'CM'}  }
orders[#orders+1] = { customer=02, order={'C'}  }
orders[#orders+1] = { customer=09, order={'S','S'}  }
orders[#orders+1] = { customer=08, order={'B'}  }
orders[#orders+1] = { customer=04, order={'C','B'}  }
orders[#orders+1] = { customer=01, order={'S','CM'}  }
orders[#orders+1] = { customer=03, order={'B','B'}  }
orders[#orders+1] = { customer=05, order={'S','C'}  }
orders[#orders+1] = { customer=06, order={'CM'}  }
orders[#orders+1] = { customer=07, order={'B','S'}  }
orders[#orders+1] = { customer=09, order={'CM','CM'}  }
orders[#orders+1] = { customer=01, order={'S','C'}  }

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