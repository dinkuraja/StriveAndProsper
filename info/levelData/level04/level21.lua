
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

stars = {1400,1470,1524}

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


orders[#orders+1] = { customer=01, order={ {'S5','W3','T'}}}
orders[#orders+1] = { customer=01, order={ {'W4','W4','S1'}}}
orders[#orders+1] = { customer=01, order={ {'S3','W3','H3'},{'T','H1','G'}}}
orders[#orders+1] = { customer=01, order={ {'W4','S3','H5'}}}
orders[#orders+1] = { customer=01, order={ {'T','P2','A'}}}
orders[#orders+1] = { customer=01, order={ {'T','G','C'},{'S2','A'}}}
orders[#orders+1] = { customer=01, order={ {'W2','W1','G'}}}
orders[#orders+1] = { customer=01, order={ {'H2','I','C'},{'S4','G','B'}}}
orders[#orders+1] = { customer=01, order={ {'S4','P4','A'},{'W1','T','T'}}}
orders[#orders+1] = { customer=01, order={ {'W1','W3','H3'}}}
orders[#orders+1] = { customer=01, order={ {'P4','W4','I'}}}
orders[#orders+1] = { customer=01, order={ {'I','W2','B'}}}
orders[#orders+1] = { customer=01, order={ {'S4','B','G'},{'A','P3','C'}}}
orders[#orders+1] = { customer=01, order={ {'W5','P5','H5'}}}
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