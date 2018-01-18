
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

stars = {800,830,844}

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

orders[#orders+1] = { customer=01, order={ {'H1','G','A'},{'C','P2'}}}
orders[#orders+1] = { customer=01, order={ {'S1','H4','G'}}}
orders[#orders+1] = { customer=01, order={ {'B','S5'},{'B','P1'}}}
orders[#orders+1] = { customer=01, order={ {'P2'},{'W1','S4','A'},{'B'}}}
orders[#orders+1] = { customer=01, order={ {'W5','W4','S5'}}}
orders[#orders+1] = { customer=01, order={ {'S2','C','G'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P2','C'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S5','C'}}}
orders[#orders+1] = { customer=01, order={ {'B','T','G'}}}
orders[#orders+1] = { customer=01, order={ {'P6','S6'},{'T','C','A'}}}
orders[#orders+1] = { customer=01, order={ {'S2','P5','W2'}}}
orders[#orders+1] = { customer=01, order={ {'H2','P4','G'}}}
orders[#orders+1] = { customer=01, order={ {'W2','H4'},{'S4',"W1"}}}
orders[#orders+1] = { customer=01, order={ {'S1','C'},{'B','G'}}}

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