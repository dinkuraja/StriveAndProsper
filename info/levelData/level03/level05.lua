
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

stars = {269,281,294}

-- Order Information --------------------------------------> Order Information:
-- customer: Number 0-9
-- orders:
-- W = Water, P = Pizza, U = Volume-Up, V = Volume-Down
-- A = Autotune, K = Keyboard, D = Drums, G = Guitar
-- C = CD
-- *** 3 sets of orders ***
-- Example: { {'W','P'},{'K','U','G'},{'C'} } 

orders[#orders+1] = { customer=09, order={ {'K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=08, order={ {'G','A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G'},{'U'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=05, order={ {'A','K'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'G','A','K'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=03, order={ {'A'},{'U'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'K'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=01, order={ {'K','A'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=07, order={ {'G','K'},{'U'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=09, order={ {'A'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=06, order={ {'G'},{'V'},{'C'} }  }
orders[#orders+1] = { customer=04, order={ {'A','G'},{'V'},{'U'},{'C'} }  }
orders[#orders+1] = { customer=02, order={ {'G','K'},{'U'},{'C'} }  }

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