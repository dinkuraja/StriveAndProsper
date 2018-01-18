
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

stars = {635,650,678}

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

orders[#orders+1] = { customer=01, order={ {'P1','C'},{'T','S1','W4'}}}
orders[#orders+1] = { customer=01, order={ {'S3','H4','W3'}}}
orders[#orders+1] = { customer=01, order={ {'P1','C','S2'}}}
orders[#orders+1] = { customer=01, order={ {'W3','T','P1'}}}
orders[#orders+1] = { customer=01, order={ {'S1','P2'}}}
orders[#orders+1] = { customer=01, order={ {'H5'},{'T','S3'}}}
orders[#orders+1] = { customer=01, order={ {'B','C','S5'}}}
orders[#orders+1] = { customer=01, order={ {'P1','S5','T'},{'C'}}}
orders[#orders+1] = { customer=01, order={ {'S6','B','W4'}}}
orders[#orders+1] = { customer=01, order={ {'S1'}}}
orders[#orders+1] = { customer=01, order={ {'P3','C'}}}
orders[#orders+1] = { customer=01, order={ {'C','P3'}}}

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