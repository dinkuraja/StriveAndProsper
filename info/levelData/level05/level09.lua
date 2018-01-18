
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

stars = {555,615,628}

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

orders[#orders+1] = { customer=01, order={'SCG','L'}  }
orders[#orders+1] = { customer=01, order={'TPG','SCW'}  }
orders[#orders+1] = { customer=01, order={'I','SPW'}  }
orders[#orders+1] = { customer=01, order={'I','L','SCW'}  }
orders[#orders+1] = { customer=01, order={'TC','TP','I'}  }
orders[#orders+1] = { customer=01, order={'TPM','TC','L'}  }
orders[#orders+1] = { customer=01, order={'TC','TPM'}  }
orders[#orders+1] = { customer=01, order={'L','SPW','SCW'}  }
orders[#orders+1] = { customer=01, order={'SCW','I'}  }
orders[#orders+1] = { customer=01, order={'TCG','SPW','L'}  }
orders[#orders+1] = { customer=01, order={'TP','SCW'}  }
orders[#orders+1] = { customer=01, order={'TC','I','SPW'}  }
orders[#orders+1] = { customer=01, order={'SC','I'}  }
orders[#orders+1] = { customer=01, order={'SCW','L'}  }
orders[#orders+1] = { customer=01, order={'L','TPG'}  }

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