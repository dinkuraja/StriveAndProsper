
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

upgrades['order'] = {'coffee machine','coffee','pants','pants tabletop','paints','stencils',
					 'lighting','banners','salesman','musicians','table',
					 'tops','tops tabletop','hats','hats tabletop','sketchpad','sketch','mugs','mug supplies',
				 	 'cases','case supplies'}


item = {}
upgrades['pants'] = item
item.id = 'pants'
item.name = 'Jeans'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'icon-pants01','icon-pants02','icon-pants02','icon-pants03'}

item = {}
upgrades['tops'] = item
item.id='tops'
item.name = 'T-Shirts'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'icon-shirt01','icon-shirt02','icon-shirt02','icon-shirt03'}
item.openAt = 4

item = {}
upgrades['hats'] = item
item.id = 'hats'
item.name = 'Hats'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {12,14,16,18}
item.xp = {8,15,25}
item.graphics = {'icon-hats01','icon-hats02','icon-hats02','icon-hats03'}
item.openAt = 7

item = {}
upgrades['coffee'] = item
item.id = 'coffee'
item.name = 'Coffee'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.revenue = {8,9,10,11}
item.xp = {8,15,25}
item.graphics = {'coffee06','coffee04','coffee04','coffee02'}

item = {}
upgrades['sketch'] = item
item.id = 'sketch'
item.name = 'Sketches'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {12,14,16,18}
item.xp = {8,15,25}
item.graphics = {'sketch01','sketch02','sketch02','sketch03'}
item.openAt = 11

item = {}
upgrades['sketchpad'] = item
item.id = 'sketchpad'
item.name = 'Sketch Pad'
item.coins = {800,1400,1800}
item.gems = {0,0,8}
item.unlocked = {1,2,2,3}
item.prepTime = {7,6,4,2}
item.xp = {8,15,25}
item.graphics = {'sketchpad01','sketchpad02','sketchpad02','sketchpad03'}
item.openAt = 11

item = {}
upgrades['mugs'] = item
item.id = 'mugs'
item.name = 'Mugs'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {8,10,12,14}
item.xp = {8,15,25}
item.graphics = {'mug01','mug03','mug03','mug05'}
item.openAt = 15

item = {}
upgrades['cases'] = item
item.id = 'cases'
item.name = 'Belts'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.revenue = {10,12,14,16}
item.xp = {8,15,25}
item.graphics = {'belt01','belt02','belt02','belt03'}
item.openAt = 18

item = {}
upgrades['pants tabletop'] = item
item.id = 'pants tabletop'
item.name = 'Jeans Tabletop'
item.coins = {600,1680,2160}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-tabletop01','icon-tabletop01','icon-tabletop02','icon-tabletop03'}

item = {}
upgrades['tops tabletop'] = item
item.id = 'tops tabletop'
item.name = 'T-shirst Tabletop'
item.coins = {600,1680,2160}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-tabletop01','icon-tabletop01','icon-tabletop02','icon-tabletop03'}
item.openAt = 4

item = {}
upgrades['hats tabletop'] = item
item.id = 'hats tabletop'
item.name = 'Hats Tabletop'
item.coins = {600,1680,2160}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-tabletop01','icon-tabletop01','icon-tabletop02','icon-tabletop03'}
item.openAt = 7

item = {}
upgrades['coffee machine'] = item
item.id = 'coffee machine'
item.name = 'Coffee Machine'
item.coins = {600,1680,1920}
item.gems = {0,0,8}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {5,10,20}
item.graphics = {'coffee-machine','coffee-machine','coffee-machine','coffee-machine'}

item = {}
upgrades['mug supplies'] = item
item.id = 'mug supplies'
item.name = 'Mug Supplies'
item.coins = {600,1680,2160}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {5,10,20}
item.graphics = {'icon-mugs01','icon-mugs01','icon-mugs02','icon-mugs03'}
item.openAt = 15

item = {}
upgrades['case supplies'] = item
item.id = 'case supplies'
item.name = 'Belt Supplies'
item.coins = {600,1680,2160}
item.gems = {0,0,0}
item.unlocked = {1,1,2,3}
item.prepTime = {7,6,4,2}
item.xp = {5,10,20}
item.graphics = {'icon-belts01','icon-belts01','icon-belts02','icon-belts03'}
item.openAt = 18

item = {}
upgrades['paints'] = item
item.id = 'paints'
item.name = 'Paints'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.revenue = {2,2,3,4}
item.xp = {5,10,20}
item.graphics = {'colors01','colors01','colors02','colors03'}

item = {}
upgrades['spray can'] = item
item.id = 'spray can'
item.name = 'Spray Can'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.prepTime = {7,6,4,2}
item.xp = {5,10,20}
item.graphics = {'spraycan','spraycan','spraycan','spraycan'}

item = {}
upgrades['stencils'] = item
item.id = 'stencils'
item.name = 'Stencils'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.revenue = {2,2,3,4}
item.xp = {5,10,20}
item.graphics = {'stencil-a','stencil-b','stencil-b','stencil-c'}

------------------------------------
------------ interiors -------------
------------------------------------

item = {}
upgrades['lighting'] = item
item.id = 'lighting'
item.name = 'Lighting'
item.coins = {480,960,1920}
item.gems = {0,0,0}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-lighting01','icon-lighting01','icon-lighting02','icon-lighting03'}

item = {}
upgrades['banners'] = item
item.id = 'banners'
item.name = 'Banners'
item.coins = {1680,2400,3600}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-banner01','icon-banner01','icon-banner02','icon-banner03'}

item = {}
upgrades['salesman'] = item
item.id = 'salesman'
item.name = 'Street Salesman'
item.coins = {1680,1800,2880}
item.gems = {8,8,15}
item.tipTime = {0,1,2,3}
item.waitTime = {0,1,2,3}
item.xp = {15,25,40}
item.graphics = {'icon-salesman01','icon-salesman01','icon-salesman02','icon-salesman03'}

item = {}
upgrades['musicians'] = item
item.id = 'musicians'
item.name = 'Street Performers'
item.coins = {1680,1800,2880}
item.gems = {8,8,15}
item.tipAmount = {0,5,10,15}
item.xp = {15,25,40}
item.graphics = {'icon-musicians01','icon-musicians01','icon-musicians02','icon-musicians03'}

item = {}
upgrades['table'] = item
item.id = 'table'
item.name = 'Table'
item.coins = {3600,5400,8400}
item.gems = {8,15,30}
item.extraCustomer = {0,0,1,2}
item.xp = {15,25,40}
item.graphics = {'icon-table01','icon-table01','icon-table02','icon-table03'}

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