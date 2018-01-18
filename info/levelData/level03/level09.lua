
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

stars = {443,463,521}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'K','A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','G','K'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','A'},{'W'},{'G'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','A'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G'},{'W'},{'D'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K'},{'W','U',},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A','D'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G',},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G','A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','K','A'},{'W'},{'C'} }  }

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