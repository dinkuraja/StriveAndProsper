
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

upgrades['order'] = {'coffee machine','coffee','shoes01 supplies','shoes01','shoes02 supplies','shoes02','paints',
					 'plants','chairs','minibar','speakers','manequins','store',
					 'tops tabletop','tops','pants tabletop','pants','tees tabletop','tees','hats tabletop','hats',
				 	 'case supplies','cases','application','gift'}


item = {}
upgrades['shoes01'] = item
item.id='shoes01'
item.name = 'Black Adidas'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.revenue = {10,12,16,20}
item.xp = {8,15,25}
item.graphics = {'shoes01','shoes01','shoes01','shoes01'}
item.openAt = 1

item = {}
upgrades['shoes01 supplies'] = item
item.id='shoes01 supplies'
item.name = 'Black Adidas Supplies'
item.coins = {1600,2080,2600}
item.gems = {0,8,8}
item.unlocked = {1,1,2,3}
item.prepTime = {6,6,4,2}
item.xp = {8,15,25}
item.graphics = {'icon-shoeblack01','icon-shoeblack01','icon-shoeblack02','icon-shoeblack03'}
item.openAt = 1

item = {}
upgrades['shoes02'] = item
item.id='shoes02'
item.name = 'Tan Adidas'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.revenue = {10,12,16,20}
item.xp = {8,15,25}
item.graphics = {'shoes02','shoes02','shoes02','shoes02'}
item.openAt = 1

item = {}
upgrades['shoes02 supplies'] = item
item.id='shoes02 supplies'
item.name = 'Tan Adidas Supplies'
item.coins = {1600,2080,2600}
item.gems = {0,8,8}
item.unlocked = {1,1,2,3}
item.prepTime = {6,6,4,2}
item.xp = {8,15,25}
item.graphics = {'icon-shoewhite01','icon-shoewhite01','icon-shoewhite02','icon-shoewhite03'}
item.openAt = 1

item = {}
upgrades['tops'] = item
item.id='tops'
item.name = 'Shirts'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {12,14,18,20}
item.xp = {8,15,25}
item.graphics = {'icon-sweater01','icon-sweater02','icon-sweater02','icon-sweater03'}
item.openAt = 1

item = {}
upgrades['pants'] = item
item.id = 'pants'
item.name = 'Pants'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {12,14,18,20}
item.xp = {8,15,25}
item.graphics = {'icon-pants01','icon-pants02','icon-pants02','icon-pants03'}
item.openAt = 1

item = {}
upgrades['tees'] = item
item.id = 'tees'
item.name = 'Sweaters'
item.coins = {1040,1820,2340}
item.gems = {0,0,8}
item.revenue = {14,16,19,22}
item.xp = {8,15,25}
item.graphics = {'icon-shirt01','icon-shirt02','icon-shirt02','icon-shirt03'}
item.openAt = 1

item = {}
upgrades['hats'] = item
item.id = 'hats'
item.name = 'Bucket Hats'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.revenue = {12,14,16,18}
item.xp = {8,15,25}
item.graphics = {'icon-hat01','icon-hat02','icon-hat02','icon-hat03'}
item.openAt = 1

item = {}
upgrades['coffee'] = item
item.id = 'coffee'
item.name = 'Coffee'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'coffee01','coffee03','coffee03','coffee05'}
item.openAt = 1

item = {}
upgrades['cases'] = item
item.id = 'cases'
item.name = 'Phone Cases'
item.coins = {1400,2000,3000}
item.gems = {0,0,8}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'case01','case02','case02','case03'}
item.openAt = 1

item = {}
upgrades['tops tabletop'] = item
item.id = 'tops tabletop'
item.name = 'Shirts Space'
item.coins = {1400,1820,2340}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-topred01','icon-topred01','icon-topred02','icon-topred03'}
item.openAt = 1

item = {}
upgrades['pants tabletop'] = item
item.id = 'pants tabletop'
item.name = 'Pants Space'
item.coins = {1400,1820,2340}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-topred01','icon-topred01','icon-topred02','icon-topred03'}
item.openAt = 1

item = {}
upgrades['tees tabletop'] = item
item.id = 'tees tabletop'
item.name = 'Sweaters Space'
item.coins = {1400,1820,2340}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-topred01','icon-topred01','icon-topred02','icon-topred03'}
item.openAt = 1

item = {}
upgrades['hats tabletop'] = item
item.id = 'hats tabletop'
item.name = 'Hats Space'
item.coins = {1400,2080,2600}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-topwhite01','icon-topwhite01','icon-topwhite02','icon-topwhite03'}
item.openAt = 1

item = {}
upgrades['coffee machine'] = item
item.id = 'coffee machine'
item.name = 'Coffee Machine'
item.coins = {1600,2080,2600}
item.gems = {0,8,8}
item.unlocked = {1,1,2,3}
item.prepTime = {6,6,4,2}
item.xp = {5,10,20}
item.graphics = {'coffee-machine','coffee-machine','coffee-machine','coffee-machine'}
item.openAt = 1

item = {}
upgrades['case supplies'] = item
item.id = 'case supplies'
item.name = 'Phone Case Supplies'
item.coins = {1600,2080,2600}
item.gems = {0,8,8}
item.unlocked = {1,1,2,3}
item.prepTime = {6,6,4,2}
item.xp = {5,10,20}
item.graphics = {'icon-topwhite01','icon-topwhite01','icon-topwhite02','icon-topwhite03'}
item.openAt = 1

item = {}
upgrades['paints'] = item
item.id = 'paints'
item.name = 'Paints'
item.coins = {1600,2080,2600}
item.gems = {8,8,15}
item.revenue = {5,7,9,11}
item.xp = {5,10,20}
item.graphics = {'paints01','paints01','paints02','paints03'}
item.openAt = 1

item = {}
upgrades['application'] = item
item.id = 'application'
item.name = 'Job Requests'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.revenue = {2,3,4,5}
item.xp = {8,15,25}
item.graphics = {'icon-application01','icon-application01','icon-application02','icon-application03'}
item.openAt = 1

item = {}
upgrades['gift'] = item
item.id = 'gift'
item.name = 'Gift Wrapping'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.revenue = {8,10,14,18}
item.xp = {8,15,25}
item.graphics = {'icon-gifts01','icon-gifts01','icon-gifts02','icon-gifts03'}
item.openAt = 1

item = {}
upgrades['rooms'] = item
item.id = 'rooms'
item.name = 'Changing Rooms'
item.coins = {1820,1950,3120}
item.gems = {8,8,15}
item.unlocked = {2,2,3,4}
item.xp = {8,15,25}
item.graphics = {'icon-rooms01','icon-rooms01','icon-rooms02','icon-rooms03'}
item.openAt = 1

------------------------------------
------------ interiors -------------
------------------------------------

item = {}
upgrades['plants'] = item
item.id = 'plants'
item.name = 'Bonsai Plants'
item.coins = {520,1040,2080}
item.gems = {0,0,0}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-bonsai01','icon-bonsai01','icon-bonsai02','icon-bonsai03'}

item = {}
upgrades['chairs'] = item
item.id = 'chairs'
item.name = 'Massage Chairs'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-chair01','icon-chair01','icon-chair02','icon-chair03'}

item = {}
upgrades['minibar'] = item
item.id = 'minibar'
item.name = 'Mini-bar'
item.coins = {1820,2600,3900}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-minibar01','icon-minibar01','icon-minibar02','icon-minibar03'}

item = {}
upgrades['speakers'] = item
item.id = 'speakers'
item.name = 'Speakers'
item.coins = {520,1040,2080}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'../speaker01','../speaker01','../speaker02','../speaker03'}

item = {}
upgrades['manequins'] = item
item.id = 'manequins'
item.name = 'Mannequins'
item.coins = {2080,2600,3120}
item.gems = {8,8,15}
item.tipAmount = {0,5,10,15}
item.xp = {5,10,20}
item.graphics = {'../right01','../right01','../right02','../right03'}

item = {}
upgrades['store'] = item
item.id = 'store'
item.name = 'Store'
item.coins = {3900,5850,9100}
item.gems = {8,15,30}
item.extraCustomer = {0,0,1,2}
item.xp = {5,10,20}
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