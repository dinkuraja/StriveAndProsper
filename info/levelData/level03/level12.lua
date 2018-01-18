
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

stars = {620,672,801}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=05, order={ {'D','G'},{'W','V'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','A','G'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'G'},{'W','U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','A'},{'W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','D'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K'},{'A'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K'},{'W','U','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A',},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','G'},{'P','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','A','D'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','D','K'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','D'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','D','K'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','G'},{'V','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','D'},{'A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','G'},{'W','V'},{'P'},{'C'} }  }

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