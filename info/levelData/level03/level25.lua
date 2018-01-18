
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

stars = {1195,1409,1537}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=06, order={ {'D','A','G'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','A','D'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','G'},{'A'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','A'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K'},{'G','D'},{'V','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','D','A'},{'W'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','G'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','G','A'},{'W','P','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A'},{'D','G'},{'U'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','K'},{'W','U','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','K','G'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','A','K'},{'P'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D'},{'A'},{'W','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','G','K'},{'U','U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','D'},{'P','W','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','G','A'},{'W','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','G'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G'},{'K','A'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','A'},{'W'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','G'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A','K'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','K','D'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','G'},{'A'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D'},{'A','K'},{'P'},{'W','U'},{'C'} }  }

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