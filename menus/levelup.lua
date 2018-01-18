
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false

--------------------------- INIT

function buildModule()

	-- lock app
	_G.inputPause = true
	
	-- build overlay
	_G.util.addFill(_G.layer_modal, 'black', 0, 0, 0, .7,  0, 0, 1400, 768)
	_G.layer_modal.black:addEventListener('touch', onBlockTouch)
	
	-- build main
	grp_main = util.addGroup(_G.layer_modal, 'levelup', 0, 20, 1)
	
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(50, showMenu)
	
	-- set module
	--_G.curModule = _G.levelselect
	
end

function buildMenu()
	
	-- bg
	_G.util.addImage('graphics/menus/levelup/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' XP ', grp_main, 'txt', 'bangers', 6+3, -162+3, 90, 0, 0, 0)
	_G.util.addText(' XP ', grp_main, 'txt', 'bangers', 6, -162, 90, 1, 1, 1)
	
	_G.util.addText(' LEVEL UP! ', grp_main, 'txt', 'bangers', 0+2, -84+2, 25, 0, 0, 0)
	_G.util.addText(' LEVEL UP! ', grp_main, 'txt', 'bangers', 0, -84, 25, 1, .86, 0)
	
	_G.util.addText(' YOUR HAVE REACHED EXPERIENCE LEVEL ' .. _G.userdata.level .. ' ', grp_main, 'level', 'bangers', 0, -44, 30, 1, 1, 1)
	_G.util.addText(' YOUR REWARD: ', grp_main, 'txt', 'bangers', 0, 8, 38, 1, .86, 0)
	
	-- values
	_G.util.addText(' $1,000 ', grp_main, 'cash', 'bangers', -156, 68, 54, 1, 1, 1)
	grp_main.cash.anchorX = 0
	_G.util.addText(' 5 ', grp_main, 'gems', 'bangers', 150, 68, 54, 1, 1, 1)
	grp_main.gems.anchorX = 0
	
	-- btn
	local btn = _G.util.addImage('graphics/menus/buttons/btn.png', grp_main, 'ok', 0, 0, 1, 1, 0, 1)
	btn.x = 0
	btn.y = 170
	btn:addEventListener('touch', onBtnTouch)
	_G.util.addText(' OK ', grp_main, 'txt', 'bangers', 12, 170-5, 36, 1, .86, 0)
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
	
	_G.gui.setCash(1000)
	_G.gui.setGems(5)
	
	isAnim = true
	hideMenu()

end

--------------------------- METHODS:

function showMenu()

	_G.levelUpEarned = false
	_G.mixer.playNavSFX('level_up')

	transition.to(_G.layer_modal.black, {time=200, alpha=1, transition=easing.outQuad})
	transition.to(grp_main, 			{time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	
	isAnim = false
	
end

function hideMenu()

	_G.TutorialData.displaying = false

	transition.to(_G.layer_modal.black, {time=200, alpha=0, transition=easing.inQuad})
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	local myclosure = function() return _G.toggleInputPause(false) end
	timer.performWithDelay(500, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

--------------------------- EVENTS:

function onBlockTouch(e)

	--print('block touch')
	return true
	
end

function onBlockTap(e)

	--print('block tap')
	return true
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	_G.layer_modal.levelup = nil
	
end

