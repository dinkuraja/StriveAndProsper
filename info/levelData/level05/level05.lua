
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

stars = {440,475,485}

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

orders[#orders+1] = { customer=01, order={'SPW','L'}  }
orders[#orders+1] = { customer=01, order={'TP','I','SCW'}  }
orders[#orders+1] = { customer=01, order={'SCW','L'}  }
orders[#orders+1] = { customer=01, order={'SCW','SCW'}  }
orders[#orders+1] = { customer=01, order={'TP','I'}  }
orders[#orders+1] = { customer=01, order={'SCW','I','SCW'}  }
orders[#orders+1] = { customer=01, order={'L','SCW'}  }
orders[#orders+1] = { customer=01, order={'TP','I','TC'}  }
orders[#orders+1] = { customer=01, order={'I','SCW'}  }
orders[#orders+1] = { customer=01, order={'SPW','L','TC'}  }
orders[#orders+1] = { customer=01, order={'TP','I','L'}  }
orders[#orders+1] = { customer=01, order={'L','SCW'}  }
orders[#orders+1] = { customer=01, order={'SPW',}  }
orders[#orders+1] = { customer=01, order={'SP','I','L'}  }
orders[#orders+1] = { customer=01, order={'SCW','I'}  }
orders[#orders+1] = { customer=01, order={'I','SCW'}  }


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