
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

stars = {360,380,390}

-- Order Information --------------------------------------> Order Information:

-----------------------------------------------
-- I = Iced Tea, L = Lemonade, 
-- C = Chicken, P = Pork, B = Brisket, 
-- M = Mac and Cheese, G = Greens, W = Waffle
-- S = To Stay, T = Take Out
-----------------------------------------------
-- IMPORTANT: All meals MUST HAVE: 
-- S/T in first position (stay/takeout), 
-- C/P/B in second (chicken/pork/beef), 
-- M/G/W after (mac/greens/waffle) - Greens ALWAYS before Mac
-----------------------------------------------
-- Example: {'SCW'} = To Stay, Chicken, Waffle
-- Example: {'TBMG'} = Take Out, Brisket, Mac, Greens
-- Example: {'TPM'} = Take Out, Pork, Mac
-----------------------------------------------

orders[#orders+1] = { customer=01, order={'TC','I'}  }
orders[#orders+1] = { customer=01, order={'SCW','L'}  }
orders[#orders+1] = { customer=01, order={'I','SC'}  }
orders[#orders+1] = { customer=01, order={'SCW','I'}  }
orders[#orders+1] = { customer=01, order={'SCW','I','TC'}  }
orders[#orders+1] = { customer=01, order={'L','TC'}  }
orders[#orders+1] = { customer=01, order={'SCW'}  }
orders[#orders+1] = { customer=01, order={'I','SCW'}  }
orders[#orders+1] = { customer=01, order={'TC','L'}  }
orders[#orders+1] = { customer=01, order={'I','SCW'}  }
orders[#orders+1] = { customer=01, order={'L','I'}  }
orders[#orders+1] = { customer=01, order={'TC','I','SCW'}  }
orders[#orders+1] = { customer=01, order={'SCW','L'}  }

--[[
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'SPGM','TPG'}  }

orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
orders[#orders+1] = { customer=02, order={'I','L'}  }
--]]

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