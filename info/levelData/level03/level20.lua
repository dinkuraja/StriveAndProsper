
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

stars = {955,1102,1249}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=06, order={ {'A','D','K'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','D'},{'U','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K'},{'A','D'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','D','K'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','D'},{'A'},{'W','V'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A','G'},{'P'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','A','G'},{'V','W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K'},{'A'},{'D'},{'U','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','K'},{'U'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','K','D'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D'},{'A','K'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K'},{'P','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'D','K'},{'W','U','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','A','G'},{'W'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','A','D'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','D'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','A','G'},{'P'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K','D'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','K'},{'A'},{'U','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D'},{'K'},{'W','V','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A','G'},{'V','P'},{'U'},{'C'} }  }

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