
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

stars = {829,957,1084}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=08, order={ {'K'},{'A'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','A'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','G','K'},{'P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D'},{'U','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','G','K'},{'W'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D'},{'G'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','G'},{'K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','K'},{'V','P'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K'},{'A'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G'},{'A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','G','K'},{'W'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D'},{'G'},{'P','W','U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','D'},{'G'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','D','K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A'},{'K'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','A'},{'K'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A'},{'W','V'},{'P'},{'C'} }  }


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