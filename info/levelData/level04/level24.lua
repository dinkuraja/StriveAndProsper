
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

stars = {1550,1589,1627}

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

orders[#orders+1] = { customer=01, order={ {'T','A','C'},{'S2','G'}}}
orders[#orders+1] = { customer=01, order={ {'I','W5','T'}}}
orders[#orders+1] = { customer=01, order={ {'P5','B','A'},{'G','H5','C'}}}
orders[#orders+1] = { customer=01, order={ {'S6','P6','W6'}}}
orders[#orders+1] = { customer=01, order={ {'T','P3','B'},{'G','S4','A'}}}
orders[#orders+1] = { customer=01, order={ {'W5','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P2','W2'}}}
orders[#orders+1] = { customer=01, order={ {'H2','W1','C'},{'P1','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H3','G'}}}
orders[#orders+1] = { customer=01, order={ {'S3','I','C'},{'H5','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'W1','P5','H4'}}}
orders[#orders+1] = { customer=01, order={ {'P4','W6','I'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P4','A'},{'W1','B','B'}}}
orders[#orders+1] = { customer=01, order={ {'S6','P6','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W5','S2'}}}
orders[#orders+1] = { customer=01, order={ {'S1','W2','H1'},{'T','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S1','H3'}}}
orders[#orders+1] = { customer=01, order={ {'T','S1','H1'},{'C','P2','G'}}}


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