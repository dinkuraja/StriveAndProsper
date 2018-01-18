
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local curItem = nil

local widget = require( "widget" )
local typeTut = 0
--------------------------- INIT

function buildModule()
	_G.engine.isLevelView = true
	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 40, 1)
	
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(050, showMenu)
	
	-- set module
	_G.curModule = _G.upgrades
	
end

function buildMenu()
	
	-- get highest level completed
	local highestCompleted = 0
	for i=2, #_G.userdata.leveldata[_G.curLevelNum].levelinfo do
		
		local stars = _G.userdata.leveldata[_G.curLevelNum].levelinfo[i].stars
		if( (highestCompleted==0) and (stars==0) )then
		
			highestCompleted = i-1
			
		end
		
	end
	local high = highestCompleted
	
	-- bg
	_G.util.addImage('graphics/menus/upgrades/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' UPGRADES ', grp_main, 'txt', 'bangers', 0, -226, 60, 1, .86, 0)
	
	-- build list
	local names = {'soda machine','deep fryer','french fries','buns','patties','rice','chicken','mango','lettuce','tomato'}
	local list = _G.util.addGroup(grp_main, 'list', 0, 0, 1)
	local order = _G.levelInfo.upgrades['order']

	for i=1, #order do
	
		local info = _G.levelInfo.upgrades[ order[i] ]
		local item = _G.util.addGroup(list, 'item'..i, 0, 0, 1)
		
		-- base
		_G.util.addImage('graphics/menus/upgrades/item_shad.png', item, 'shad', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/upgrades/item_bg.png', item, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/menus/upgrades/item_on.png', item, 'on', 0, 0, 1, 1, 0, 0)
		item.shad.anchorX = 0
		item.shad.anchorY = 0
		item.bg.anchorX = 0
		item.bg.anchorY = 0
		item.on.anchorX = 0
		item.on.anchorY = 0
		
		-- name
		_G.util.addText(' ' .. info.name .. ' ', item, 'name', 'bangers', 40, 18, 26, 1, .86, 0)
		item.name.anchorX = 0
		
		-- buttons
		local dots = _G.util.addGroup(item, 'dots', 0, 0, 1)
		for j=1, 3 do
		
			local d = _G.util.addImage('graphics/menus/upgrades/circ_off.png', dots, 'bg', 0, 0, 1, 1, 0, 1)
			d.x = (j-1) * 34
			local d = _G.util.addImage('graphics/menus/upgrades/circ_on.png', dots, 'on'..j, 0, 0, 1, 1, 0, 1)
			d.x = (j-1) * 34
			d.alpha = 0
			
		end
		dots.x = 260
		dots.y = 50
		
		-- position
		item.x = 10
		item.y = (i-1) * 80
		item.y = item.y + 30
		
		-- enable
		item.info = info
		item:addEventListener('tap', onItemTap )
		
		-- debug
		if( _G.launchType=='Debug' )then info.openAt = 1 end
		
		-- disable
		if(info.openAt)then
		
			if(info.openAt > (high+1) )then
			
				item.alpha = .5
				
			end
			
		end
		
	end
	
	-- add shim
	local shimY = list['item' .. #order].y + 104
	_G.util.addImage('graphics/menus/levelselect/shim.png', list, 'shim', 200, shimY, 1, 1, 0, .01)
	
	-- scrollview
	local sv = widget.newScrollView(
	    {
	        top = -166,
	        left = -465,
	        width = 500,
	        height = 334,
	        scrollWidth = 500,
	        scrollHeight = 334,
			backgroundColor = { 0.5, 0.5, 0.5, .5 },
			horizontalScrollDisabled=true,
			hideBackground = true,
			listener = scrollListener
	    }
	)
	
	sv:insert(list)
	grp_main:insert(sv)
	
	-- add shadows
	_G.util.addImage('graphics/menus/upgrades/shadow.png', grp_main, 'shad', -215, -150, .97, 1, 0, 1)
	_G.util.addImage('graphics/menus/upgrades/shadow.png', grp_main, 'shad', -215, 152, .97, -1, 0, 1)
	
	-- -- buttons
	-- local btn = _G.util.addGroup(grp_main, 'back', 0, 0, 1)
	-- _G.util.addImage('graphics/menus/buttons/btn.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	-- _G.util.addText(' LEVELS ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
	-- btn.x = 0
	-- btn.y = 218
	-- btn:addEventListener('touch', onBtnTouch)

	local btn = _G.util.addImage('graphics/menus/buttons/next.png', grp_main, 'back', 0, 0, 1, 1, 0, 1)
	btn.x = 392
	btn.y = 206
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addGroup(grp_main, 'close', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/close.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' X ', btn, 'txt', 'bangers', 12, -5, 36, 237/255, 28/255, 36/255)
	btn.x = 420
	btn.y = -230
	btn:addEventListener('touch', onBtnTouch)
	btn.isVisible = false
	
	local btn = _G.util.addGroup(grp_main, 'upgrades', 0, 0, 1)
	_G.util.addImage('graphics/menus/upgrades/upgrade.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' UPGRADE ', btn, 'txt', 'bangers', 6, -4, 30, 0, 0, 0)
	btn.x = 240
	btn.y = 120
	btn:addEventListener('touch', onUpgradeTouch )
	
	-- thumbview
	_G.util.addImage('graphics/menus/upgrades/thumb.png', grp_main, 'thumb', 130, -52, 1, 1, 0, 1)  
	_G.util.addText(' SODA MACHINE ', grp_main, 'thumb_title', 'bangers', 130, -132, 20, 1, 1, 1)
	_G.util.addGroup( grp_main, 'thumbnail', 130, -52, 1)
	
	-- priceview
	_G.util.addImage('graphics/menus/upgrades/bar.png', grp_main, 'bar', 241, 52, 1, 1, 0, 1) 
	
	_G.util.addImage('graphics/menus/upgrades/cash.png', grp_main, 'cash', 110, 52, 1, 1, 0, 1)  
	_G.util.addText(' $000 ', grp_main, 'price_cash', 'bangers', 146, 51, 34, 1, 1, 1)
	grp_main.price_cash.anchorX = 0
	
	_G.util.addImage('graphics/menus/upgrades/gems.png', grp_main, 'gems', 310, 52, 1, 1, 0, 1)  
	_G.util.addText(' 000 ', grp_main, 'price_gems', 'bangers', 330, 51, 34, 1, 1, 1)
	grp_main.price_gems.anchorX = 0
	
	-- xp
	_G.util.addText(' XP ', grp_main, 'xpt', 'bangers', 370, -134, 28, 1, .86, 0)
	_G.util.addText(' +2 ', grp_main, 'xp', 'bangers', 426, -134, 28, 1, 1, 1)
	grp_main.xp.anchorX = 1
	
	-- portions & preptime
	local titles = {'Portions At Once:', 'Prep Time:'}
	for i=1, 2 do
	
		local grp = _G.util.addGroup(grp_main, 'meter'..i, 0, 0, 1)
		
		_G.util.addFill(grp, 'fill', .36, .36, .36, 1, -50, 0, 150, 30)
		grp.fill.anchorX = 0
		
		_G.util.addFill(grp, 'fill', 240/255, 90/255, 42/255, 1, -50+75, 0, 75, 30)
		grp.fill.anchorX = 1
		grp.fill.xScale = 1
		
		_G.util.addFill(grp, 'fill', 140/255, 255/255, 69/255, 1, -50+75, 0, 75, 30)
		grp.fill.anchorX = 0
		grp.fill.xScale = 1
		
		_G.util.addImage('graphics/menus/upgrades/meter.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(titles[i], grp, 'txt_title', 'native', -70, -30, 12, 1, 1, 1)
		grp.txt_title.anchorX = 0
		_G.util.addImage('graphics/menus/upgrades/triangle.png', grp, 'tri', 24, -1, 1, 1, 0, 1)
		grp.tri.anchorX = 0
		
		_G.util.addText(' 0 ', grp, 'txt_cur_b', 'bangers', -10+2, -3+2, 20, 0, 0, 0)
		_G.util.addText(' 0 ', grp, 'txt_next_b', 'bangers', 60+2, -3+2, 20, 0, 0, 0)
		
		_G.util.addText(' 0 ', grp, 'txt_cur', 'bangers', -10, -3, 20, 1, 1, 1)
		_G.util.addText(' 0 ', grp, 'txt_next', 'bangers', 60, -3, 20, 1, 1, 1)
		
		grp.x = 319
		grp.y = -84 + ((i-1)*68)
		
	end

	-- clock
	_G.util.addImage('graphics/menus/upgrades/clock.png', grp_main.meter2, 'clock', -64, 0, 1, 1, 0, 1)  
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
	-- set to soda machine
	setMenuLevels()
	setMenuItem( list.item1 )
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	--print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='back')then
		
		hideMenu()
		
	end
	if(e.target.id=='next')then
		
		hideMenu( false,true )
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure, 1)
	
		local myclosure = function() return _G.engine.resetLevel(true) end
		timer.performWithDelay(500, myclosure, 1)
		
	end
	if(e.target.id=='close')then
		
		hideMenu()
		
	end
	
end

function onItemTap(e)
	print( "Tutorial Type .......", typeTut)
	if typeTut == 2 or typeTut == 0 then
		if(_G.inputPause)then return end
		if( e.target.alpha ~= 1)then return end
	
		setMenuItem(e.target)
		_G.mixer.playNavSFX('select')
		
		_G.gui.hideTutorial()
	end

end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
	local myclosure = function() return _G.toggleInputPause(false) end
	timer.performWithDelay(500, myclosure, 1)

	local tInfo = nil

	timer.performWithDelay(500,function()
		local function funcCallback()
			timer.performWithDelay(200, function()
				typeTut = 3
				local function funcCallback3( ... )
					-- body
					typeTut = 0
				end
				tInfo = _G.gui.setTutorial("upgradNow",{ fY = 40, x= 200, y = 60, group=grp_main, callback = funcCallback3 })
				if tInfo == nil then
					typeTut = 0
				end
			end)
		end
		local function funcCallback2()
			timer.performWithDelay(200, function()
				typeTut = 2
				tInfo = _G.gui.setTutorial("selectUpdate",{ fY = 40, x= 100, y = 0, group=grp_main, callback = funcCallback })
				if tInfo == nill then
					typeTut = 0
				end
			end)
		end
		typeTut = 1
		tInfo = _G.gui.setTutorial("upgradInfo",{ fy = 100, y=110, group=grp_main, callback = funcCallback2 })
		print_r(tInfo)
		if tInfo == nil then
			print( "Come to Nill Option ...." )
			typeTut = 0
		else
			print( "Come to not Nill Option ...." )
		end
	end)
	
end

function hideMenu( byPass )
	_G.TutorialData.displaying = false
	_G.inputPause = true
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	if not byPass then
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure, 1)
		
		local myclosure = function() return _G.levelselect.buildModule() end
		timer.performWithDelay(500, myclosure, 1)
	end
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function setMenuItem(item)

	-- deselect item
	if( curItem )then curItem.on.alpha = 0 end
	if( grp_main.thumbnail.img )then
		grp_main.thumbnail.img:removeSelf()
		grp_main.thumbnail.img = nil
	end
	
	-- save item
	curItem = item
	item.on.alpha = 1
	local info = item.info
	
	-- get current upgrade level
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	local ulevel = upgrades[ info.id ]
	if( not ulevel )then
	
		--print('upgrade not found: ' .. info.id)
		_G.userdata.leveldata[ _G.curLevelNum ].upgrades[ info.id ] = 0
		_G.profile.saveUserData()
		ulevel = 0
		
	else
	
		--print('upgrade found: ' .. info.id .. ' : ' .. ulevel )
		
	end
	
	-- get current graphic
	local imgid = info.graphics[ ulevel+1 ]
	if( imgid )then
		
		local path = 'graphics/level' .. _G.curLevelNum .. '/items/' .. imgid .. '.png'
		local thumb = _G.util.addImage(path, grp_main.thumbnail, 'img', 0, 0, 1, 1, 0, 1)
		
		if( thumb.width > 110 )then
		
			thumb.xScale = 110/thumb.width
			thumb.yScale = thumb.xScale
			
		end
		if( thumb.height > 97 )then
		
			thumb.yScale = 97/thumb.height
			thumb.xScale = thumb.yScale
			
		end
		
		
	else
	
		print('no graphic found')
		
	end
	
	-- set info
	grp_main.thumb_title.text = info.name
	grp_main.meter2.alpha = 0
		
	-- set details: preptime
	if( info.prepTime )then
		
		grp_main.meter2.alpha = 1
		grp_main.meter2.txt_title.text = "Prep Time:"
		
		if( ulevel < 3 )then

			grp_main.meter2.txt_cur_b.text = ' '..info.prepTime[ulevel+1]..' '
			grp_main.meter2.txt_cur.text = ' '..info.prepTime[ulevel+1]..' '
			
			grp_main.meter2.txt_next_b.text = ' '..info.prepTime[ulevel+2]..' '
			grp_main.meter2.txt_next.text = ' '..info.prepTime[ulevel+2]..' '
			
		else

			grp_main.meter2.txt_cur_b.text = ' '..info.prepTime[ulevel+1]..' '
			grp_main.meter2.txt_cur.text = ' '..info.prepTime[ulevel+1]..' '
			
			grp_main.meter2.txt_next_b.text = ' '
			grp_main.meter2.txt_next.text = ' '
			
		end
		
	else
	
		grp_main.meter2.alpha = 0
		
	end
	
	-- set details: unlocked
	if( info.unlocked )then
		
		grp_main.meter1.txt_title.text = "Portions at Once:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.unlocked[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.unlocked[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.unlocked[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.unlocked[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.unlocked[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.unlocked[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: revenue
	if( info.revenue )then
		
		grp_main.meter1.txt_title.text = "Cash Earned:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.revenue[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.revenue[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.revenue[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.revenue[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.revenue[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.revenue[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: tip time
	if( (info.tipTime) and (not info.waitTime) )then
		
		grp_main.meter1.txt_title.text = "Tip Time:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.tipTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.tipTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.tipTime[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.tipTime[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.tipTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.tipTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: wait time
	if( (info.waitTime) and (not info.tipTime) )then
		
		grp_main.meter1.txt_title.text = "Wait Time:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.waitTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.waitTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.waitTime[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.waitTime[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.waitTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.waitTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: both tip and time
	if( (info.waitTime) and (info.tipTime) )then
		
		grp_main.meter1.txt_title.text = "Tip Time:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.tipTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.tipTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.tipTime[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.tipTime[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.tipTime[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.tipTime[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
		---
		
		grp_main.meter2.txt_title.text = "Wait Time:"
		grp_main.meter2.alpha = 1
		
		if( ulevel < 3 )then
		
			grp_main.meter2.txt_cur_b.text = ' '..info.waitTime[ulevel+1]..' '
			grp_main.meter2.txt_cur.text = ' '..info.waitTime[ulevel+1]..' '
			
			grp_main.meter2.txt_next_b.text = ' '..info.waitTime[ulevel+2]..' '
			grp_main.meter2.txt_next.text = ' '..info.waitTime[ulevel+2]..' '
			
		else
			
			grp_main.meter2.txt_cur_b.text = ' '..info.waitTime[ulevel+1]..' '
			grp_main.meter2.txt_cur.text = ' '..info.waitTime[ulevel+1]..' '
			
			grp_main.meter2.txt_next_b.text = ' '
			grp_main.meter2.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: tip amount
	if( info.tipAmount )then
		
		grp_main.meter1.txt_title.text = "Tip Increase:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.tipAmount[ulevel+1]..'% '
			grp_main.meter1.txt_cur.text = ' '..info.tipAmount[ulevel+1]..'% '
			
			grp_main.meter1.txt_next_b.text = ' '..info.tipAmount[ulevel+2]..'% '
			grp_main.meter1.txt_next.text = ' '..info.tipAmount[ulevel+2]..'% '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.tipAmount[ulevel+1]..'% '
			grp_main.meter1.txt_cur.text = ' '..info.tipAmount[ulevel+1]..'% '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	-- set details: customers
	if( info.extraCustomer )then
		
		grp_main.meter1.txt_title.text = "Extra Customer:"
		
		if( ulevel < 3 )then
		
			grp_main.meter1.txt_cur_b.text = ' '..info.extraCustomer[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.extraCustomer[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '..info.extraCustomer[ulevel+2]..' '
			grp_main.meter1.txt_next.text = ' '..info.extraCustomer[ulevel+2]..' '
			
		else
			
			grp_main.meter1.txt_cur_b.text = ' '..info.extraCustomer[ulevel+1]..' '
			grp_main.meter1.txt_cur.text = ' '..info.extraCustomer[ulevel+1]..' '
			
			grp_main.meter1.txt_next_b.text = ' '
			grp_main.meter1.txt_next.text = ' '
			
		end
		
	end
	
	
	-- toggle purchase button
	if( ulevel == 3 )then
		
		grp_main.upgrades.alpha = 0
		grp_main.cash.alpha = 0
		grp_main.gems.alpha = 0
		grp_main.price_cash.text = ''
		grp_main.price_gems.text = ''
		
		grp_main.xp.text = ''
		grp_main.xpt.alpha = 0
		
	else
		
		grp_main.upgrades.alpha = 1
		
		grp_main.cash.alpha = 1
		grp_main.price_cash.text = ' $' .. info.coins[ ulevel+1 ] .. ' '
		
		grp_main.gems.alpha = 1
		grp_main.price_gems.text = ' ' .. info.gems[ ulevel+1 ] .. ' '
		
		grp_main.upgrades.cashValue = info.coins[ ulevel+1 ]
		grp_main.upgrades.gemsValue = info.gems[ ulevel+1 ]
		grp_main.upgrades.xpValue = info.xp[ ulevel+1 ]
		
		grp_main.xp.text = '+' .. info.xp[ ulevel+1 ] .. ' '
		grp_main.xpt.x = grp_main.xp.x - grp_main.xp.width - 16
		grp_main.xpt.alpha = 1
		
		
		if( info.gems[ ulevel+1 ] == 0 )then
		
			grp_main.gems.alpha = 0
			grp_main.price_gems.text = ' ' 
			
			grp_main.cash.x = 110 + 90
			grp_main.price_cash.x = 146 + 90
			
		else
		
			grp_main.cash.x = 110
			grp_main.price_cash.x = 146
			
		end
		
	end
	
end

function setMenuLevels()

	local list = grp_main.list
	for i=1, list.numChildren do
	
		local item = list[i]
		if(item.info)then
		
			-- get current upgrade level
			local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
			local ulevel = upgrades[ item.info.id ]
			if( not ulevel )then
	
				--print('upgrade not found: ' .. item.info.id)
				_G.userdata.leveldata[ _G.curLevelNum ].upgrades[ item.info.id ] = 0
				_G.profile.saveUserData()
				ulevel = 0
		
			else
	
				--print('upgrade found: ' .. item.info.id .. ' : ' .. ulevel )
		
			end
			
			-- set dots
			if( ulevel>0 )then
			
				for j=1, ulevel do
				
					--print(j)
					local dot = item.dots['on'..j]
					dot.alpha = 1
					
				end
				
			end
			
		end
		
	end
		
end

function onUpgradeTouch(e)
	if typeTut == 3 or typeTut == 0 then
		if(e.phase ~= 'began')then return end
		_G.gui.hideTutorial()
		-- check prices
		if( ( _G.userdata.gems < e.target.gemsValue ) or ( _G.userdata.cash < e.target.cashValue ) )then 
		
			_G.mixer.playNavSFX('wrong')
			return
		
		end
		
		-- purchase 
		local upgrade = _G.userdata.leveldata[ _G.curLevelNum ].upgrades[ curItem.info.id ]

		-- update cash/gems
		_G.gui.setCash( e.target.cashValue * -1 )
		_G.gui.setGems( e.target.gemsValue * -1 )
		_G.gui.setXP( e.target.xpValue )
		
		-- testing
		print( curItem.info.id )
		print( upgrade + 1 )
		
		-- save data
		_G.userdata.leveldata[ _G.curLevelNum ].upgrades[ curItem.info.id ] = upgrade + 1
		_G.profile.saveUserData()
		
		-- update menu
		setMenuLevels()
		setMenuItem( curItem )
		_G.mixer.playNavSFX('purchase')
	end
	
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

