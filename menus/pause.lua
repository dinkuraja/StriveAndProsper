
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false

--------------------------- INIT

function buildModule(mode)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 0, 1)
	
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(050, showMenu)
		
end

function buildMenu(mode)
	
	-- bg
	_G.util.addImage('graphics/menus/pause/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. 'PAUSED' .. ' ', grp_main, 'txt', 'bangers', 0, -222, 60, 1, .86, 0)
	
	-- button
	local grp = _G.util.addGroup(grp_main, 'buttons', 0, 0, 1)
	local names = {'continue','restart','options','map'}
	for i=1, #names do
	
		local btn = _G.util.addGroup(grp, names[i], 0, 0, 1)
		_G.util.addImage('graphics/menus/buttons/btn.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' '..names[i]..' ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
		btn:addEventListener('touch', onBtnTouch)
		btn.y = (i-1) * 100
		
	end
	grp.x = -4
	grp.y = -90
	
	-- init
	grp_main.endY = grp_main.y + 40
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
	
	print('touch')
		
	if(e.target.id=='continue')then
		
		hideMenu()
		
		local myclosure = function() return _G.engine.togglePause() end
		timer.performWithDelay(300, myclosure, 1)
		
	end
	
	if(e.target.id=='restart')then
		
		hideMenu()
		
		local myclosure = function() return _G.loader.showLoader() end
		timer.performWithDelay(200, myclosure, 1)
		
		local myclosure = function() return _G.engine.replayLevel() end
		timer.performWithDelay(800, myclosure, 1)
		
	end
	
	if(e.target.id=='map')then
		
		hideMenu()
		
		local myclosure = function() return _G.loader.showLoader() end
		timer.performWithDelay(200, myclosure, 1)
		
		local myclosure = function() return _G.engine.endLevel() end
		timer.performWithDelay(800, myclosure, 1)
		
	end
		
	if(e.target.id=='options')then
	
		hideMenu()
	
		local myclosure = function() return _G.options.buildModule() end
		timer.performWithDelay(500, myclosure, 1)
		
	end
	
	isAnim = true
		
end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
end

function hideMenu()
	
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	print('what?')
	
	grp_main:removeSelf()
	grp_main = nil
	
end

