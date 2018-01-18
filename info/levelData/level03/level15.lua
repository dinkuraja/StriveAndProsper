
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

stars = {724,785,936}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=01, order={ {'D','G'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D'},{'A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','D'},{'U','W'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A','G'},{'P','V'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A'},{'G','D'},{'W','W'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','K'},{'U'},{'P','W'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G'},{'W','V','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'G','A'},{'D'},{'V'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'K','A'},{'P','W','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'D','K'},{'P','W'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G'},{'A'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'K','D'},{'W','P','V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'D'},{'P','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'D','K','G'},{'U','P'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','A'},{'K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'A','D'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K'},{'A','G'},{'U','P'},{'W'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'G','D','K'},{'P'},{'C'} }  }

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