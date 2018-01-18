
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

stars = {485,506,569}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=03, order={ {'G','D'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','G'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','K'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','G'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','D'},{'G'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','D'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','G'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','D','K'},{'U','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A','D'},{'V','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','D'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','A','D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A','D'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','A'},{'V',},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','G'},{'W','U'},{'C'} }  }

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