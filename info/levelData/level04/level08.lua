
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

stars = {560,578,604}

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

orders[#orders+1] = { customer=01, order={ {'T','P3','S1'} }  }
orders[#orders+1] = { customer=01, order={ {'S3','H6'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'P6','C','B'} }  }
orders[#orders+1] = { customer=01, order={ {'W3','T'} }  }
orders[#orders+1] = { customer=01, order={ {'B','S1'},{'P2'} }  }
orders[#orders+1] = { customer=01, order={ {'H5'},{'T','S3'} }  }
orders[#orders+1] = { customer=01, order={ {'W4','S1','C'} }  }
orders[#orders+1] = { customer=01, order={ {'P1','S6','C'} }  }
orders[#orders+1] = { customer=01, order={ {'P3'},{'P2','W1'} }  }
orders[#orders+1] = { customer=01, order={ {'B','W2'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'P4','C','T'} }  }
orders[#orders+1] = { customer=01, order={ {'C'},{'S2'} }  }
orders[#orders+1] = { customer=01, order={ {'S1','C'} }  }
orders[#orders+1] = { customer=01, order={ {'S2','S1','C'} }  }
orders[#orders+1] = { customer=01, order={ {'H4'},{'B','S1'} }  }
orders[#orders+1] = { customer=01, order={ {'S1'},{'C','P2'} }  }

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