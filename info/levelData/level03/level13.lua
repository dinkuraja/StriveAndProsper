
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

stars = {663,718,857}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=09, order={ {'A','G'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','D'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','G'},{'A'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','K'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G','A'},{'W','V'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','G'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K'},{'A'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','G'},{'W','V'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','K','A'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','G','D'},{'W'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','A'},{'P','V','U'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','D','K'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','G'},{'D'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','D','K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','G'},{'U','W'},{'P'},{'C'} }  }

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