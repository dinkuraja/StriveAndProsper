
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

stars = {1460,1500,1560}

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

orders[#orders+1] = { customer=01, order={ {'S3','P3','A'},{'W2','B','T'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P4','T'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W5','S2'}}}
orders[#orders+1] = { customer=01, order={ {'S1','W1','H1'},{'B','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'W5','S6','H4'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','G','C'},{'S2','A'}}}
orders[#orders+1] = { customer=01, order={ {'W4','W3','G'}}}
orders[#orders+1] = { customer=01, order={ {'S3','I','C'},{'H5','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'W1','P5','H4'}}}
orders[#orders+1] = { customer=01, order={ {'P5','W5','I'}}}
orders[#orders+1] = { customer=01, order={ {'I','W3','T'}}}
orders[#orders+1] = { customer=01, order={ {'P5','B','A'},{'G','H5','C'}}}
orders[#orders+1] = { customer=01, order={ {'S5','P5','W5'}}}
orders[#orders+1] = { customer=01, order={ {'T','P1','B'},{'G','S3','A'}}}
orders[#orders+1] = { customer=01, order={ {'W3','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'H6','P6','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H2','W1'},{'P1','I','C'}}}

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