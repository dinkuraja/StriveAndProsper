
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

stars = {270,300,328}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- C = Coffee, B = Black Adidas, T = Tan Adidas 
-- S = Shirt, P = Pants, W = Sweater, H = Hat
-- I = iPhone Case, A = Application, G = Gift
-- Colors: 1-6 (see refernce)
-- Example: {'C','B','S1'},{D},{'A','G'}
-- Example: {'W2','H3','I'}
-- IMPORTANT: Any clothing item MUST HAVE a color number

orders[#orders+1] = { customer=01, order={ {'P2'} }  }
orders[#orders+1] = { customer=01, order={ {'S1'} }  }
orders[#orders+1] = { customer=01, order={ {'B'} }  }
orders[#orders+1] = { customer=01, order={ {'P5'} }  }
orders[#orders+1] = { customer=01, order={ {'S5'} }  }
orders[#orders+1] = { customer=01, order={ {'B'} }  }
orders[#orders+1] = { customer=01, order={ {'P1'},{'P2','S4'} }  }
orders[#orders+1] = { customer=01, order={ {'S2'} }  }
orders[#orders+1] = { customer=01, order={ {'S1'},{'S5'} }  }
orders[#orders+1] = { customer=01, order={ {'B'} }  }
orders[#orders+1] = { customer=01, order={ {'S3'} }  }
orders[#orders+1] = { customer=01, order={ {'B','P6'},{'P2'} }  }
orders[#orders+1] = { customer=01, order={ {'P4'} }  }

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