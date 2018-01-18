
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

stars = {1156,1362,1486}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=07, order={ {'K','G'},{'D'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K'},{'G','A'},{'P','V','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','A'},{'U','W','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K'},{'A'},{'P','V','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','D','K'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','A'},{'V'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','G'},{'A'},{'W','P','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','G'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A','K','G'},{'P'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','A','K'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'A','K'},{'V','W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','G'},{'K'},{'P','V'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','D'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','D','A'},{'W'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','K','G'},{'P','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','D','A'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D'},{'K','A'},{'W','U','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A','G','D'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','G'},{'P','U'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K'},{'G','D'},{'U'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','G'},{'A'},{'V','W','P'},{'C'} }  }

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