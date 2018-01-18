
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

stars = {1519,1772,2026}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=06, order={ {'A','K','G'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A','D'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A'},{'D'},{'P','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','D','K'},{'V'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','K','G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','A','K'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'A','D'},{'V','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','G','A'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','D','G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','A','K'},{'W','V'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'K'},{'G','D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A','K','D'},{'W'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','G','A'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D','A','G'},{'P','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','A'},{'K'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','G','D'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','G'},{'U'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A','K'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','A'},{'D'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','G','K'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K','D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'K','A'},{'V'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','D','A'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','G','K'},{'U'},{'W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A'},{'K','G'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','D','K'},{'U'},{'W','P'},{'C'} }  }

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