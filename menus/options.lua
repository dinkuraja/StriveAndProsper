
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local backClosure = nil

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
	_G.util.addImage('graphics/menus/options/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. 'OPTIONS' .. ' ', grp_main, 'txt', 'bangers', 0, -180, 60, 1, .86, 0)
	
	-- titles
	_G.util.addText(' ' .. 'MUSIC' .. ' ', grp_main, 'txt', 'bangers', -320, -92, 24, 1, .86, 0)
	_G.util.addText(' ' .. 'SOUND' .. ' ', grp_main, 'txt', 'bangers', -320, 6, 24, 1, .86, 0)
	
	_G.util.addText(' ' .. '-' .. ' ', grp_main, 'txt', 'bangers', -250, -52, 60, 1, .86, 0)
	_G.util.addText(' ' .. '+' .. ' ', grp_main, 'txt', 'bangers', 324, -54, 60, 1, .86, 0)
	
	_G.util.addText(' ' .. '-' .. ' ', grp_main, 'txt', 'bangers', -250, 44, 60, 1, .86, 0)
	_G.util.addText(' ' .. '+' .. ' ', grp_main, 'txt', 'bangers', 324, 42, 60, 1, .86, 0)
	
	-- sliders
	local names = {'music','sound'}
	for i=1, 2 do
	
		local grp = _G.util.addGroup(grp_main, names[i], 0, 0, 1)
		_G.util.addImage('graphics/menus/options/drag.png', grp, 'drag', 0, 0, 1, 1, 0, 1)
		_G.util.addFill(grp, 'fill', 1, 0, 0, .01,  0, 0, 140, 80)
		grp.fill.y = -20
		
		grp.x = 300
		grp.y = -42 + ((i-1)*96)
		
		grp:addEventListener('touch', onDragTouch)
		
	end
	
	-- set sliders
	grp_main.music.x = ((_G.mixer.getVolume('music')) * 520)-220
	grp_main.sound.x = ((_G.mixer.getVolume('sound')) * 520)-220
	
	-- button
	local grp = _G.util.addGroup(grp_main, 'buttons', 0, 0, 1)
	local names = {'reset','back','support'}
	for i=1, #names do
	
		local btn = _G.util.addGroup(grp, names[i], 0, 0, 1)
		_G.util.addImage('graphics/menus/buttons/btn.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' '..names[i]..' ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
		btn:addEventListener('touch', onBtnTouch)
		btn.x = (i-1) * 260
		
	end
	grp.x = -270
	grp.y = 160
	
	-- if map, move up
	if( _G.curModule == _G.map )then
	
		grp_main.y = grp_main.y - 20
		
	end
	
	-- init
	grp_main.endY = grp_main.y + 40
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='reset')then
		
		grp_main.music.x = 300
		grp_main.sound.x = 300
		updateVolumes()
		
	end
	
	if(e.target.id=='back')then
		
		hideMenu()
		
		if( backClosure )then
			
			timer.performWithDelay(500, backClosure, 1)
			backClosure = nil
			
		else
		
			local myclosure = function() return _G.pause.buildModule() end
			timer.performWithDelay(500, myclosure, 1)
			
		end

		
		
	end
	
	if(e.target.id=='support')then

		
	end
		
end

function onDragTouch(e)
		
	if(e.phase == 'moved')then
	
		local newX = e.x - 512
				
		if(newX < -220)then
		
			newX = -220
			
		end
		if(newX > 300)then newX = 300 end
		e.target.x = newX
		
	end
	
	updateVolumes()
	
end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
end

function hideMenu()
	
	_G.TutorialData.displaying = false

	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function updateVolumes()

	-- set music volume
	local baseX = grp_main.music.x + 220
	local per = baseX/520
	_G.mixer.setVolume('music', per)
	
	-- set sfx volume
	local baseX = grp_main.sound.x + 220
	local per = baseX/520
	_G.mixer.setVolume('sound', per)
	
end

function setBackClosure(closure)

	backClosure = closure
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

