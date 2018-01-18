
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

stars = {867,1000,1133}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=05, order={ {'A','G'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','G'},{'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D'},{'K'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D'},{'A'},{'V','W','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','D'},{'P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','G'},{'A'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','K'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','A'},{'K'},{'W','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','K'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'G'},{'P','W','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','K','A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K'},{'P','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A'},{'G','K'},{'W','U','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','A'},{'P','W','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A'},{'D','G'},{'V','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','K'},{'A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K'},{'A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K','G'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','A','K'},{'U','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G'},{'D'},{'W','U','P'},{'C'} }  }

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