
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

stars = {313,327,368}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'D','K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K'},{'V'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','D'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','G'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G',},{'V'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A'},{'K'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','D'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','A','K'},{'U'},{'C'} }  }

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