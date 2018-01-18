
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

stars = {1326,1547,1768}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'A','G'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','A','D'},{'W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'K'},{'G','A'},{'W'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','A','G'},{'U','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A'},{'D'},{'V','W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K','A'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','G'},{'V'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D'},{'W','P','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A','D','G'},{'U','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G'},{'D','K'},{'W','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','K','A'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','D'},{'K'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','G','A'},{'V','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','D','K'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','D'},{'U','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K','G','A'},{'W'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'D'},{'G','K'},{'P','U','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','K','A'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','G'},{'A'},{'W','U','P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'A'},{'D','G'},{'P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','G','K'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A','K'},{'U','P'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','D'},{'G'},{'V','W','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K','D'},{'U','W'},{'W'},{'C'} }  }

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