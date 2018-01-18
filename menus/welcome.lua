
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local backClosure = nil

local values = {400,500,600,700,800,900,1000}
local REWARD_DELAY = 1000

--------------------------- INIT

function buildModule(num)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 0, 1)
	
	-- build menu
	buildMenu(num)
	isAnim = true
	timer.performWithDelay(050, showMenu)
	
	-- give reward
	if( num~=0 )then
	
		local myclosure = function() return _G.gui.setCash( values[num] ) end
		timer.performWithDelay(REWARD_DELAY, myclosure, 1)
	
		if( num==7 )then
		
			local myclosure = function() return _G.gui.setGems( 2 ) end
			timer.performWithDelay(REWARD_DELAY, myclosure, 1)
		
		end
		
	end
		
end

function buildMenu(num)
	
	-- bg
	_G.util.addImage('graphics/menus/welcome/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. 'WELCOME BACK' .. ' ', grp_main, 'txt', 'bangers', 0, -225, 60, 1, .86, 0)
	
	-- buttons
	local btn, btns	
	btns = _G.util.addGroup(grp_main, 'grp', 0, 0, 1)
	
	for i=1, 4 do
	
		btn = _G.util.addGroup(btns, 'btn'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/welcome/icons/btn.png', btn, 'btn', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/icons/icon' .. i .. '.png', btn, 'bg', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/icons/icon' .. i .. '_bw.png', btn, 'bw', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/menus/welcome/check.png', btn, 'check', 2, 24, 1, 1, 0, 0)
		
		_G.util.addImage('graphics/menus/welcome/tomorrow.png', btn, 'tomorrow', 59, 27, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/lock.png', btn, 'lock', 78, 44, .8, .8, 0, 1)

		_G.util.addText(' DAY ' .. i .. ' ', btn, 'day', 'bangers', 0, -80, 25, 1, .86, 0)
		_G.util.addText(' $' .. values[i] .. ' ', btn, 'value', 'bangers', 0, -44, 42,  1, 1, 1)

		btn.day:setFillColor(.6,.6,.6)
		btn.x = ( 210 * (i-1) ) - 312
		btn.y = -70
		
		btn.value = values[i]
		btn.num = i
		
	end
	
	for i=5, 7 do
	
		btn = _G.util.addGroup(btns, 'btn'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/welcome/icons/btn.png', btn, 'btn', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/icons/icon' .. i .. '.png', btn, 'bg', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/icons/icon' .. i .. '_bw.png', btn, 'bw', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/menus/welcome/check.png', btn, 'check', 2, 24, 1, 1, 0, 0)
		
		_G.util.addImage('graphics/menus/welcome/tomorrow.png', btn, 'tomorrow', 59, 27, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/welcome/lock.png', btn, 'lock', 78, 44, .8, .8, 0, 1)

		_G.util.addText(' DAY ' .. i .. ' ', btn, 'day', 'bangers', 0, -80, 25, 1, .86, 0)
		_G.util.addText(' $' .. values[i] .. ' ', btn, 'value', 'bangers', 0, -44, 42,  1, 1, 1)
		
		btn.day:setFillColor(.6,.6,.6)
		btn.x = ( 210 * (i-5) ) - 260
		btn.y = 90
		
		btn.value = values[i]
		btn.num = i
		
		if(i==7)then
			
			_G.util.addImage('graphics/menus/welcome/icons/icon8.png', btn,    'bg2', 156, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/menus/welcome/icons/icon8_bw.png', btn, 'bw2', 156, 0, 1, 1, 0, 1)
			_G.util.addText(' ' .. '2' .. ' ', btn, 'value', 'bangers', 156, -44, 42,  1, 1, 1)
			_G.util.addImage('graphics/menus/welcome/tomorrow.png', btn, 'tomorrow2', 162, 27, 1, 1, 0, 0)
			_G.util.addImage('graphics/menus/welcome/lock.png', btn, 'lock2', 181, 44, .8, .8, 0, 1)
			btn.day.x = btn.day.x
			
		end
		
	end
	
	-- info
	_G.util.addImage('graphics/menus/welcome/info.png', grp_main, 'info', -454, 182, 1, 1, 0, 1)
	grp_main.info.anchorX = 0
	grp_main.info.anchorY = 0
	
	_G.util.addTextMulti('COME BACK TOMORROW\nTO COLLECT MORE CASH', grp_main, 'infotxt', 'bangers', -173, 218, 25, 400, 'left', 1, 1, 1)
	
	-- close
	btn = _G.util.addImage('graphics/menus/buttons/btn.png', grp_main, 'back', 0, 0, 1, 1, 0, 1)
	btn.x = 0
	btn.y = 220
	btn:addEventListener('touch', onBtnTouch)
	_G.util.addText(' OK ', grp_main, 'txt', 'bangers', 12, 220-5, 36, 1, .86, 0)
	
	-- set by number
	for i=1, num do
	
		btn = btns['btn'..i]
		btn.bg.alpha = 1
		btn.bw.alpha = 0
		btn.day:setFillColor(1,.86,0)
		btn.lock.alpha = 0
		
		if(i==7)then
			
			btn.bw2.alpha = 0
			btn.bg2.alpha = 1
			btn.lock2.alpha = 0
			
		end
		
		if(i<num)then
		
			btn.btn.alpha = 1
			btn.bg.alpha = 0
			btn.check.alpha = 1
			
		end
			
	end
	
	-- add tomorrow
	if( (num+1)<=7 )then
	
		btn = btns['btn'..(num+1)]
		btn.tomorrow.alpha = 1
		
		if(num==6)then
		
			btn.tomorrow2.alpha = 1
			
		end
		
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
			
	if(e.target.id=='back')then
		
		hideMenu()
		
	end
		
end

--------------------------- METHODS:

function showMenu()

	_G.gui.showTransOverlay()
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
	_G.gui.hideTransOverlay()
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

