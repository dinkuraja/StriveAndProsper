
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

stars = {1670,1690,1716}

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

orders[#orders+1] = { customer=01, order={ {'T','H3','S3'},{'P2','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'H1','P2','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H4','P5','C'},{'W6','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S4','G'}}}
orders[#orders+1] = { customer=01, order={ {'W5','W3'}}}
orders[#orders+1] = { customer=01, order={ {'S2','I','C'},{'H4','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'P2','W2','S4'}}}
orders[#orders+1] = { customer=01, order={ {'P3','W2','I'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P5','A'},{'W4','B','B'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S1','B'}}}
orders[#orders+1] = { customer=01, order={ {'W4','W6','S6'}}}
orders[#orders+1] = { customer=01, order={ {'T','S5','C'},{'A','G','I'}}}
orders[#orders+1] = { customer=01, order={ {'I','W3','B'}}}
orders[#orders+1] = { customer=01, order={ {'P4','W4','C'},{'G','B','A'}}}
orders[#orders+1] = { customer=01, order={ {'S2','P2','W6'}}}
orders[#orders+1] = { customer=01, order={ {'W6','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'T','P1','S5'},{'G','T','A'}}}
orders[#orders+1] = { customer=01, order={ {'S3','W3','H1'},{'T','P3','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S1','H3'}}}

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