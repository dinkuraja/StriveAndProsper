
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

stars = {400,420,439}

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

orders[#orders+1] = { customer=01, order={ {'P4','C'} }  }
orders[#orders+1] = { customer=01, order={ {'B','S3'} }  }
orders[#orders+1] = { customer=01, order={ {'P3','B'} }  }
orders[#orders+1] = { customer=01, order={ {'S2','B'},{'P2'} }  }
orders[#orders+1] = { customer=01, order={ {'P2','C'} }  }
orders[#orders+1] = { customer=01, order={ {'B'},{'S5'} }  }
orders[#orders+1] = { customer=01, order={ {'S1'},{'S4','B'} }  }
orders[#orders+1] = { customer=01, order={ {'S5'} }  }
orders[#orders+1] = { customer=01, order={ {'P4'} }  }
orders[#orders+1] = { customer=01, order={ {'P2','S2'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'P5','S6'} }  }
orders[#orders+1] = { customer=01, order={ {'S2'},{'P3','B'} }  }
orders[#orders+1] = { customer=01, order={ {'P3','C'} }  }

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