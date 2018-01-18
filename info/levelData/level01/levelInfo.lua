
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

upgrades['order'] = {'soda machine','soda','patty','burger grill','buns','burger tabletop',
				 	 'warmers','chicken','chicken grill','rice','rice tabletop','mango',
					 'seating','bushes','tree','lighting','banners','radio','cart',
					 'lettuce','tomato','fryer','fries'}

item = {}
upgrades['soda machine'] = item
item.id = 'soda machine'
item.name = 'Soda Machine'
item.coins = {800,1400,1600}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.prepTime = {7,6,4,2}
item.unlocked = {1,1,2,3}
item.graphics = {'soda_machine','soda_machine','soda_machine','soda_machine'}
item.portion = {'soda02'}

item = {}
upgrades['soda'] = item
item.id = 'soda'
item.name = 'Soda'
item.coins = {1600,2000,2400}
item.gems = {8,8,15}
item.xp = {8,15,25}
item.revenue = {8,10,12,14}
item.graphics = {'soda02','soda04','soda04','soda06'}

item = {}
upgrades['fryer'] = item
item.id = 'fryer'
item.name = 'Deep Fryer'
item.coins = {800,1400,900}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.prepTime = {7,6,4,2}
item.unlocked = {1,1,2,3}
item.openAt = 18
item.graphics = {'icon_fryer','icon_fryer','icon_fryer','icon_fryer'}

item = {}
upgrades['fries'] = item
item.id = 'fries'
item.name = 'Fish And Chips'
item.coins = {1600,2000,2400}
item.gems = {8,8,15}
item.xp = {8,15,25}
item.revenue = {8,10,12,14}
item.openAt = 18
item.graphics = {'fries01','fries02','fries02','fries03'}

item = {}
upgrades['buns'] = item
item.id = 'buns'
item.name = 'Buns'
item.coins = {800,1400,1800}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.revenue = {8,10,12,14}
item.graphics = {'icon_burger01','icon_burger02','icon_burger02','icon_burger03'}

item = {}
upgrades['rice'] = item
item.id = 'rice'
item.name = 'Tray'
item.coins = {800,1400,1800}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.revenue = {8,10,12,14}
item.openAt = 4
item.graphics = {'icon-rice00','icon-rice01','icon-rice01','icon-rice02'}

item = {}
upgrades['burger grill'] = item
item.id = 'burger grill'
item.name = 'Burger Grill'
item.coins = {800,1400,1600}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.prepTime = {7,6,4,2}
item.unlocked = {1,1,2,3}
item.graphics = {'icon-grillburger00','icon-grillburger00','icon-grillburger01','icon-grillburger02'}

item = {}
upgrades['chicken grill'] = item
item.id = 'chicken grill'
item.name = 'Chicken Grill'
item.coins = {800,1400,1600}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.prepTime = {7,6,4,2}
item.unlocked = {1,1,2,3}
item.openAt = 4
item.graphics = {'icon-grillchicken00','icon-grillchicken00','icon-grillchicken01','icon-grillchicken02'}

item = {}
upgrades['patty'] = item
item.id = 'patty'
item.name = 'Salmon Patty'
item.coins = {800,1400,1800}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {5,7,9,11}
item.graphics = {'burger02','burger05','burger05','burger08'}

item = {}
upgrades['lettuce'] = item
item.id = 'lettuce'
item.name = 'Lettuce'
item.coins = {800,1000,1500}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.revenue = {2,4,6,8}
item.openAt = 11
item.graphics = {'lettuce01','lettuce02','lettuce02','lettuce03'}

item = {}
upgrades['tomato'] = item
item.id = 'tomato'
item.name = 'Tomato'
item.coins = {800,1000,1500}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.revenue = {2,4,6,8}
item.openAt = 12
item.graphics = {'tomato01','tomato02','tomato02','tomato03'}

item = {}
upgrades['chicken'] = item
item.id = 'chicken'
item.name = 'Chicken'
item.coins = {800,1400,1800}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {5,7,9,11}
item.openAt = 4
item.graphics = {'chicken02','chicken05','chicken05','chicken08'}

item = {}
upgrades['mango'] = item
item.id = 'mango'
item.name = 'Mango'
item.coins = {800,1000,1500}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.revenue = {2,4,6,8}
item.openAt = 5
item.graphics = {'mango01','mango02','mango02','mango03'}

item = {}
upgrades['burger tabletop'] = item
item.id = 'burger tabletop'
item.name = 'Burger Tabletop'
item.coins = {600,1400,1800}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.unlocked = {1,1,2,3}
item.graphics = {'icon-buns00','icon-buns00','icon-buns01','icon-buns02'}

item = {}
upgrades['rice tabletop'] = item
item.id = 'rice tabletop'
item.name = 'Chicken Tabletop'
item.coins = {600,1400,1800}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.unlocked = {1,1,2,3}
item.openAt = 4
item.graphics = {'icon-tray00','icon-tray00','icon-tray01','icon-tray02'}

item = {}
upgrades['warmers'] = item
item.id = 'warmers'
item.name = 'Warmers'
item.coins = {400,800,1200}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.unlocked = {1,2,3,4}
item.openAt = 4
item.graphics = {'icon_warmer','icon_warmer','icon_warmer','icon_warmer'}

------------------------------------
------------ interiors -------------
------------------------------------

item = {}
upgrades['seating'] = item
item.id = 'seating'
item.name = 'Seating'
item.coins = {400,800,1600}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.tipTime = {0,1,2,3}
item.openAt = 6
item.graphics = {'icon-seating01','icon-seating01','icon-seating02','icon-seating03'}

item = {}
upgrades['bushes'] = item
item.id = 'bushes'
item.name = 'Bushes'
item.coins = {400,800,1600}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.tipTime = {0,1,2,3}
item.openAt = 6
item.graphics = {'icon-bushes01','icon-bushes01','icon-bushes02','icon-bushes03'}

item = {}
upgrades['tree'] = item
item.id = 'tree'
item.name = 'Tree'
item.coins = {400,800,1600}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.waitTime = {0,1,2,3}
item.openAt = 6
item.graphics = {'icon-trees01','icon-trees01','icon-trees02','icon-trees03'}

item = {}
upgrades['lighting'] = item
item.id = 'lighting'
item.name = 'Lighting'
item.coins = {400,800,1600}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.waitTime = {0,1,2,3}
item.openAt = 6
item.graphics = {'icon-lighting01','icon-lighting01','icon-lighting02','icon-lighting03'}

item = {}
upgrades['banners'] = item
item.id = 'banners'
item.name = 'Banners'
item.coins = {1400,2000,3000}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.waitTime = {0,1,2,3}
item.tipTime = {0,1,2,3}
item.openAt = 6
item.graphics = {'icon-banners01','icon-banners01','icon-banners02','icon-banners03'}

item = {}
upgrades['radio'] = item
item.id = 'radio'
item.name = 'Radio'
item.coins = {1400,1500,2400}
item.gems = {8,8,15}
item.xp = {15,25,40}
item.tipAmount = {0,5,10,15}
item.openAt = 6
item.graphics = {'icon-radio01','icon-radio01','icon-radio02','icon-radio03'}

item = {}
upgrades['cart'] = item
item.id = 'cart'
item.name = 'Cart Body'
item.coins = {3000,4500,7000}
item.gems = {8,15,30}
item.xp = {15,25,40}
item.extraCustomer = {0,0,1,2}
item.openAt = 6
item.graphics = {'icon-cart00','icon-cart00','icon-cart01','icon-cart02'}

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