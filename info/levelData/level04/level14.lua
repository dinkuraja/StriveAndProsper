
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

stars = {920,940,969}

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

orders[#orders+1] = { customer=01, order={ {'B','T','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S3'},{'W3',"H1",'A'}}}
orders[#orders+1] = { customer=01, order={ {'S6','P4','W6'}}}
orders[#orders+1] = { customer=01, order={ {'H4','P2','G'}}}
orders[#orders+1] = { customer=01, order={ {'P3','S5','B'},{'T','C','C'}}}
orders[#orders+1] = { customer=01, order={ {'S1','C'},{'B','G'}}}
orders[#orders+1] = { customer=01, order={ {'B','S5','A'},{'T','P1','C'}}}
orders[#orders+1] = { customer=01, order={ {'S1','H4','G'}}}
orders[#orders+1] = { customer=01, order={ {'S2','C','G'}}}
orders[#orders+1] = { customer=01, order={ {'C','S1','A'},{'H3','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'P2','C'},{'W1','S4','B'}}}
orders[#orders+1] = { customer=01, order={ {'W5','W4','S5'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P2','C'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S5','C'}}}


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