
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

stars = {1337,1400,1467}

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


orders[#orders+1] = { customer=01, order={ {'W1','W2','G'}}}
orders[#orders+1] = { customer=01, order={ {'H4','S2','C'},{'I','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P4','A'},{'W1','T','B'}}}
orders[#orders+1] = { customer=01, order={ {'W4','W4','H2'}}}
orders[#orders+1] = { customer=01, order={ {'P2','W3','I'}}}
orders[#orders+1] = { customer=01, order={ {'S5','W3','T'}}}
orders[#orders+1] = { customer=01, order={ {'W4','W4'}}}
orders[#orders+1] = { customer=01, order={ {'S2','W3'},{'T','H3'}}}
orders[#orders+1] = { customer=01, order={ {'W4','S5','H5'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','G','C'},{'S2','A'}}}
orders[#orders+1] = { customer=01, order={ {'I','W2','B'}}}
orders[#orders+1] = { customer=01, order={ {'A','B','G'},{'S1','P3','C'}}}
orders[#orders+1] = { customer=01, order={ {'W4','P3','H6'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','G'},{'B','S4','A'}}}
orders[#orders+1] = { customer=01, order={ {'W4','G','C'}}}
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