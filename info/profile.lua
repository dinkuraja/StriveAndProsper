
module(..., package.seeall)

-------------------------- IMPORTS & SETTINGS


-------------------------- VARIABLES


--------------------------- GAME SETTINGS:

function buildSettings()
	
	local settings = {}
	
	-- volume
	settings.volumeMusic = 1
	settings.volumeSFX = 1
	settings.streak = 0
	
	-- save data to file
	_G.loadsave.saveTable( settings, "settings.json" )
	
	-- return
	return settings
	
end

function loadSettings()

	-- load data, return
	local settings = _G.loadsave.loadTable( "settings.json" )
	return settings
		
end

function saveSettings()

	_G.loadsave.saveTable( _G.settings, "settings.json" )
	
end

--------------------------- USER DATA:

function buildUserData()
	
	local userdata = {}
		
	-- values
	userdata.cash = 0
	userdata.gems = 0
	userdata.tips = 0
	userdata.level = 1
	userdata.xp = 0
	userdata.networth = 0
	userdata.lastDate = 'none'
	
	-- stats
	local stats = {}
	stats.customersServed = 0
	stats.celebsServed = 0
	stats.customersLost = 0
	stats.customerStreak = 0
	stats.trashStreak = 0
	stats.tips = 0
	stats.cashEarned = 0
	stats.burned = 0
	stats.cashOnHand = 0
	stats.cashSpent = 0
	stats.gemsSpent = 0
	stats.ceeloBets = 0
	stats.ceeloWins = 0
	stats.dayStreak = 0
	
	userdata.stats = stats
	
	-- achievements
	userdata.badges = {}
	
	-- add level data (20)
	userdata.leveldata = {}
	for i=1, 20 do
	
		local leveldata = {}
		
		-- stats
		local stats = {}
		stats.locked = false
		--if(i==1)then locked=false end
		leveldata.stats = stats
		
		-- add level info (40)
		local levelinfo = {}
		for j=1, 40 do
			
			local info = {}
			-- if j < 0 then
			-- 	-- Change to 0 for live mode.
				-- info.stars = 30
				-- info.score = 100
			-- else
				info.stars = 0
				info.score = 0
			-- end
			print()
			if( _G.launchType=='Debug' )then
				info.stars = 3
			end
			
			levelinfo[j] = info
			
		end
		leveldata.levelinfo = levelinfo
		
		-- add upgrade info (blank)
		local upgrades = {}
		for j=1, 40 do
			
			upgrades[j] = 0
			
		end
		leveldata.upgrades = {} --upgrades
		
		-- store data
		userdata.leveldata[ #userdata.leveldata+1 ] = leveldata
		
	end
	
	-- -- upgrade exceptions: level 1
	-- local newup = {}
	-- newup['burger grill'] = 1
	-- newup['chicken grill'] = 1
	-- newup['soda machine'] = 1
	-- newup['burger tabletop'] = 1
	-- newup['rice tabletop'] = 1
	-- newup['cart'] = 1
	-- userdata.leveldata[1].upgrades = newup
	
	-- -- upgrade exceptions: level 2
	-- local newup = {}
	-- newup['pants tabletop'] = 1
	-- newup['tops tabletop'] = 1
	-- newup['hats tabletop'] = 1
	-- newup['coffee machine'] = 1
	-- newup['mug supplies'] = 1
	-- newup['case supplies'] = 1
	-- newup['paints'] = 1
	-- newup['table'] = 1
	-- userdata.leveldata[2].upgrades = newup
	
	-- -- upgrade exceptions: level 3
	-- local newup = {}
	-- newup['rooms'] = 1
	-- newup['water cooler'] = 1
	-- newup['phone'] = 1
	-- newup['burner'] = 1
	-- newup['sound proofing'] = 1
	-- newup['studio'] = 1
	-- userdata.leveldata[3].upgrades = newup
	
	-- -- upgrade exceptions: level 4
	-- local newup = {}
	-- newup['shoes01 supplies'] = 1
	-- newup['shoes02 supplies'] = 1
	-- newup['tops tabletop'] = 1
	-- newup['pants tabletop'] = 1
	-- newup['tees tabletop'] = 1
	-- newup['hats tabletop'] = 1
	-- newup['coffee machine'] = 1
	-- newup['case supplies'] = 1
	-- newup['paints'] = 1
	-- newup['rooms'] = 1
	-- newup['store'] = 1
	-- userdata.leveldata[4].upgrades = newup
	
	-- -- upgrade exceptions: level 5
	-- local newup = {}
	-- newup['restaurant'] = 1
	-- userdata.leveldata[5].upgrades = newup

	-- save data to file
	_G.loadsave.saveTable( userdata, "userdata.json" )
	
	-- return
	return userdata
	
end

function loadUserData()

	-- load data, return
	local userdata = _G.loadsave.loadTable( "userdata.json" )
	
	-- testing:
	--_G.util.printTable( userdata.stats )
	--_G.util.printTable( userdata.badges )
	
	return userdata
	
end

function saveUserData()

	_G.loadsave.saveTable( _G.userdata, "userdata.json" )
	
end