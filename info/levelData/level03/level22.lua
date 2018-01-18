
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

stars = {1089,1283,1400}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'A','G'},{'P'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','A','K'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D'},{'K'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','G','D'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D','K'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','G','K'},{'V','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','A','D'},{'W','P','V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','K'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','G','K'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','A','D'},{'P','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'K'},{'P','W','V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G','K'},{'A'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G','K'},{'P'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','A','D'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K','D','G'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','G'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'K','D'},{'V','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','D'},{'A'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D'},{'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','D','A'},{'P'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G'},{'U'},{'W','W'},{'C'} }  }

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