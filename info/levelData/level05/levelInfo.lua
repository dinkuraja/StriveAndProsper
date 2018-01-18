
------------------------------------------------------------
-- NEVER TOUCH THIS ----------------------------------------
------------------------------------------------------------

local levelData = {}
local upgrades = {}
local unlocks = {}
local item = nil

------------------------------------------------------------
-- EDIT THIS DATA ------------------------------------------
------------------------------------------------------------

-- Upgrade Menu -------------------------------------------> Upgrade Menu:
-- name: Appears in upgrade menu
-- coins: Value of purchase in coins
-- gems: Value of purchase in gems
-- revenue: Cash earned per order
-- prepTime: Prep time per item
-- unlocked: Slots available

upgrades['order'] = {'drink-machine','lemonade','iced-tea','waffle-iron','waffles',
					'tvs','plants','air conditioner','speakers','pinball','restaurant',
					'chicken-pot','chicken','plates','plates tabletop','containers',
					'containers tabletop','warmers','pork-pot','pork','mac','greens',
					'beef-pot','beef'}

item = {}
upgrades['pork'] = item
item.id = 'pork'
item.name = 'Pork'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {5,9,13,17}
item.xp = {8,15,25}
item.graphics = {'pork02','pork04','pork04','pork06'}
item.openAt = 1

item = {}
upgrades['chicken'] = item
item.id = 'chicken'
item.name = 'Chicken'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {5,9,13,17}
item.xp = {8,15,25}
item.graphics = {'chicken02','chicken05','chicken05','chicken08'}
item.openAt = 1

item = {}
upgrades['beef'] = item
item.id = 'beef'
item.name = 'Brisket'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {5,9,13,17}
item.xp = {8,15,25}
item.graphics = {'beef02','beef04','beef04','beef06'}
item.openAt = 1

item = {}
upgrades['warmers'] = item
item.id = 'warmers'
item.name = 'Hot Plates'
item.coins = {520,1040,1560}
item.gems = {0,0,0}
item.unlocked = {1,2,3,4}
item.xp = {8,15,25}
item.graphics = {'warmer01','warmer02','warmer02','warmer03'}
item.openAt = 1

item = {}
upgrades['chicken-pot'] = item
item.id = 'chicken-pot'
item.name = 'Chicken Pot'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'pot-chicken01','pot-chicken01','pot-chicken02','pot-chicken03'}
item.openAt = 1

item = {}
upgrades['beef-pot'] = item
item.id = 'beef-pot'
item.name = 'Toaster Oven'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'icon-toaster01','icon-toaster01','icon-toaster02','icon-toaster03'}
item.openAt = 1

item = {}
upgrades['pork-pot'] = item
item.id = 'pork-pot'
item.name = 'Slow Cooker'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'pot-pork01','pot-pork01','pot-pork02','pot-pork03'}
item.openAt = 1

item = {}
upgrades['plates'] = item
item.id = 'plates'
item.name = 'Plates'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.revenue = {5,7,9,11}
item.xp = {8,15,25}
item.graphics = {'plate01','plate02','plate02','plate03'}
item.openAt = 1

item = {}
upgrades['plates tabletop'] = item
item.id = 'plates tabletop'
item.name = 'Plates Prep Space'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {1,2,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-tabletop01','icon-tabletop02','icon-tabletop02','icon-tabletop03'}
item.openAt = 1

item = {}
upgrades['containers'] = item
item.id = 'containers'
item.name = 'Trays'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.revenue = {5,7,9,11}
item.xp = {8,15,25}
item.graphics = {'container01','container02','container02','container03'}
item.openAt = 1

item = {}
upgrades['containers tabletop'] = item
item.id = 'containers tabletop'
item.name = 'Trays Prep Space'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {1,2,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-tabletop01','icon-tabletop02','icon-tabletop02','icon-tabletop03'}
item.openAt = 1

item = {}
upgrades['lemonade'] = item
item.id = 'lemonade'
item.name = 'Lemonade'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'cup02','cup05','cup05','cup08'}
item.openAt = 1

item = {}
upgrades['iced-tea'] = item
item.id = 'iced-tea'
item.name = 'Iced Tea'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'cup03','cup06','cup06','cup09'}
item.openAt = 1

item = {}
upgrades['drink-machine'] = item
item.id = 'drink-machine'
item.name = 'Drink Machine'
item.coins = {1040,1820,2080}
item.gems = {0,0,8}
item.unlocked = {2,2,4,4}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'soda-machine','soda-machine','soda-machine','soda-machine'}
item.openAt = 1

item = {}
upgrades['waffles'] = item
item.id = 'waffles'
item.name = 'Waffles'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {5,8,11,14}
item.xp = {8,15,25}
item.graphics = {'waffle01','waffle02','waffle02','waffle03'}
item.openAt = 1

item = {}
upgrades['waffle-iron'] = item
item.id = 'waffle-iron'
item.name = 'Waffle Iron'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.unlocked = {1,2,2,3}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'waffle-iron01','waffle-iron03','waffle-iron03','waffle-iron05'}
item.openAt = 1

item = {}
upgrades['mac'] = item
item.id = 'mac'
item.name = 'Mac and Cheese'
item.coins = {1040,1300,1950}
item.gems = {0,0,8}
item.revenue = {2,5,8,11}
item.xp = {8,15,25}
item.graphics = {'condiment04','condiment05','condiment05','condiment06'}
item.openAt = 1

item = {}
upgrades['greens'] = item
item.id = 'greens'
item.name = 'Greens'
item.coins = {1040,1300,1950}
item.gems = {0,0,8}
item.revenue = {2,5,8,11}
item.xp = {8,15,25}
item.graphics = {'condiment01','condiment02','condiment02','condiment03'}
item.openAt = 1

------------------------------------
------------ interiors -------------
------------------------------------

item = {}
upgrades['tvs'] = item
item.id = 'tvs'
item.name = 'Televisions'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-tv01','icon-tv01','icon-tv02','icon-tv03'}

item = {}
upgrades['plants'] = item
item.id = 'plants'
item.name = 'Plants'
item.coins = {520,1040,2080}
item.gems = {0,0,0}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-bushes01','icon-bushes01','icon-bushes02','icon-bushes03'}

item = {}
upgrades['air conditioner'] = item
item.id = 'air conditioner'
item.name = 'Air Conditioners'
item.coins = {520,1040,2080}
item.gems = {0,0,0}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-ac01','icon-ac01','icon-ac02','icon-ac03'}

item = {}
upgrades['speakers'] = item
item.id = 'speakers'
item.name = 'Speaker System'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-speakers01','icon-speakers01','icon-speakers02','icon-speakers03'}

item = {}
upgrades['pinball'] = item
item.id = 'pinball'
item.name = 'Pinball Machine'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.tipAmount = {0,5,10,15}
item.xp = {15,25,40}
item.graphics = {'icon-pinball01','icon-pinball01','icon-pinball02','icon-pinball03'}

item = {}
upgrades['restaurant'] = item
item.id = 'restaurant'
item.name = 'Restaurant'
item.coins = {3900,5850,9100}
item.gems = {8,15,30}
item.extraCustomer = {0,0,1,2}
item.xp = {15,25,40}
item.graphics = {'icon-store01','icon-store01','icon-store02','icon-store03'}

------------------------------------------------------------
-- NEVER TOUCH THIS ----------------------------------------
------------------------------------------------------------

levelData['upgrades'] = upgrades
levelData['unlocks'] = unlocks

local Public = {}
Public.getData = function()

	return levelData
	
end 

return Public

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------