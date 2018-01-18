
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

stars = {597,647,771}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=02, order={ {'P'},{'K','D'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','G'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','A'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','D'},{'W','U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D','A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','A'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','D'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','A','K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','D'},{'U','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','K'},{'A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','A','D'},{'P','U'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','D'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','A'},{'V','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','D'},{'G'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','D'},{'W','U'},{'P'},{'C'} }  }

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