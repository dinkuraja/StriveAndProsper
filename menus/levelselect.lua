
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local isScrolling = false

local widget = require( "widget" )

--------------------------- INIT

function buildModule(forceOpen)
	_G.engine.isLevelView = true

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 40, 1)
	
	-- build map
	buildMenu(forceOpen)
	isAnim = true
	timer.performWithDelay(50, showMenu)
	
	-- set module
	_G.curModule = _G.levelselect
	
end

function buildMenu(forceOpen)
	
	-- bg
	_G.util.addImage('graphics/menus/levelselect/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText('SELECT A LEVEL', grp_main, 'txt', 'bangers', 0, -250, 64, 1, .86, 0)
	
	-- list
	local col = 0
	local row = 0
	local list = _G.util.addGroup(grp_main, 'list', 0, 0, 1)
	list.x = 36
	
	for i=1, 30 do
		
		local item = _G.util.addGroup(list, 'i'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/levelselect/item.png', item, 'bg', 0, 0, 1, 1, 0, 1)
		item.bg.anchorX = 0
		item.bg.anchorY = 0
		
		local numstr = ' ' .. i .. ' '
		if(i<10)then numstr = ' 0' .. i .. ' ' end
		_G.util.addText(numstr, item, 'txt', 'bangers', 66-2, 40+2, 64, 0, 0, 0)
		_G.util.addText(numstr, item, 'txt', 'bangers', 66, 40, 64, 1, .86, 0)
		
		-- set data
		local itemData = _G.userdata.leveldata[_G.curLevelNum].levelinfo[i]
		--print(itemData.stars)
		
		-- build stars
		for i=1, 3 do
		
			local s = _G.util.addImage('graphics/menus/levelselect/star_off.png', item, 's', 0, 0, 1, 1, 0, 1)
			s.x = 38 + ((i-1)*32)
			s.y = 102
			
			local s = _G.util.addImage('graphics/menus/levelselect/star_on.png', item, 's', 0, 0, 1, 1, 0, 1)
			s.x = 38 + ((i-1)*32)
			s.y = 102
			
			if( i > itemData.stars )then
				
				s.alpha = 0
				
			end
			
		end
		
		-- position
		item.x = col * 180
		item.y = (row * 160) + 40
		item.num = i
		
		-- increment grid
		col = col + 1
		if( col == 5 )then
		
			col = 0
			row = row + 1
			
		end
		
		-- enable
		item:addEventListener('tap', onItemTap)
		
		-- disable
		if( i > 1 )then
		
			local prevstars = _G.userdata.leveldata[_G.curLevelNum].levelinfo[i-1].stars
			if( prevstars == 0 )then
			
				item.alpha = .5
				item:removeEventListener('tap', onItemTap)
				
			end
			
		end
		
	end
	
	-- add shim
	_G.util.addImage('graphics/menus/levelselect/shim.png', list, 'shim', 200, 1040, 1, 1, 0, .01)
	
	-- scrollview
	local sv = widget.newScrollView(
	    {
	        top = -196,
	        left = -462,
	        width = 932,
	        height = 404,
	        scrollWidth = 600,
	        scrollHeight = 800,
			backgroundColor = { 0.5, 0.5, 0.5, .5 },
			horizontalScrollDisabled=true,
			hideBackground = true,
			listener = scrollListener
	    }
	)
	
	sv:insert(list)
	grp_main:insert(sv)
	
	-- add shadows
	_G.util.addImage('graphics/menus/levelselect/shadow.png', grp_main, 'shad', 4, -180, 1, 1, 0, 1)
	_G.util.addImage('graphics/menus/levelselect/shadow.png', grp_main, 'shad', 4, 192, 1, -1, 0, 1)
	
	-- buttons
	local btn = _G.util.addImage('graphics/menus/buttons/back.png', grp_main, 'back', 0, 0, 1, 1, 0, 1)
	btn.x = -392
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addImage('graphics/menus/buttons/next.png', grp_main, 'next', 0, 0, 1, 1, 0, 1)
	btn.x = 398
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addImage('graphics/menus/buttons/btn.png', grp_main, 'upgrades', 0, 0, 1, 1, 0, 1)
	btn.x = 0
	btn.y = 256
	btn:addEventListener('touch', onBtnTouch)
	_G.util.addText(' UPGRADES ', grp_main, 'txt', 'bangers', 12, 256-5, 36, 1, .86, 0)
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
	-- if force
	if(forceOpen)then
		
		grp_main.alpha = 1
		grp_main.y = grp_main.endY
		
	end
	
end

--------------------------- INPUT:

function onItemTap(e)
	
	--if(e.phase~='began')then return end
	if(isAnim)then return end
	if(isScrolling)then return end
	if not _G.TutorialData.displaying then
		_G.engine.setLevelInfo(e.target.num)
		hideMenu()
	else
		if e.target.num == 1 then
			_G.engine.setLevelInfo(e.target.num)
			hideMenu()	
		end	
	end
	
end

function onBtnTouch(e)
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
	
	isAnim = true
	
	if(e.target.id=='next')then
		
		-- get highest
		local highestCompleted = 0
		for i=2, #_G.userdata.leveldata[_G.curLevelNum].levelinfo do
		
			local stars = _G.userdata.leveldata[_G.curLevelNum].levelinfo[i].stars
			if( (highestCompleted==0) and (stars==0) )then
		
				highestCompleted = i-1
			
			end
		
		end
		
		-- goto next available
		local nextLevel = highestCompleted+1
		if(nextLevel>30)then nextLevel = 30 end
		
		_G.engine.setLevelInfo(nextLevel)
		hideMenu()
		
	end
	
	if(e.target.id=='upgrades')then
		
		gotoUpgrades()
		
	end
	
	if(e.target.id=='back')then
		
		_G.loader.showLoader()
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(550, myclosure, 1)
		
		local myclosure = function() return _G.map.buildModule() end
		timer.performWithDelay(700, myclosure, 1)
		
	end
	
end

function scrollListener(e)

    local phase = e.phase
	
    if( phase == "began" )then 
	
	end
	
    if( phase == "moved" )then 
	
		isScrolling = true
		
	end
	
    if( phase == "ended" )then 
	
		isScrolling = false
	
	end

    return true
end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	
	isAnim = false
	
	local myclosure = function() return _G.toggleInputPause(false) end
	timer.performWithDelay(500, myclosure, 1)
        
        timer.performWithDelay(500, function()
            _G.gui.setTutorial("selectLevel",{ fY = 100 + 40, x=-80, group=grp_main })
        end, 1)
	
end

function hideMenu()
	
	_G.TutorialData.displaying = false

	_G.gui.unSetAtionPerform()

	_G.engine.buildLevelItems()
	_G.inputPause = true

	---

	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	local myclosure = function() return _G.engine.startLevel() end
	local myclosure = function() return _G.gui.showGoal() end
	timer.performWithDelay(500, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function gotoUpgrades()

	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(400, myclosure, 1)
	
	local myclosure = function() return _G.upgrades.buildModule() end
	timer.performWithDelay(400, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function gotoShop(mode)

	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(400, myclosure, 1)
	
	local myclosure = function() return _G.shop.buildModule(mode) end
	timer.performWithDelay(400, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()
	if grp_main then
		_G.engine.isLevelView = false
		grp_main:removeSelf()
		grp_main = nil
	end
	
end

