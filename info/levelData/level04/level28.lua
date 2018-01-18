
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

stars = {1700,1800,1897}

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


orders[#orders+1] = { customer=01, order={ {'W4','W1'}}}
orders[#orders+1] = { customer=01, order={ {'S6','I','C'},{'H2','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'T','Ω5','S5'},{'P2','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'H3','P4','W6'}}}
orders[#orders+1] = { customer=01, order={ {'W5','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'G','T','A'},{'T','P3','S4'}}}
orders[#orders+1] = { customer=01, order={ {'B','P3','G'},{'S3','W3','H1'}}}
orders[#orders+1] = { customer=01, order={ {'W3','S5','H6'}}}
orders[#orders+1] = { customer=01, order={ {'W4','S2','G'}}}
orders[#orders+1] = { customer=01, order={ {'H1','P3','C'},{'W5','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'P6','W3','S2'}}}
orders[#orders+1] = { customer=01, order={ {'P5','W4','I'}}}
orders[#orders+1] = { customer=01, order={ {'S1','P2','A'},{'W3','T','T'}}}
orders[#orders+1] = { customer=01, order={ {'P2','S2','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','S4','W4'}}}
orders[#orders+1] = { customer=01, order={ {'A','G','I'},{'T','S5','C'}}}
orders[#orders+1] = { customer=01, order={ {'I','W5','B'}}}
orders[#orders+1] = { customer=01, order={ {'P2','W2','C'},{'G','T','A'}}}
orders[#orders+1] = { customer=01, order={ {'S2','P2','W6'}}}



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