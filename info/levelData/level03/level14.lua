
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

stars = {693,751,895}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=06, order={ {'K'},{'U','W'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'K','G'},{'A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'D','A'},{'U'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','G'},{'K'},{'U'},{'P','P'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'K','A'},{'W','V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','G','D'},{'W','W'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'D','A'},{'U','P','W'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'A'},{'D','G'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G','A'},{'V'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'K','D','G'},{'P','W'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'D'},{'P'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','K'},{'A'},{'W','V'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'A','K'},{'W','P','U'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'G'},{'A'},{'W','P'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K','D','G'},{'V','W'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'G'},{'A'},{'P','U'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','D','K'},{'W','P'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A'},{'K','G'},{'V'},{'W','W'},{'C'} }  }

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