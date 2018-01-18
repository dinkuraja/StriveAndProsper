
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

upgrades['order'] = {'autotune','keyboard','studio controls','cds','burner','rooms',
					 'seating','speakers','air conditioning','artwork','sound proofing','studio',
				 	 'guitar','drums','water cooler','water','phone','pizza'}

item = {}
upgrades['autotune'] = item
item.id = 'autotune'
item.name = 'AutoTune'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {7,9,11,13}
item.graphics = {'autotune01','autotune02','autotune02','autotune03'}

item = {}
upgrades['keyboard'] = item
item.id = 'keyboard'
item.name = 'Keyboard'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {7,9,11,13}
item.graphics = {'keyboard01','keyboard02','keyboard02','keyboard03'}

item = {}
upgrades['guitar'] = item
item.id = 'guitar'
item.name = 'Guitar'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.openAt = 4
item.revenue = {7,9,11,13}
item.graphics = {'guitar01','guitar02','guitar02','guitar03'}

item = {}
upgrades['drums'] = item
item.id = 'drums'
item.name = 'Drums'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.openAt = 6
item.revenue = {7,9,11,13}
item.graphics = {'drums01','drums02','drums02','drums03'}

item = {}
upgrades['water'] = item
item.id = 'water'
item.name = 'Water'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.xp = {5,10,20}
item.openAt = 8
item.revenue = {7,9,11,13}
item.graphics = {'water01','water03','water03','water05'}

item = {}
upgrades['pizza'] = item
item.id = 'pizza'
item.name = 'Pizza'
item.coins = {1920,2400,2880}
item.gems = {8,8,15}
item.xp = {5,10,20}
item.revenue = {7,9,11,13}
item.openAt = 11
item.graphics = {'pizza01','pizza02','pizza02','pizza03'}

item = {}
upgrades['studio controls'] = item
item.id = 'studio controls'
item.name = 'Studio Controls'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {2,3,4,5}
item.graphics = {'volume01','volume02','volume02','volume03'}

item = {}
upgrades['cds'] = item
item.id = 'cds'
item.name = 'CDs'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.revenue = {5,7,9,11}
item.graphics = {'icon-cd01','icon-cd02','icon-cd02','icon-cd03'}

item = {}
upgrades['rooms'] = item
item.id = 'rooms'
item.name = 'Booths'
item.coins = {960,1680,2160}
item.gems = {0,0,8}
item.xp = {8,15,25}
item.unlocked = {4,4,5,6}
item.graphics = {'icon-rooms01','icon-rooms01','icon-rooms02','icon-rooms03'}

item = {}
upgrades['water cooler'] = item
item.id = 'water cooler'
item.name = 'Water Cooler'
item.coins = {960,1680,2160}
item.gems = {0,0,0}
item.xp = {8,15,25}
item.openAt = 8
item.prepTime = {8,6,4,2}
item.unlocked = {1,1,2,3}
item.graphics = {'water-cooler','water-cooler','water-cooler','water-cooler'}

item = {}
upgrades['phone'] = item
item.id = 'phone'
item.name = 'Phone'
item.coins = {960,1680,2160}
item.gems = {0,0,0}
item.xp = {5,10,20}
item.prepTime = {8,6,4,2}
item.unlocked = {1,1,2,3}
item.openAt = 11
item.graphics = {'phone01','phone01','phone03','phone06'}

item = {}
upgrades['burner'] = item
item.id = 'burner'
item.name = 'Disk Burner'
item.coins = {480,960,1920}
item.gems = {0,0,8}
item.xp = {5,10,20}
item.prepTime = {8,7,6,4}
item.unlocked = {1,1,2,3}
item.graphics = {'../burner01','../burner01','../burner02','../burner03'}

------------------------------------
------------ interiors -------------
------------------------------------

item = {}
upgrades['seating'] = item
item.id = 'seating'
item.name = 'Couches'
item.coins = {480,960,1920}
item.gems = {0,0,8}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-seating01','icon-seating02','icon-seating02','icon-seating03'}

item = {}
upgrades['speakers'] = item
item.id = 'speakers'
item.name = 'Speakers'
item.coins = {1680,2400,3600}
item.gems = {0,0,8}
item.waitTime = {0,1,2,3}
item.tipTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'../speaker01','../speaker01','../speaker02','../speaker03'}

item = {}
upgrades['air conditioning'] = item
item.id = 'air conditioning'
item.name = 'Air Conditioning'
item.coins = {1680,2400,3600}
item.gems = {0,0,8}
item.waitTime = {0,1,2,3}
item.tipTime = {0,1,2,3}
item.xp = {8,15,25}
item.graphics = {'icon-ac01','icon-ac02','icon-ac02','icon-ac03'}

item = {}
upgrades['artwork'] = item
item.id = 'artwork'
item.name = 'Artwork'
item.coins = {480,960,1920}
item.gems = {0,0,0}
item.tipTime = {0,1,2,3}
item.xp = {5,10,20}
item.graphics = {'icon-artwork01','icon-artwork02','icon-artwork02','icon-artwork03'}

item = {}
upgrades['sound proofing'] = item
item.id = 'sound proofing'
item.name = 'Sound Proofing'
item.coins = {1680,1800,2880}
item.gems = {8,8,15}
item.tipAmount = {0,0,5,10}
item.xp = {15,25,40}
item.graphics = {'icon-soundproof01','icon-soundproof02','icon-soundproof02','icon-soundproof03'}

item = {}
upgrades['studio'] = item
item.id = 'studio'
item.name = 'Studio'
item.coins = {3600,5400,8400}
item.gems = {8,8,15}
item.extraCustomer = {0,0,1,2}
item.xp = {15,25,40}
item.graphics = {'icon-studio01','icon-studio02','icon-studio02','icon-studio03'}

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