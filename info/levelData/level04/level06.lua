
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

stars = {440,460,473}

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

orders[#orders+1] = { customer=01, order={ {'P1','W2'},{'B','C'} }  }
orders[#orders+1] = { customer=01, order={ {'S4','S2'} }  }
orders[#orders+1] = { customer=01, order={ {'S1','B'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'P3'},{'P1','S3'} }  }
orders[#orders+1] = { customer=01, order={ {'S3','B'},{'W1'} }  }
orders[#orders+1] = { customer=01, order={ {'B','P5','C'} }  }
orders[#orders+1] = { customer=01, order={ {'W4'},{'P5','B'} }  }
orders[#orders+1] = { customer=01, order={ {'P2','B'},{'S1','B'} }  }
orders[#orders+1] = { customer=01, order={ {'B','W5'},{'C','S4'} }  }
orders[#orders+1] = { customer=01, order={ {'P2','C'} }  }
orders[#orders+1] = { customer=01, order={ {'S1','C'},{'P2','B'} }  }
orders[#orders+1] = { customer=01, order={ {'P4','S4','S2'}}}
orders[#orders+1] = { customer=01, order={ {'S1'},{'W2','C'},{'P3'} }  }
orders[#orders+1] = { customer=01, order={ {'P1','S4','C'} }  }

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