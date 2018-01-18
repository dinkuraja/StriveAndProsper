
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

stars = {1100,1260,1332}

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


orders[#orders+1] = { customer=01, order={ {'S3','A'},{'B','G','I'}}}
orders[#orders+1] = { customer=01, order={ {'T','W3','I'}}}
orders[#orders+1] = { customer=01, order={ {'S2','H4','G'}}}
orders[#orders+1] = { customer=01, order={ {'B','S1','A'},{'T','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'W3','G'}}}
orders[#orders+1] = { customer=01, order={ {'W6','P4','H6'}}}
orders[#orders+1] = { customer=01, order={ {'S1','P3','I'}}}
orders[#orders+1] = { customer=01, order={ {'I','S1'},{'H3','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'B','P5','A'},{'W1','S4','B'}}}
orders[#orders+1] = { customer=01, order={ {'W5','W4','S5'}}}
orders[#orders+1] = { customer=01, order={ {'I','W3'},{'S2',"H2"}}}
orders[#orders+1] = { customer=01, order={ {'S5','W2'}}}
orders[#orders+1] = { customer=01, order={ {'S3','W2','B'}}}
orders[#orders+1] = { customer=01, order={ {'W5'}}}
orders[#orders+1] = { customer=01, order={ {'S3','W5'},{'W2','G'}}}
orders[#orders+1] = { customer=01, order={ {'P4','H2','G'}}}
orders[#orders+1] = { customer=01, order={ {'B','W2','A'}}}
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