
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false

--------------------------- INIT

function buildModule()

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 40, 1)
	
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(500, showMenu)
	
	-- stop audio
	audio.stop()
	
	-- set module
	_G.curModule = _G.results
	
end

function buildMenu()
	
	-- get data
	local values = _G.engine.getResultsValues()
	local sCount = _G.gui.getStarCount()
	
	-- save data
	print('save stars: level - ' .. _G.curLevelNum .. ', stage - ' .. _G.curStageNum .. ', stars - ' .. sCount )
	_G.userdata.leveldata[_G.curLevelNum].levelinfo[ _G.curStageNum ].stars = sCount
	_G.profile.saveUserData()
	
	-- bg
	_G.util.addImage('graphics/menus/results/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText('LEVEL COMPLETED', grp_main, 'txt_lvl_b', 'bangers', -2, -142+2, 25, 0, 0, 0)
	_G.util.addText('LEVEL COMPLETED', grp_main, 'txt_lvl', 'bangers', 0, -142, 25, 1, .86, 0)
	
	if(sCount==0)then
		grp_main.txt_lvl_b.text = "LEVEL FAILED"
		grp_main.txt_lvl.text = "LEVEL FAILED"
	end
	
	-- stars
	_G.util.addImage('graphics/menus/results/star01.png', grp_main, 'star1', -136, -194, 1, 1, 0, 0)
	_G.util.addImage('graphics/menus/results/star02.png', grp_main, 'star2', -4, -220, 1, 1, 0, 0)
	_G.util.addImage('graphics/menus/results/star03.png', grp_main, 'star3', 128, -194, 1, 1, 0, 0)
	
	if( sCount >= 1 )then grp_main.star1.alpha = 1 end
	if( sCount >= 2 )then grp_main.star2.alpha = 1 end
	if( sCount >= 3 )then grp_main.star3.alpha = 1 end	
	
	-- headings
	_G.util.addText('EARNINGS', grp_main, 'txt', 'bangers', -346, -78, 25, 1, .86, 0)
	_G.util.addText('TIPS', grp_main, 'txt', 'bangers', -140, -78, 25, 1, .86, 0)
	_G.util.addImage('graphics/menus/results/safe.png', grp_main, 'safe', 64, 32, .8, .8, 0, 1)
	_G.util.addText('BONUSES', grp_main, 'txt', 'bangers', 64, -78, 25, 1, .86, 0)
	_G.util.addImage('graphics/menus/results/icon_cust.png', grp_main, 'icon', 260, -78, 1, 1, 0, 1)
	_G.util.addText('CUSTOMERS', grp_main, 'txt', 'bangers', 350, -78, 25, 1, .86, 0)

	-- values
	_G.util.addText(' $' .. values.curCash .. ' ', grp_main, 'txt', 'bangers', -348, -34, 42, 1, 1, 1)
	_G.util.addText(' $' .. values.curTips .. ' ', grp_main, 'txt', 'bangers', -148, -34, 42, 1, 1, 1)
	_G.util.addText(' $0 ', grp_main, 'txt', 'bangers', 60, -34, 42, 1, 1, 1)
	
	-- cust
	_G.util.addText('SERVED', grp_main, 'txt', 'bangers', 248, -34, 21, 1, 1, 1)
	_G.util.addText('LOST', grp_main, 'txt', 'bangers', 382, -34, 21, 1, 1, 1)
	_G.util.addText(' ' .. (values.totalCustomers - values.curLost) .. ' ', grp_main, 'txt', 'bangers', 248, 6, 42, 1, .86, 0)
	_G.util.addText(' ' .. values.curLost .. ' ', grp_main, 'txt', 'bangers', 382, 6, 42, 1, .86, 0)
	
	-- totals
	_G.util.addText('EARNED NOW', grp_main, 'txt', 'bangers', -420, 103, 42, 1, 1, 1)
	grp_main.txt.anchorX = 0
	_G.util.addText('CURRENT BALANCE', grp_main, 'txt', 'bangers', -420-2, 162+2, 42, 0, 0, 0)
	grp_main.txt.anchorX = 0
	_G.util.addText('CURRENT BALANCE', grp_main, 'txt', 'bangers', -420, 162, 42, 1, .86, 0)
	grp_main.txt.anchorX = 0
	
	_G.util.addText(' $' .. _G.util.formatEndScoring(values.curEarnings) .. ' ', grp_main, 'txt', 'bangers', 420, 103, 42, 1, 1, 1)
	grp_main.txt.anchorX = 1
	_G.util.addText(' $' .. _G.util.formatEndScoring(values.curEarnings + _G.userdata.cash) .. ' ', grp_main, 'txt', 'bangers', 420-2, 162+2, 42, 0, 0, 0)
	grp_main.txt.anchorX = 1
	_G.util.addText(' $' .. _G.util.formatEndScoring(values.curEarnings + _G.userdata.cash) .. ' ', grp_main, 'txt', 'bangers', 420, 162, 42, 1, .86, 0)
	grp_main.txt.anchorX = 1
	
	-- update gui
	_G.gui.setCash( values.curEarnings )
	
	-- achievements
	local btn = _G.util.addGroup(grp_main, 'achievements', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/achievements.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	btn.x = -392
	btn.y = 256
	btn.alpha = 1
	btn:addEventListener('touch', onBtnTouch)
	_G.achievements.addCounter( btn )
	
	-- buttons
	local btn = _G.util.addImage('graphics/menus/buttons/map.png', grp_main, 'map', 0, 0, 1, 1, 0, 1)
	btn.x = 392-160-160
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addImage('graphics/menus/buttons/replay.png', grp_main, 'replay', 0, 0, 1, 1, 0, 1)
	btn.x = 392-160
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addImage('graphics/menus/buttons/next.png', grp_main, 'next', 0, 0, 1, 1, 0, 1)
	btn.x = 392
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- INPUT:

function onItemTouch(e)
	
	if(e.phase~='began')then return end
	
	hideMenu()
	
end

function onBtnTouch(e)
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
	
	if( e.target.id == 'next' )then
	
		hideMenu()
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure, 1)
	
		local myclosure = function() return _G.engine.resetLevel(true) end
		timer.performWithDelay(500, myclosure, 1)
		
	end
	
	if( e.target.id == 'map' )then
	
		hideMenu()
		
		local myclosure = function() return _G.loader.showLoader() end
		timer.performWithDelay(200, myclosure, 1)
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure, 1)
		
		local myclosure = function() return _G.engine.endLevel() end
		timer.performWithDelay(800, myclosure, 1)
		
	end
	
	if( e.target.id == 'replay' )then
	
		hideMenu()
		
		local myclosure = function() return _G.loader.showLoader() end
		timer.performWithDelay(200, myclosure, 1)
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure, 1)
	
		local myclosure = function() return _G.engine.replayLevel() end
		timer.performWithDelay(800, myclosure, 1)
		
	end
	
	if( e.target.id == 'achievements' )then
		
		hideMenu()
		
		local myclosure = function() return _G.results.restoreMenu() end
		_G.achievements.setBackClosure( myclosure )
		
		local myclosure = function() return _G.achievements.buildModule( e.target ) end
		timer.performWithDelay(400, myclosure, 1)
		
	end
		
end

--------------------------- METHODS:

function showMenu()

	local sCount = _G.gui.getStarCount()
	if(sCount == 0 )then
	
		_G.mixer.playSFX('failed')
		
	else
		
		_G.mixer.playSFX('completed')
		
	end

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
	if(_G.levelUpEarned)then
	
		local myclosure = function() return _G.levelup.buildModule() end
		timer.performWithDelay(1000, myclosure, 1)
		
	end
		
end

function restoreMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
end

function hideMenu()
	
	--killModule()
	--_G.engine.endLevel()
	
	_G.TutorialData.displaying = false

	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	isAnim = true
	
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

