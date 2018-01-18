
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

stars = {1115,1315,1434}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=05, order={ {'K'},{'G','D'},{'P','V','U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K'},{'U'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','G','K'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A'},{'G','D'},{'U','W','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K','A'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','D'},{'P','W','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','K'},{'V','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','A','D'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','K','G'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G'},{'A'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A','G'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K','D'},{'P','W','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G'},{'A'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','G','K'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','D'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','K','G'},{'P'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','D'},{'V','W','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','D'},{'A'},{'U','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A','G','D'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G','D'},{'U','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','D'},{'A'},{'V','W','P'},{'C'} }  }

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