
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

stars = {673,785,897}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- S = Soda, F = Fries, B = Burger, C = Chicken, 
-- M = Mango, L = Lettuce, T = Tomato
-- Example: {'S', 'F', 'BLT'}
-- Example: {'BL', 'CM', 'S'}

orders[#orders+1] = { customer=05, order={'BLT','S'}  }
orders[#orders+1] = { customer=04, order={'CM','B','S'}  }
orders[#orders+1] = { customer=06, order={'S','S','C'}  }
orders[#orders+1] = { customer=03, order={'S','C'}  }
orders[#orders+1] = { customer=07, order={'BL','C'}  }
orders[#orders+1] = { customer=02, order={'CM','S','BT'}  }
orders[#orders+1] = { customer=08, order={'BL','C'}  }
orders[#orders+1] = { customer=01, order={'B','C'}  }
orders[#orders+1] = { customer=09, order={'S','S'}  }
orders[#orders+1] = { customer=04, order={'S','BL','C'}  }
orders[#orders+1] = { customer=03, order={'BT','CM','S'}  }
orders[#orders+1] = { customer=02, order={'C','S'}  }
orders[#orders+1] = { customer=05, order={'S','C'}  }
orders[#orders+1] = { customer=06, order={'CM','C'}  }
orders[#orders+1] = { customer=07, order={'BT','S','B'}  }
orders[#orders+1] = { customer=08, order={'S','C','BL'}  }
orders[#orders+1] = { customer=01, order={'CM','S'}  }
orders[#orders+1] = { customer=04, order={'S','B'}  }

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