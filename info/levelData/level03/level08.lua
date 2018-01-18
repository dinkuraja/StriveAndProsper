
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

stars = {403,421,473}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=05, order={ {'W'},{'G'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K'},{'A'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','D'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','K'},{'V'},{'A'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','D','A'},{'V','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','K'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','K'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','A'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','G','A'},{'U','W'},{'C'} }  }

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