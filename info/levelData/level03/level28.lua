
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

stars = {1389,1620,1852}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'A','D'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','K','D'},{'P'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K'},{'G','A'},{'W'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K'},{'A'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','D','A'},{'W'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','K','G'},{'U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G'},{'K','D'},{'V'},{'V','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','A','K'},{'W'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','A'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','D'},{'A'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K','A'},{'P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K'},{'G','D'},{'P','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','A','G'},{'W'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','K'},{'W','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','D','G'},{'U','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','K'},{'A'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A','D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','K'},{'A'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K','D'},{'P'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','K','G'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D'},{'G','A'},{'U'},{'P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','G','A'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','D'},{'K'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D'},{'A','G'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A','D','G'},{'P','W'},{'V'},{'C'} }  }

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