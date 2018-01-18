
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

stars = {980,1000,1198}

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

orders[#orders+1] = { customer=01, order={ {'I','S2','C'}}}
orders[#orders+1] = { customer=01, order={ {'P3','C','A'},{'W1','S4','B'}}}
orders[#orders+1] = { customer=01, order={ {'W5','W4','S5'}}}
orders[#orders+1] = { customer=01, order={ {'W4','S4'},{'W3',"H1"}}}
orders[#orders+1] = { customer=01, order={ {'W1','P1','C'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S5','C'}}}
orders[#orders+1] = { customer=01, order={ {'B','I','G'}}}
orders[#orders+1] = { customer=01, order={ {'S6','P4','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H4','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'P3','S5','B'},{'T','C','C'}}}
orders[#orders+1] = { customer=01, order={ {'S1','I'},{'B','G','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','S4'},{'B','P1','C'}}}
orders[#orders+1] = { customer=01, order={ {'S3','H2','G'}}}
orders[#orders+1] = { customer=01, order={ {'S2','C','G'}}}
orders[#orders+1] = { customer=01, order={ {'I','S1'},{'H3','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'W6','P4','H6'}}}

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