
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

stars = {1270,1300,1398}

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

orders[#orders+1] = { customer=01, order={ {'P3','W5','I'}}}
orders[#orders+1] = { customer=01, order={ {'S4','W6','T'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W4'}}}
orders[#orders+1] = { customer=01, order={ {'S3','T'},{'W5','H3'}}}
orders[#orders+1] = { customer=01, order={ {'W3','S6','H5'}}}
orders[#orders+1] = { customer=01, order={ {'B','P3','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','G','C'},{'S3','A'}}}
orders[#orders+1] = { customer=01, order={ {'I','W2','B'}}}
orders[#orders+1] = { customer=01, order={ {'S2','B','P4'},{'A','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H5','G'}}}
orders[#orders+1] = { customer=01, order={ {'I','S1','C'},{'H3','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'B','P5','A'},{'S5','W1','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W3','H6'}}}
orders[#orders+1] = { customer=01, order={ {'W4','P3','H6'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','G'},{'B','S4','A'}}}
orders[#orders+1] = { customer=01, order={ {'W4','G'}}}
orders[#orders+1] = { customer=01, order={ {'H3','P6','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H4','W4'},{'P1','I','C'}}}


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