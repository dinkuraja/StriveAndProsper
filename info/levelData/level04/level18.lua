
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

stars = {1255,1280,1337}

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

orders[#orders+1] = { customer=01, order={ {'I','W2','B'}}}
orders[#orders+1] = { customer=01, order={ {'S2','B'},{'A','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H5','G'}}}
orders[#orders+1] = { customer=01, order={ {'I','S1','C'},{'H3','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'B','P5','A'},{'S5','W1','T'}}}
orders[#orders+1] = { customer=01, order={ {'S2','S2','W4'}}}
orders[#orders+1] = { customer=01, order={ {'W4','P3','C'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','G'},{'B','S4','A'}}}
orders[#orders+1] = { customer=01, order={ {'W4','G'}}}
orders[#orders+1] = { customer=01, order={ {'H3','P6','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H5','W5'},{'S2','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'P2','W4','I'}}}
orders[#orders+1] = { customer=01, order={ {'S1','W4','T'}}}
orders[#orders+1] = { customer=01, order={ {'W6','A'}}}
orders[#orders+1] = { customer=01, order={ {'S2','G'},{'H1','W4'}}}
orders[#orders+1] = { customer=01, order={ {'P3','H6','G'}}}
orders[#orders+1] = { customer=01, order={ {'B','P3','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','G','C'},{'S3','A'}}}

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