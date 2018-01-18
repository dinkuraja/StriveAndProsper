
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

stars = {1479,1725,1972}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=02, order={ {'G'},{'D','K'},{'U','U'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A','K','D'},{'W'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'K','G'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D','G'},{'A'},{'U'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','G','D'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','K','A'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'K'},{'G','D'},{'V'},{'P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A','D'},{'P','U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','K','D'},{'W','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','G'},{'D'},{'U'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G','A','K'},{'P','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','G'},{'A'},{'V'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','A'},{'U'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A','K','D'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','D','G'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K'},{'A','G'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','A'},{'K'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','A','D'},{'W','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'D','G','K'},{'V'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'D','A'},{'G'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','K','G'},{'W','P'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D'},{'A','K'},{'W'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G'},{'A','D'},{'U'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','K','D'},{'V'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K'},{'A'},{'W','P'},{'U'},{'C'} }  }

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