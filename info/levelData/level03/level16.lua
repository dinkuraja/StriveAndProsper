
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

stars = {822,949,1076}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=07, order={ {'D','A'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','G'},{'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','A','K'},{'P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A'},{'K','G'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'D'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','A'},{'K'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','A','D'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K'},{'A'},{'P','W','U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','K'},{'P','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G'},{'A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A','K','D'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','G'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'K'},{'G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','D','K'},{'W','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A'},{'G'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','A','K'},{'V'},{'P','W'},{'C'} }  }

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