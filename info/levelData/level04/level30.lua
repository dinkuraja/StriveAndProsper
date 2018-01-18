
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

stars = {1900,1950,2046}

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

orders[#orders+1] = { customer=01, order={ {'I','S2','T'}}}
orders[#orders+1] = { customer=01, order={ {'S3','W3','C'},{'P3','G','T'}}}
orders[#orders+1] = { customer=01, order={ {'P2','W3','I'}}}
orders[#orders+1] = { customer=01, order={ {'H1','G','T'},{'S4','I','C'}}}
orders[#orders+1] = { customer=01, order={ {'T','Ω5','S5'},{'P2','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S3','H4'}}}
orders[#orders+1] = { customer=01, order={ {'P2','S2','B'}}}
orders[#orders+1] = { customer=01, order={ {'W3','W5'}}}
orders[#orders+1] = { customer=01, order={ {'S3','P4','A'},{'W4','B','T'}}}
orders[#orders+1] = { customer=01, order={ {'H1','P3','W4'}}}
orders[#orders+1] = { customer=01, order={ {'W4','G','C'}}}
orders[#orders+1] = { customer=01, order={ {'B','P4','G'},{'S5','W2','H1'}}}
orders[#orders+1] = { customer=01, order={ {'W2','S3','P3'}}}
orders[#orders+1] = { customer=01, order={ {'A','G','I'},{'T','A','C'}}}
orders[#orders+1] = { customer=01, order={ {'W1','T'}}}
orders[#orders+1] = { customer=01, order={ {'W4','S2','G'}}}
orders[#orders+1] = { customer=01, order={ {'G','B','A'},{'T','W3','S4'}}}
orders[#orders+1] = { customer=01, order={ {'S2','P2','W5'}}}
orders[#orders+1] = { customer=01, order={ {'P1','W4','S2'}}}
orders[#orders+1] = { customer=01, order={ {'W5','I','C'},{'H4','P6','C'}}}


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