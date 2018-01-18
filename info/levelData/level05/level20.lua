
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

stars = {1096,1252,1509}

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

orders[#orders+1] = { customer=01, order={'SPW','L','SPGM'}  }
orders[#orders+1] = { customer=01, order={'SBG','TBG'}  }
orders[#orders+1] = { customer=01, order={'L','TB','SCW'}  }
orders[#orders+1] = { customer=01, order={'SCW','L','I'}  }
orders[#orders+1] = { customer=01, order={'TCG','L','I'}  }
orders[#orders+1] = { customer=01, order={'I','L','SCW'}  }
orders[#orders+1] = { customer=01, order={'SCG','I','L'}  }
orders[#orders+1] = { customer=01, order={'TPM','L','I'}  }
orders[#orders+1] = { customer=01, order={'TPM','TCG'}  }
orders[#orders+1] = { customer=01, order={'I','SPW'}  }
orders[#orders+1] = { customer=01, order={'TBM','TCG','L'}  }
orders[#orders+1] = { customer=01, order={'TPG','TCG','L'}  }
orders[#orders+1] = { customer=01, order={'SBW','I','I'}  }
orders[#orders+1] = { customer=01, order={'TBG','L'}  }
orders[#orders+1] = { customer=01, order={'TPG','SCW'}  }
orders[#orders+1] = { customer=01, order={'SP','TBGM'}  }
orders[#orders+1] = { customer=01, order={'TCM','TPG','L'}  }
orders[#orders+1] = { customer=01, order={'SBW','L','SPW'}  }
orders[#orders+1] = { customer=01, order={'SPM','TPGM','TPGM'}  }


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