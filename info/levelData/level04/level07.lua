
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

stars = {519,535,556}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- C = Coffee, B = Black Adidas, T = Tan Adidas 
-- S = Shirt, P = Pants, W = Sweater, H = Hat
-- I = iPhone Case, A = Application, G = Gift
-- Colors: 1-6 (see refernce)
-- Example: {'C','B','S1'},{'A','G'}
-- Example: {'W2','H3','I'}
-- IMPORTANT: Any clothing item MUST HAVE a color number

orders[#orders+1] = { customer=01, order={ {'B','C'},{'S5','W3'} }  }
orders[#orders+1] = { customer=01, order={ {'S1','B'} }  }
orders[#orders+1] = { customer=01, order={ {'P2','P3'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'W3','S1','B'} }  }
orders[#orders+1] = { customer=01, order={ {'W1','C'} }  }
orders[#orders+1] = { customer=01, order={ {'S2','P4'} }  }
orders[#orders+1] = { customer=01, order={ {'B','W2','C'} }  }
orders[#orders+1] = { customer=01, order={ {'P4'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'C'},{'S1'} }  }
orders[#orders+1] = { customer=01, order={ {'P5','S5','B'} }  }
orders[#orders+1] = { customer=01, order={ {'C','S2','P1'} }  }
orders[#orders+1] = { customer=01, order={ {'P4'},{'B','S1'} }  }
orders[#orders+1] = { customer=01, order={ {'S1'},{'C'} }  }

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