
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

stars = {2700,2900,3423}

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

orders[#orders+1] = { customer=01, order={'SPG','TBGM','I'}  }
orders[#orders+1] = { customer=01, order={'SCG','I','L'}  }
orders[#orders+1] = { customer=01, order={'TPM','TBGM','I'}  }
orders[#orders+1] = { customer=01, order={'L','SCW','SCGM'}  }
orders[#orders+1] = { customer=01, order={'SBW','TPGM','TCM'}  }
orders[#orders+1] = { customer=01, order={'L','SPW','TCM'}  }
orders[#orders+1] = { customer=01, order={'SBW','TBGM','I'}  }
orders[#orders+1] = { customer=01, order={'I','SPW','TCG'}  }
orders[#orders+1] = { customer=01, order={'L','SPG','TPGM'}  }
orders[#orders+1] = { customer=01, order={'TBM','TCG','L'}  }
orders[#orders+1] = { customer=01, order={'TPG','TCG','L'}  }
orders[#orders+1] = { customer=01, order={'TPM','TCG','I'}  }
orders[#orders+1] = { customer=01, order={'SCG','SPG','SPW'}  }
orders[#orders+1] = { customer=01, order={'TPG','TCG','L'}  }
orders[#orders+1] = { customer=01, order={'TCM','TPG','L'}  }
orders[#orders+1] = { customer=01, order={'SBW','TPGM','TCM'}  }
orders[#orders+1] = { customer=01, order={'I','L','SCW'}  }
orders[#orders+1] = { customer=01, order={'TBG','L','I'}  }
orders[#orders+1] = { customer=01, order={'SBW','SPGM','TBM'}  }
orders[#orders+1] = { customer=01, order={'TPG','SCW',"I"}  }
orders[#orders+1] = { customer=01, order={'SCM','L','SPW'}  }
orders[#orders+1] = { customer=01, order={'L','SBM','SPW'}  }
orders[#orders+1] = { customer=01, order={'TBG','TBGM','I'}  }

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