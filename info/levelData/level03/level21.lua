
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

stars = {1052,1240,1353}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=08, order={ {'D','K'},{'U','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D'},{'G'},{'U','W','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D'},{'A'},{'W','V'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','G'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','A'},{'G'},{'V','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','A','D'},{'W','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D'},{'K'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K','D'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D'},{'A','K'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','K'},{'P','W','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','G'},{'W','U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','G'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D'},{'G'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','G'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','K','D'},{'V','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','K','A'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D'},{'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','A'},{'V'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K'},{'G'},{'U','W','P'},{'C'} }  }

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