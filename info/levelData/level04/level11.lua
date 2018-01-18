
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

stars = {750,790,818}

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

orders[#orders+1] = { customer=01, order={ {'S3','H6','G'}}}
orders[#orders+1] = { customer=01, order={ {'P2'},{'W1','S4'},{'B',"A"} }  }
orders[#orders+1] = { customer=01, order={ {'W5','W4','S1'}}}
orders[#orders+1] = { customer=01, order={ {'S3','C'}}}
orders[#orders+1] = { customer=01, order={ {'C'},{'P2','H1','S4'}}}
orders[#orders+1] = { customer=01, order={ {'B','S5'},{'B','P1'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P2','C'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S5','C'}}}
orders[#orders+1] = { customer=01, order={ {'B','T','G'}}}
orders[#orders+1] = { customer=01, order={ {'P5','S5'},{'T','C'}}}
orders[#orders+1] = { customer=01, order={ {'S2','P5','A'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P4','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H4'}, {'G'}}}
orders[#orders+1] = { customer=01, order={ {'S3','C'}}}

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