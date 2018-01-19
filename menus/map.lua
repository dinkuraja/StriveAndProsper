
module(..., package.seeall)

-------------------------- VARIABLES

local tagData 	= require("info.tagData")

local DRAG_THRESH = 10

local grp_main
local scrollTrans
local levelClosure
--------------------------- INIT

function buildModule()

	-- build main
	grp_main = util.addGroup(_G.layer_stage, 'grp_main', 0, 0, 1)
	
	-- build map
	buildMap()
	_G.gui.buildModule(grp_main, 'title')
	_G.mixer.loadSFX('map')
	
	-- animate
	local myclosure = function() return showMap() end
	timer.performWithDelay(0500, myclosure, 1)

	-- set module
	_G.curModule = _G.map
	
end

function buildMap()

	local col = 0
	local row = 0
	local map = util.addGroup(grp_main, 'map', 0, 0, 1)
	
	for i=1, 36 do
	
		local snum = '' .. i
		if( i<10 )then snum = '0'..i end
		local m = _G.util.addImage('graphics/map/map/map_' .. snum .. '.png', map, 'm', 0, 0, 1, 1, 0, 1)
		m.anchorX = 0
		m.anchorY = 0
		m.x = col * 230
		m.y = row * 197
		
		col = col + 1
		if(col==6)then 
			row=row+1
			col = 0
		end
 		
	end
	
	-- set map
	local realW = _G.baseWidth * (1/_G.deviceScale)
	print('real width: ' .. realW)
	map.x = realW * -.5
	map.y = -384
	map.xMax = map.x
	map.yMax = map.y
	map.xMin = (map.xMax - map.width)  + realW
	map.yMin = (map.yMax - map.height) + 768
	
	-- position map
	map.x = map.xMin + 200
	map.y = map.yMin + 100
	
	if(map.x < map.xMin)then map.x = map.xMin end
	if(map.x > map.xMax)then map.x = map.xMax end
	if(map.y < map.yMin)then map.y = map.yMin end
	if(map.y > map.yMax)then map.y = map.yMax end
	
	-- enable map
	map.startX = map.x
	map.startY = map.y
	map:addEventListener('touch', onMapTouch)
	
	-- build location tags
	local tX = {0300,0730,1036,0824,550,0300}
	local tY = {0920,0910,0890,1150,980,1100}
	local tN = {'CEELO','HEGGIES','STREET SHOP','BLACKDOOR RECORDINGS',"FERG'S\nAPPAREL","COPELAND'S"}
	local allPins = {}
	for i=0, #tX-1 do
		
		local grp = _G.util.addGroup(map, 'pin'..i, 0, 0, 1)
		
		local ival1 = (i*3)+1
		local ival2 = (i*3)+2
		local ival3 = (i*3)+3
		
		local iStr1 = '' .. ival1
		local iStr2 = '' .. ival2
		local iStr3 = '' .. ival3
		
		if(ival1<10)then iStr1 = '0' .. ival1 end
		if(ival2<10)then iStr2 = '0' .. ival2 end
		if(ival3<10)then iStr3 = '0' .. ival3 end
		
		_G.util.addImage('graphics/map/pins/icon' .. iStr1 .. '.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/map/pins/icon' .. iStr2 .. '.png', grp, 'done', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/map/pins/icon' .. iStr3 .. '.png', grp, 'locked', 0, 0, 1, 1, 0, 0)
		
		grp.x = tX[i+1]
		grp.y = tY[i+1]-300
		grp.num = i
		grp:addEventListener('tap', onIconTap)
		allPins[i+1] = grp
		
		-- init
		grp.alpha = 0
		grp.endY = grp.y
		grp.y = grp.y - 1000
		
	end
	map.pins = allPins
	
	-- build info tags
	print( 'taggin it up:')
	local taglist = tagData.getTagInfo()
	for i=1, #taglist do
	
		local tag, grp, crc
		
		tag = taglist[i]
		
		grp = _G.util.addGroup(map, 'tag'..i, 0, 0, 1)
		tag.info = taglist[i]
		
		circ = display.newCircle( 0, 0, 20 )
		circ:setFillColor( 1,0,0,1 )
		--circ.strokeWidth = 5
		--circ:setStrokeColor( 1, 0, 0 )
		grp:insert(circ)
		
		grp.x = taglist[i].sx
		grp.y = taglist[i].sy
		grp.info = taglist[i]
		grp:addEventListener('touch', onTagTap)
		
	end
		
end
--------------------------- INPUT:

function onMapTouch(e)
	if not _G.TutorialData.checkTargetTouch(2) then
		if(e.phase=='began')then
		
			e.target.startX = e.target.x
			e.target.startY = e.target.y
			
		end
		
		if(e.phase=='moved')then
		
			local dx = e.x - e.xStart
			local dy = e.y - e.yStart
			local dt = math.sqrt((dx*dx)+(dy*dy))
			
			if(dt<DRAG_THRESH)then return end

			local nx = e.target.startX + dx
			local ny = e.target.startY + dy
			
			if(nx < e.target.xMin)then nx = e.target.xMin end
			if(nx > e.target.xMax)then nx = e.target.xMax end
			if(ny < e.target.yMin)then ny = e.target.yMin end
			if(ny > e.target.yMax)then ny = e.target.yMax end
			
			if( scrollTrans )then transition.cancel(scrollTrans) end
			scrollTrans = transition.to(e.target, {time=0, x=nx, y=ny, transition=easing.outQuad})
			
			--e.target.x = nx
			--e.target.y = ny

		end
		
		if(e.phase == 'ended')then
			
			
			
		end
	end
end

--------------------------- METHODS:
local function displayTutorial()
    print( "Display Tutorial" )
    setTutorial(0)
    return true
end
function onIconTap(e)
	print("Return values ::: ",_G.TutorialData.checkTargetTouch(3))
	if not _G.TutorialData.checkTargetTouch(3) then
		if(_G.inputPause)then return end
		--_G.inputPause = true

		_G.mixer.playNavSFX('select_location')

		if(e.target.num==0)then
			if not _G.TutorialData.displaying then
				--_G.inputPause = true
				--levelClosure = function() return _G.ceelo.buildModule() end
				--exitMap()
				_G.gui.unSetAtionPerform()
				_G.gui.showTransOverlay()
				_G.locations.buildModule(e.target.num)
	        end
		else
			if not _G.TutorialData.displaying then
				_G.gui.unSetAtionPerform()
				_G.gui.showTransOverlay()
				_G.locations.buildModule(e.target.num)
				--levelClosure = function() return _G.engine.buildModule( e.target.num ) end\
			else
				if(e.target.num==1)then
					_G.gui.unSetAtionPerform()
					_G.gui.showTransOverlay()
					_G.locations.buildModule(e.target.num)
				end
			end
			
		end
	end
--	local myclosure = function() return displayTutorial() end
--	timer.performWithDelay(1000, myclosure, 1)
end

function onTagTap(e)
	if not _G.TutorialData.displaying then
		if(_G.inputPause)then return end

		_G.mixer.playNavSFX('select_location')
		_G.gui.showTransOverlay()
		
		_G.locations.buildTag(e.target.info)
	end
end

function setLevelClosure(closure)
	
	levelClosure = closure
	
end

function exitMap()
	
	_G.gui.unSetAtionPerform()

	_G.loader.showLoader()
	
	_G.mixer.fadeMusic()
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(550, myclosure, 1)
	
	local myclosure = function() return levelClosure() end
	timer.performWithDelay(700, myclosure, 1)
	
end

function onExitTouch(e)

	if(e.phase ~= 'began')then return end
	
	_G.gui.unSetAtionPerform()
	
	stopModule()
	killModule()
	_G.title.buildModule()
	
end

--------------------------- METHODS:

function showMap()
	
	
	print(_G.audioFromLaunch)
	
	if(_G.audioFromLaunch == false)then
	_G.mixer.loadMusic('map_dice')
	_G.mixer.playMusic()
	else
	_G.audioFromLaunch = false
	end
	_G.loader.hideLoader()

	transition.to( grp_main.black, 		{delay=0000, time=0500, alpha=0, transition=easing.outQuad})
	transition.to( grp_main.gui.header, {delay=0500, time=0800, y=grp_main.gui.header.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.footer, {delay=0500, time=0800, y=grp_main.gui.footer.endY, transition=easing.outQuad})
	
	transition.to( grp_main.gui.exit, 	{delay=1000, time=0400, y=grp_main.gui.exit.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.money, 	{delay=1100, time=0400, y=grp_main.gui.money.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.gems, 	{delay=1200, time=0400, y=grp_main.gui.gems.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.xp, 	{delay=1300, time=0400, y=grp_main.gui.xp.endY, transition=easing.outQuad})
	
	transition.to( grp_main.gui.tags, 			{delay=1100, time=0400, y=grp_main.gui.tags.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.networth, 		{delay=1200, time=0400, y=grp_main.gui.networth.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.standings, 		{delay=1300, time=0400, y=grp_main.gui.standings.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.achievements, 	{delay=1400, time=0400, y=grp_main.gui.achievements.endY, transition=easing.outQuad})
	transition.to( grp_main.gui.settings, 		{delay=1500, time=0400, y=grp_main.gui.settings.endY, transition=easing.outQuad})
	
	local delayer = 1800
	for i=1, #grp_main.map.pins do
		
		transition.to( grp_main.map.pins[i], {delay=delayer, time=0500, y=grp_main.map.pins[i].endY, alpha=1, transition=easing.outBack})
		delayer = delayer + 100
		
		local myclosure = function() return _G.mixer.playSFX('location_slide') end
		timer.performWithDelay(delayer, myclosure, 1)
		
	end
	
	-- set input pause
	local myclosure = function() return toggleInputPause(false) end
	timer.performWithDelay(delayer, myclosure, 1)
	
	-- audio
	local myclosure = function() return _G.mixer.playSFX('gui_slide') end
	timer.performWithDelay(650, myclosure, 1)
	
	-- show welcome menu
	if( _G.isNewDay )then
	
		_G.isNewDay = false
	
		local streak = _G.userdata.stats.dayStreak+1
		if(streak>7)then streak=7 end
	
		local myclosure = function() return _G.welcome.buildModule( streak ) end
		timer.performWithDelay(delayer+500, myclosure, 1)
		
	end
        local myclosure = function()
            local function displayOther()
                local myclosure2 = function()
                    return _G.gui.setTutorial("mainSatage",{ fy = 95, y=grp_main.map.pins[1].y + grp_main.map.pins[1].height/2 + 30,x = grp_main.map.pins[1].x + grp_main.map.pins[1].width + 580,group = grp_main.map })
                end
                timer.performWithDelay(200, myclosure2, 1)
            end
            local info = _G.gui.setTutorial("wellcomeMessage",{ fy = 100, y=110,callback = displayOther,group = grp_main })
            
            if info == nil then
                _G.gui.setTutorial("mainSatage",{ fy = 95, y=grp_main.map.pins[1].y + grp_main.map.pins[1].height + 30,x = grp_main.map.pins[1].x + grp_main.map.pins[1].width + 580,group = grp_main.map })
            end
            return true
        end
	timer.performWithDelay(delayer+500, myclosure, 1)
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()
	
	_G.TutorialData.displaying = false
	_G.mixer.killSFX()
	grp_main:removeSelf()
	grp_main = nil
	
end

