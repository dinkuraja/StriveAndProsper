
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

stars = {925,1068,1210}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=08, order={ {'A'},{'D'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','G'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','K'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','D'},{'A'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G'},{'D'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','G'},{'W','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','A','K'},{'V','P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','A','K'},{'U'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','K','D'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A','K'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D'},{'A','K'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A'},{'D','K'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','A'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','A'},{'D'},{'V','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','D','A'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K'},{'A','G'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','K','G'},{'V'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','K'},{'U','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','K'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G'},{'A'},{'V','W','U'},{'C'} }  }

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