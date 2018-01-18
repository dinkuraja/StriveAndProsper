
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

stars = {1600,1625,1647}

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



orders[#orders+1] = { customer=01, order={ {'H1','P1','W5'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P3','C'},{'W2','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H3','G'}}}
orders[#orders+1] = { customer=01, order={ {'W6','W1'}}}
orders[#orders+1] = { customer=01, order={ {'S3','I','C'},{'H5','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','P3','H6'}}}
orders[#orders+1] = { customer=01, order={ {'P4','W6','I'}}}
orders[#orders+1] = { customer=01, order={ {'S5','P1','A'},{'W2','T','T'}}}
orders[#orders+1] = { customer=01, order={ {'S3','P3','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W5','S2'}}}
orders[#orders+1] = { customer=01, order={ {'T','S6','C'},{'A','G'}}}
orders[#orders+1] = { customer=01, order={ {'I','W4','B'}}}
orders[#orders+1] = { customer=01, order={ {'P4','H4','A'},{'G','B','C'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P4','W4'}}}
orders[#orders+1] = { customer=01, order={ {'W3','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'T','P3','B'},{'G','S4','A'}}}
orders[#orders+1] = { customer=01, order={ {'S1','W2','H1'},{'B','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S1','H3'}}}
orders[#orders+1] = { customer=01, order={ {'T','H2','S2'},{'P3','G','C'}}}

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