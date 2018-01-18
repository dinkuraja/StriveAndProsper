
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

stars = {1359,1585,1812}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'K','G','D'},{'P'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'D','G'},{'W','U'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','K','A'},{'V','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','A'},{'G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','D','K'},{'W'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G','A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A'},{'D'},{'V'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','K','G'},{'W','U'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','D'},{'U','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','G','K'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A'},{'V'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D'},{'K','A'},{'P'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','D','G'},{'V','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','G','D'},{'W'},{'W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','A'},{'K'},{'U','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K','A'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','D'},{'P'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','G','D'},{'V','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','A','K'},{'P'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','K'},{'A'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','G'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'G','D'},{'U'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K','G'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','D','A'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','A'},{'K'},{'V'},{'V','P'},{'C'} }  }

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