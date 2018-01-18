
module(..., package.seeall)

-------------------------- CONSTANTS

local STENCIL_CHANCE = 5
local CUSTOMER_OFFSET = 1400
local RECORDING_DELAY = 3000

-------------------------- VARIABLES

local itemValues = {}
local cookTimes = {}

--[[
itemValues['drink'] = 10
itemValues['side'] = 10
itemValues['volumeup'] = 10
itemValues['volumedown'] = 10
itemValues['instrument'] = 10
itemValues['autotune'] = 10
itemValues['keyboard'] = 10
itemValues['drums'] = 10
itemValues['guitar'] = 10
itemValues['cd'] = 10
--]]

local main
local levelData
local colorSet = {'#0066ff','#ff8400','#f0ff00','#8600ff','#ff0030','#00ff4e'}

--------------------------- GET/SET

function setLevelData(data)
	
	curCustomer = 1
	levelData = data
		
	-- get user upgrades
	local upgrades = _G.userdata.leveldata[_G.curLevelNum].upgrades
	local ulevel = 0
	local revenue = 0
	local cooktime = 0
	
	-- set water
	ulevel = upgrades['water']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['water'].revenue[ ulevel+1 ]
	itemValues['drink'] = revenue
	
	ulevel = upgrades['water cooler']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['water cooler'].prepTime[ ulevel+1 ]
	cookTimes['drink'] = cooktime * 60
	
	-- set pizza
	ulevel = upgrades['pizza']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['pizza'].revenue[ ulevel+1 ]
	itemValues['side'] = revenue
	
	ulevel = upgrades['phone']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['phone'].prepTime[ ulevel+1 ]
	cookTimes['side'] = cooktime * 60
	
	-- set autotune
	ulevel = upgrades['autotune']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['autotune'].revenue[ ulevel+1 ]
	itemValues['autotune'] = revenue
	
	-- set keyboard
	ulevel = upgrades['keyboard']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['keyboard'].revenue[ ulevel+1 ]
	itemValues['keyboard'] = revenue
	
	-- set drums
	ulevel = upgrades['drums']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['drums'].revenue[ ulevel+1 ]
	itemValues['drums'] = revenue
	
	-- set guitar
	ulevel = upgrades['guitar']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['guitar'].revenue[ ulevel+1 ]
	itemValues['guitar'] = revenue
	
	-- set volumeup
	ulevel = upgrades['studio controls']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['studio controls'].revenue[ ulevel+1 ]
	itemValues['volumeup'] = revenue
	
	-- set volumedown
	ulevel = upgrades['studio controls']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['studio controls'].revenue[ ulevel+1 ]
	itemValues['volumedown'] = revenue
	
	-- set cds
	ulevel = upgrades['cds']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['cds'].revenue[ ulevel+1 ]
	itemValues['cd'] = revenue
	
	ulevel = upgrades['burner']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['burner'].prepTime[ ulevel+1 ]
	cookTimes['cd'] = cooktime * 60
	
	----------------------------
	--------- INTERIORS --------
	----------------------------
	
	-- tip time, wait time, tip amount, extras
	local vars = {0,0,0,0}
	
	ulevel = upgrades['seating']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['seating'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['artwork']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['artwork'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['speakers']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['speakers'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['speakers'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['air conditioning']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['air conditioning'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['air conditioning'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['sound proofing']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['sound proofing'].tipAmount[ ulevel+1 ]
	vars[3] = vars[3] + val
	
	ulevel = upgrades['studio']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['studio'].extraCustomer[ ulevel+1 ]
	vars[4] = vars[4] + val
	
	_G.engine.setUpgradableVars( vars )
	_G.gui.setUpgradableVars( vars )
	
end

--------------------------- LEVELS:

function buildLevel(grp_main)
	
	main = grp_main
	
	local col, row
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	-- background 
	col = 0
	row = 0
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	
	ulevel = upgrades[ 'studio' ]
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then 
		
		print('ulevel not found')
		ulevel = 1
	
	end
		
	for i=1, 4 do
		
		local c = util.addImage('graphics/level3/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * col
		c.y = 384 * row
		
		col = col + 1
		if( col == 2 )then
			row = row + 1
			col = 0
		end
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	-- add windows
	col = 0
	row = 0
	local windows = util.addGroup(grp_main, 'windows', 0, 0, 1)
	for i=1, 6 do
	
		local win = _G.util.addImage('graphics/level3/window.png', windows, 'win'..i, 0, 0, 1, 1, 0, 1)
		win.x = col * 284
		win.y = row * 240
		win.alpha = 0
		
		local circ = display.newCircle(windows, 0, 0, 16 )
		circ.x = win.x
		circ.y = win.y - 108
		circ:setFillColor(0,0,0)
		circ.alpha = 0
		
		local circ = display.newCircle(windows, 0, 0, 12 )
		circ.x = win.x
		circ.y = win.y - 108
		circ:setFillColor(0,1,0)
		win.light = circ
		circ.alpha = 0
		
		col = col + 1
		if( col == 3 )then
			col = 0
			row = row + 1
		end
		
	end
	windows.x = -288
	windows.y = -160
		
	-- frames
	_G.util.addImage('graphics/level3/frames.png', bg.art, 'frames', 680, 344, 1, 1, 0, 1)
			
	-- customers layer
	local customers = util.addGroup(grp_main, 'customers', 0, 0, 1)
	
	-- request layer
	_G.util.addGroup(grp_main, 'requests', 0, 0, 1)
	
	-- counter layer
	local counter = util.addGroup(grp_main, 'counter', 0, 0, 1)

	-- foreground
	local fg = util.addGroup(grp_main, 'foreground', 0, 0, 1)
	
	-- cart
	local cart = util.addGroup(fg, 'cart', 0, 0, 1)
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	grp.x = grp.width * -.5
	grp.y = 384
	cart.customers = customers
			
end

function buildItems()
	
	print("******** BUILD ITEMS *********")
	
	local bg = main.background
	local cart = main.foreground.cart
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	local col = 0
	local row = 0
	
	-- rebuild bg
	bg.art:removeSelf()	
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	
	ulevel = upgrades[ 'studio' ]
	if( not ulevel or ulevel == 0 )then 
		
		print('ulevel not found')
		ulevel = 1
	
	end
		
	for i=1, 4 do
		
		local c = util.addImage('graphics/level3/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * col
		c.y = 384 * row
		
		col = col + 1
		if( col == 2 )then
			row = row + 1
			col = 0
		end
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	-- booth bgs
	local ulevel = upgrades[ 'sound proofing' ]
	if( not ulevel or ulevel == 0 )then ulevel = 1 end
	
	-- add booth
	for i=1, 6 do
		
		local bnum = i + (6 * (ulevel-1) )
		local bstr = ''..bnum
		if(bnum<10)then bstr='0'..bnum end
		
		local b = _G.util.addImage('graphics/level3/booth'..bstr..'.png', bg.art, 'bg', 0, 0, 1, 1, 0, 1)
		b.x = main.windows['win'..i].x+395
		b.y = main.windows['win'..i].y+224
			
	end
	
	-- frames
	_G.util.addImage('graphics/level3/frames.png', bg.art, 'frames', 680, 344, 1, 1, 0, 1)
	
	-- soundboard
	local art = buildArtwork('studio controls')
	art.x = -138
	art.y = 244
	cart:insert(art)
	cart.soundboard = art
	
	-- water-cooler
	_G.util.addImage('graphics/level3/items/water-cooler.png', cart, 'cooler', -410, 276, 1, 1, 0, 1)
	
	-- shutters
	local windows = main.windows
	
	ulevel = upgrades[ 'rooms' ]
	if( not ulevel )then 
		
		print('ulevel not found')
		ulevel = 0 
	
	end
	local max = _G.levelInfo.upgrades['rooms'].unlocked[ ulevel+1 ]
	
	print('max: ' .. max)
	
	if(max==4)then
	
		local img = _G.util.addImage('graphics/level3/window-locked.png', windows, 'lock', 0, 0, 1, 1, 0, 1)
		img.x = windows.win1.x
		img.y = windows.win1.y
		
		local img = _G.util.addImage('graphics/level3/window-locked.png', windows, 'lock', 0, 0, 1, 1, 0, 1)
		img.x = windows.win3.x
		img.y = windows.win3.y
		
	end
	if(max==5)then
		
		local img = _G.util.addImage('graphics/level3/window-locked.png', windows, 'lock', 0, 0, 1, 1, 0, 1)
		img.x = windows.win3.x
		img.y = windows.win3.y
		
	end
	
	-- artwork
	ulevel = upgrades[ 'artwork' ]
	if( not ulevel )then 
		
		ulevel = 0
	
	end
	
	if(ulevel~=0)then
		_G.util.addImage('graphics/level3/left0'..ulevel..'.png', main.background, 'left', -556, -40, 1, 1, 0, 1)
		_G.util.addImage('graphics/level3/right0'..ulevel..'.png', main.background, 'left', 552, -32, 1, 1, 0, 1)
	end
	
	-- speakers
	ulevel = upgrades[ 'speakers' ]
	if( not ulevel )then 
		
		ulevel = 0
	
	end
	
	local col = 0
	local row = 0
	if(ulevel~=0)then
		
		for i=1, 4 do
	
			local s = _G.util.addImage('graphics/level3/speaker0'..ulevel..'.png', main.background, 's', 0, 0, 1, 1, 0, 1)
			s.x = (col * 844) - 424
			s.y = (row * 320) - 230
			s.anchorX=1
		
			if(i%2==0)then s.xScale=-1 end
		
			col = col+1
			if(col==2)then
				col=0
				row=row+1
			end
		
		end
	
	end
	
	-- burner
	ulevel = upgrades[ 'burner' ]
	if( not ulevel or ulevel == 0 )then 
		
		ulevel = 1
	
	end
	_G.util.addImage('graphics/level3/burner02.png', main.background, 'burner', 375, 243, 1, 1, 0, 1)	
	
	-- stand
	_G.util.addImage('graphics/level3/stand.png', main.background, 'stand', 46, 230, 1, 1, 0, 1)
	
	------------------------------------------------
	--- DRAGS
	------------------------------------------------
	
	_G.util.addGroup(cart, 'locks', 0, 0, 1)
	local itemList = {}
	
	-- soda/coffee
	itemList = {}
	local grp = util.addGroup(cart, 'soda', 0, 0, 1)
	
	ulevel = upgrades[ 'water cooler' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['water cooler'].unlocked[ ulevel+1 ]
	
	for i=1, 3 do
		
		local targets = {'customers'}
		
		local f = _G.engine.buildHitArea('#1abc9c', 46, 64, 'auto-fill', targets)
		f.id = 'hit'..i
		f.food = 'drink'
		grp:insert(f)
		grp['hit'..i] = f

		f.x = (i-1) * 40
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		itemList[i] = f
		
		f.select = 'select_water'
		
		local art = buildArtwork('soda')
		f:insert(art)
		f.art = art
		f.art.alpha = 1
		f.cooktime = cookTimes['drink']
		_G.engine.hideObjects(f)
		--f.alpha = .5
		
		f.audioStart = 'pour_start'
		f.audio = 'pour_stop'
		f.loop = 'pour'
		
	end
	grp.itemList = itemList
	grp.x = -472
	grp.y = 344
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit3.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- pizza
	itemList = {}
	local grp = util.addGroup(cart, 'pizza', 0, 0, 1)
	
	ulevel = upgrades[ 'phone' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['phone'].unlocked[ ulevel+1 ]
	
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#af7ac4', 120, 80, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'side'
		grp:insert(f)
		grp['hit'..i] = f
		
		local art = buildArtwork('pizza')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['side']
		_G.engine.hideObjects(f)

		--f.x = (i-1) * -68
		f.y = (i-1) * -10
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		itemList[i] = f
		
		f.audio = 'pizza_delivered'
		f.select = 'select_pizza'
		
	end
	grp.sortByEmpty = true
	grp.itemList = itemList
	grp.x = -280
	grp.y = 214
	
	if( max==1 )then
	
		grp.hit2.isVisible = false
		grp.hit3.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit3.isVisible = false
		
	end
	
	-- volume up
	itemList = {}
	local grp = util.addGroup(cart, 'volumeup', 0, 0, 1)
	for i=1, 1 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#f1c40f', 64, 64, 'volume', targets)
		f.id = 'hit'..i
		f.food = 'volume'
		grp:insert(f)
		
		local img = util.addImage('graphics/level3/items/volume-down.png', cart, 'img', 0, 0, 1, -1, 0, 1)
		f:insert(img)
		f.art = img
		img.alpha = 0
		
		f.select = 'select_vol_up'
		
		--f.x = (i-1) * 10
		f.y = (i-1) * 68
		f.alpha = 1
		f:addEventListener('touch', _G.engine.onHitTouch)
		_G.engine.hideObjects(f)
		
		itemList[i] = f
		
	end
	grp.itemList = itemList
	grp.x = -164
	grp.y = 230
	
	-- volume down
	itemList = {}
	local grp = util.addGroup(cart, 'volumedown', 0, 0, 1)
	for i=1, 1 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#2ecc71', 64, 64, 'volume', targets)
		f.id = 'hit'..i
		f.food = 'volume'
		grp:insert(f)
		
		local img = util.addImage('graphics/level3/items/volume-up.png', cart, 'img', 0, 0, 1, -1, 0, 1)
		f:insert(img)
		f.art = img
		img.alpha = 0
		
		f.select = 'select_vol_down'
		
		--f.x = (i-1) * 10
		f.y = (i-1) * 68
		f.alpha = 1
		f:addEventListener('touch', _G.engine.onHitTouch)
		_G.engine.hideObjects(f)
		
		itemList[i] = f
		
	end
	grp.itemList = itemList
	grp.x = -100
	grp.y = 230
	
	-- instruments
	col = 0
	row = 0
	itemList = {}
	local letters = {'A','B','C','D'}
	local fX = {-78,-18,50,170}
	local fY = {54,-38,70,64}
	local fW = {80,120,80,64}
	local fH = {50,60,100,100}
	local names = {'autotune','keyboard','drums','guitar'}
	local grp = util.addGroup(cart, 'instruments', 0, 0, 1)
	for i=1, 4 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#e74c3c', fW[i], fH[i], 'instant-fill', targets)
		f.id = 'hit'..i
		f.food = 'instrument'
		grp:insert(f)
		grp['hit'..i] = f
		
		f.x = fX[i]
		f.y = fY[i]
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		f.select = 'select_' .. names[i]
		
		--icon
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
		_G.util.addText(letters[i], f, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
		f.letter = letters[i]
		f.num = i
		icon.alpha = 0
		f.stencil.alpha = 0
		
		local art = buildArtwork(names[i])
		f:insert(art)
		f.art = art
		f.art.alpha = 1
		
		if(i==4)then art.y = art.y-20 end
		
		_G.engine.hideObjects(f)
		
		col = col + 1
		if(col==2)then
			row = row + 1
			col = 0
		end
		
		itemList[i] = f
		
	end
	grp.itemList = itemList
	grp.x = 60
	grp.y = 232
	
	-- cds
	itemList = {}
	local grp = util.addGroup(cart, 'cds', 0, 0, 1)
	
	ulevel = upgrades[ 'burner' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['burner'].unlocked[ ulevel+1 ]
	
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#3498db', 60, 54, 'cd', targets)
		f.id = 'hit'..i
		f.food = 'cd'
		grp:insert(f)
		grp['hit'..i] = f

		f.x = (i-1) * -60
		--f.y = (i-1) * 68
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('cd')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['cd']
		_G.engine.hideObjects(f)
		
		itemList[i] = f
		
		f.audioStart = 'burn_cd_start'
		f.audio = 'burn_cd_stop'
		f.loop = 'burn_cd_loop'
		
	end
	grp.itemList = itemList
	grp.x = 424
	grp.y = 274
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 430, 264, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 370, 264, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 430, 264, .85, .85, 0, 1)
		
	end
		
	------------------------------------------------
	--- TAPS
	------------------------------------------------
	
	-- pizza
	local grp = util.addGroup(cart, 'pizza-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 64)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = -284
	grp.y = 290
	f.alpha = .01
	
	local art = buildArtwork('phone')
	art.xScale = 1
	art.yScale = art.xScale
	grp:insert(art)
	f.art = art
	
	f.audio = 'order_pizza'
	
	-- cds
	local grp = util.addGroup(cart, 'cds-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 200, 64)
	f:setFillColor( _G.util.convertHexToRGB('#2980b9') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#3498db'
	f.check = 'cds'
	grp.x = 360
	grp.y = 204
	f.alpha = .01
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	f.audio = 'burn_cd_start'
	f.loop = 'burn_cd_loop'
	
	------------------------------------------------
	--- SHUT OFF BY LEVEL
	------------------------------------------------
	
	local highestCompleted = 0
	for i=2, #_G.userdata.leveldata[_G.curLevelNum].levelinfo do
		
		local stars = _G.userdata.leveldata[_G.curLevelNum].levelinfo[i].stars
		if( (highestCompleted==0) and (stars==0) )then
		
			highestCompleted = i-1
			
		end
		
	end
	-- if(highestCompleted==0)then highestCompleted=30 end
	local high = highestCompleted
	
	--high = 30
	
	-- guitar, drums, water, pizza
	if( high < 4-1 )then
		
		cart['cooler'].isVisible = false
		cart['soda'].hit1.isVisible = false
		cart['soda'].hit2.isVisible = false
		cart['soda'].hit3.isVisible = false
		
		cart['instruments'].hit3.isVisible = false
		cart['instruments'].hit4.isVisible = false
		
		cart['pizza-tap'].isVisible = false
		
	elseif( high < 6-1 )then
	
		cart['cooler'].isVisible = false
		cart['soda'].hit1.isVisible = false
		cart['soda'].hit2.isVisible = false
		cart['soda'].hit3.isVisible = false
		
		cart['instruments'].hit3.isVisible = false
		
		cart['pizza-tap'].isVisible = false
			
	elseif( high < 8-1 )then
	
		cart['cooler'].isVisible = false
		cart['soda'].hit1.isVisible = false
		cart['soda'].hit2.isVisible = false
		cart['soda'].hit3.isVisible = false
				
		cart['pizza-tap'].isVisible = false
			
	elseif( high < 11-1 )then
	
		cart['pizza-tap'].isVisible = false
			
	end
	
end

--------------------------- SET LEVEL:

function setLevel(num)
	
end

--------------------------- CUSTOMERS:

function buildCustomers(grp_main)

	-- pull main
	local customers = grp_main.customers
	
	-- build 6
	local col = 0
	local row = 0
	local cList = {}
	
	-- get limit by level
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	local ulevel = upgrades[ 'rooms' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['rooms'].unlocked[ ulevel+1 ]

	-- reorder windows
	local winorder = {2,4,5,6,1,3}
	
	-- build customers
	for i=1, max do
	
		local c = _G.engine.buildCustomer()
		
		-- build group for masking
		local grp = _G.util.addGroup(customers, 'c'..i, 0, 0, 1)
		grp:insert(c)
		grp.cust = c
		
		-- set mask
		local masker = graphics.newMask('graphics/level3/maskC.png')
		grp:setMask(masker)
		c.masked = true
		
		-- scale down
		local cScale = .7
		c.xScale = cScale
		c.yScale = cScale
		
		-- scale up hit
		c.hit.xScale = 1/cScale
		c.hit.yScale = 1/cScale
		
		-- position group by winorder
		local win = grp_main.windows[ 'win' .. winorder[i] ] 
		grp.x = win.x + grp_main.windows.x
		grp.y = win.y + grp_main.windows.y
		c.light = win.light
		
		--bg.x = grp.x
		--bg.y = grp.y
		
		-- set color
		c.color = colorSet[ winorder[i] ]
		
		-- position customer
		c.x = 50
		c.y = 30
		c.endX = c.x
		c.endY = c.y
		
		local dir = math.floor(math.random()*2)+1
		if( dir==1 )then
	
			c.x = c.x + CUSTOMER_OFFSET
		
		else
		
			c.x = c.x - CUSTOMER_OFFSET
		
		end 
		
		-- adjust request window
		local rWin = c.request
		rWin.x = win.x + grp_main.windows.x + 120
		rWin.y = win.y + grp_main.windows.y - 30
		grp_main.requests:insert( rWin )
		
		-- set to have 3 requests
		c.totalRequests = 3
		c.curRequest = 1
		
		-- add to list
		cList[#cList+1] = c
		
	end
	_G.util.table.shuffle(cList)
	grp_main.customers.cList = cList
	
end

function setCustomerRequest(customer)

	-- remove requests
	local oldValue = 0
	if( customer.requests )then
		
		if( customer.requests.oldValue )then
		
			oldValue = customer.requests.oldValue
			
		end
		
		customer.requests:removeSelf()
		customer.requests = nil
		
	end

	-- 3 types: drink, side, meal
	local rtypes = {'drink','side','volumeup','volumedown','instrument'}
	local request = _G.util.addGroup(customer, 'requests', 0, 0, 1)
	local food = nil
	
	-- save request num
	customer.rlimit = rlimit
	
	-- if first request...
	local order
	if( customer.curRequest == 1 )then
		
		customer.totalRequests = #levelData.orders[ curCustomer ].order
		print('set total r: ' .. customer.totalRequests)
		
		order = levelData.orders[ curCustomer ].order[ customer.curRequest ]
		customer.orderNum = curCustomer
		curCustomer = curCustomer + 1
		
	else
	
		order = levelData.orders[ customer.orderNum ].order[ customer.curRequest ]

	end
	
	-- output order
	for i=1, #order do
	
		print(order[i])
		
	end
	local rlimit = #order
		
	-- change set per request num
	if( customer.curRequest == 1 )then
		
		rtypes = {'instrument'}
		--customer.num = curCustomerNum
		
	end
	if( customer.curRequest == 2 )then
		
		rtypes = {'drink','side','volumeup','volumedown'}
		
	end
	if( customer.curRequest == 3 )then
		
		rtypes = {'cd'}
		rlimit = 1
		
	end
	
	-- build request
	for i=1, rlimit do
		
		local rnum = math.floor(math.random()*(#rtypes))+1
		--rnum = 5
		
		-- add water
		if( order[i] == 'W' )then
			
			food = _G.engine.buildHitArea('#1abc9c', 64, 64, 'none')
			food.food = 'drink'
			food.value = itemValues['drink']
			
			art = buildArtwork('soda')
			art.full.alpha = 1
			art.empty.alpha = 0
			food:insert(art)
			
		end
		
		-- add pizza
		if( order[i] == 'P' )then
			
			food = _G.engine.buildHitArea('#af7ac4', 64, 64, 'none')
			food.food = 'side'
			food.color = '#af7ac4'
			food.value = itemValues['side']
			
			art = buildArtwork('pizza')
			art.xScale = .75
			art.yScale = art.xScale
			food:insert(art)
			
		end
		
		-- add volume-up
		if( order[i] == 'U' )then
			
			food = _G.engine.buildHitArea('#f1c40f', 64, 64, 'none')
			food.food = 'volume'
			food.color = '#f1c40f'
			food.value = itemValues['volumeup']
			
			local art = util.addImage('graphics/level3/items/volume-down.png', food, 'art', 0, 0, 1, 1, 0, 1)
			art.xScale = 1
			art.yScale = art.xScale * -1
			
		end
		
		-- add volume-down
		if( order[i] == 'V' )then
			
			food = _G.engine.buildHitArea('#2ecc71', 64, 64, 'none')
			food.food = 'volume'
			food.color = '#2ecc71'
			food.value = itemValues['volumedown']
			
			local art = util.addImage('graphics/level3/items/volume-up.png', food, 'art', 0, 0, 1, 1, 0, 1)
			art.xScale = 1
			art.yScale = art.xScale * -1
			
		end
		
		-- add autotune
		if( order[i] == 'A' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'instrument'
			food.color = '#e74c3c'
			food.value = itemValues['autotune']
			
			--icon
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
			_G.util.addText('A', food, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
			food.letter = 'A'
			icon.alpha = 0
			food.stencil.alpha = 0
			
			art = buildArtwork('autotune')
			art.y = 0
			art.shadow.alpha = 0
			art.xScale = .9
			art.yScale = .9
			food:insert(art)
			
		end
		
		-- add keyboard
		if( order[i] == 'K' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'instrument'
			food.color = '#e74c3c'
			food.value = itemValues['keyboard']
			
			--icon
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
			_G.util.addText('B', food, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
			food.letter = 'B'
			icon.alpha = 0
			food.stencil.alpha = 0
			
			art = buildArtwork('keyboard')
			art.y = 0
			art.shadow.alpha = 0
			art.xScale = .7
			art.yScale = .7
			food:insert(art)
			
		end
		
		-- add drums
		if( order[i] == 'D' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'instrument'
			food.color = '#e74c3c'
			food.value = itemValues['drums']
			
			--icon
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
			_G.util.addText('C', food, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
			food.letter = 'C'
			icon.alpha = 0
			food.stencil.alpha = 0
			
			art = buildArtwork('drums')
			art.y = 0
			art.xScale = .6
			art.yScale = .6
			food:insert(art)
			
		end
		
		-- add guitar
		if( order[i] == 'G' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'instrument'
			food.letter = 'D'
			food.color = '#e74c3c'
			food.value = itemValues['guitar']
			
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
			_G.util.addText('D', food, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
			icon.alpha = 0
			food.stencil.alpha = 0
			
			art = buildArtwork('guitar')
			art.y = 0
			art.xScale = .5
			art.yScale = .5
			food:insert(art)
					
		end
		
		-- add cd
		if( order[i] == 'C' )then
			
			food = _G.engine.buildHitArea('#3498db', 64, 64, 'none')
			food.food = 'cd'
			food.color = '#3498db'
			food.value = itemValues['cd']
			
			-- choose color
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
			icon:setFillColor(_G.util.convertHexToRGB( customer.color ) )
			icon.color = customer.color
			
			art = buildArtwork('cd')
			art.fill:setFillColor(_G.util.convertHexToRGB( customer.color ) )
			art.xScale = .9
			art.yScale = art.xScale
			food:insert(art)
				
		end
		
		-- place food
		food.y = i * 74
		request:insert(food)
		
		-- hide objects
		_G.engine.hideObjects(food)
		
	end
	
	-- position request
	request.value = 0 + oldValue
	request.x = 64
	request.y = -58
	request.xScale = .65
	request.yScale = request.xScale
	request.y = request.y - (request.height * request.xScale * .5)
	
	-- shift for layers
	request.x = request.x - 60
	request.y = request.y + 26
	customer.request:insert(request)
	
	-- reposition
	customer.request:insert( request )
	request.x = 12
	request.y = request.y + 6
	
end

function handleRequestWait(customer)
	print( "Come to Wait state....." )
	-- hide request
	transition.to( customer.request, {delay=0000, time=100, 
								  xScale=.001, yScale=.001, 
								  transition=easing.outQuad})
	
	-- save old value
	customer.requests.oldValue = customer.requests.value 
	
	-- toggle light, green to red
	customer.light:setFillColor(1,0,0)
	
	-- trans/timer to next request
	local myclosure = function() return onRecordingComplete(customer) end
	transition.to( customer, {delay=RECORDING_DELAY, time=0, alpha=1, onComplete=myclosure})
	
end

function onRecordingComplete(customer)
	
	print( "Come to Complete state....." )

	_G.gui.hideTutorial()

	customer.light:setFillColor(0,1,0)
	
	-- reset request
	customer.hasSecondRequest = false
	customer.countDown = _G.engine.getWaitCountdown()
	customer.request.bar.yScale = 1
	


	-- show request
	local myclosure = function() return setCustomerRequest(customer) end	
	transition.to( customer.request, {delay=0200, time=100, 
								 	 xScale=1, yScale=1, 
								 	 transition=easing.outQuad,
							  	 	 onComplete=myclosure})
	
end

--------------------------- OBJECTS:

function buildArtwork(food)

	local grp = display.newGroup()
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades

	if(food=='soda')then
		
		ulevel = upgrades[ 'water' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/water02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water01.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level3/items/water-shadow02.png', grp, 'shadow', 5, 18, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level3/items/water-shadow02.png', grp, 'shadow', 5, 18, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level3/items/water-shadow03.png', grp, 'shadow', 5, 18, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/water05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='autotune')then
		
		ulevel = upgrades[ 'autotune' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/autotune-shadow01.png', grp, 'shadow', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/autotune01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/autotune-shadow02.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/autotune02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/autotune-shadow02.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/autotune02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/autotune-shadow03.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/autotune03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		
	end
	
	if(food=='keyboard')then
		
		ulevel = upgrades[ 'keyboard' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/keyboard-shadow01.png', grp, 'shadow', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/keyboard01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/keyboard-shadow02.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/keyboard02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/keyboard-shadow02.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/keyboard02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/keyboard-shadow03.png', grp, 'shadow', 0, 20, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/keyboard03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		
	end
	
	if(food=='drums')then
		
		ulevel = upgrades[ 'drums' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/drums01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/drums02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/drums02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/drums03.png', grp, 'full', 4, 14, 1, 1, 0, 1)
			
		end
		
	end
	
	if(food=='guitar')then
		
		ulevel = upgrades[ 'guitar' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/guitar01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/guitar02.png', grp, 'full', 8, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/guitar02.png', grp, 'full', 8, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/guitar03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		
	end
		
	if(food=='phone')then
		
		ulevel = upgrades[ 'phone' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/phone01.png', grp, 'on', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/phone02.png', grp, 'off', 0, 0, 1, 1, 0, 0)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/phone03.png', grp, 'on', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/phone04.png', grp, 'off', 0, 0, 1, 1, 0, 0)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/phone03.png', grp, 'on', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/phone04.png', grp, 'off', 0, 0, 1, 1, 0, 0)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/phone06.png', grp, 'on', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level3/items/phone05.png', grp, 'off', 0, 0, 1, 1, 0, 0)
			
		end
		
	end
	
	if(food=='pizza')then
		
		ulevel = upgrades[ 'pizza' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/pizza01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/pizza02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/pizza02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/pizza03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		
		
	end
	
	if(food=='cd')then
	
		ulevel = upgrades[ 'cds' ]
		if( not ulevel )then ulevel = 0 end
		
		_G.util.addImage('graphics/level3/items/cd-fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/cd01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/cd02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/cd02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/cd03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
	
	end
	
	if(food=='studio controls')then
		
		ulevel = upgrades[ 'studio controls' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level3/items/volume01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			
			_G.util.addImage('graphics/level3/items/volume02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 2 )then
			
			_G.util.addImage('graphics/level3/items/volume02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 3 )then
			
			_G.util.addImage('graphics/level3/items/volume03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
			
		end
		
		
	end
	
	
	return grp
	
end

function resetCooker()

	local obj = main.foreground.cart['pizza-tap']
	obj.hit.art.off.alpha = 0
	obj.hit.art.on.alpha = 1
	
end

function evaluateTrash(obj)
	
	local value = 0
	
	return value
	
end

--------------------------- EVENTS:

--------------------------- UI:
function setTutorial(num, callback, xPass, yPass,parentPass)
    local info
    print( "Number :::::: ",num )
	if num == 1 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragAutotune",{ fY = 40, x= -290, y = 380, group=grp_main, callback = callback })
    	
    end

    if num == 2 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("waitCustomerAutotuneDone",{ fY = 40, x=-240,y = 3130, group=grp_main, callback = callback })
    end

	if (num==14) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragKeyboard",{ fY = 40, x= 40, y = 180, group=grp_main, callback = callback })
    end

    if num == 3 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragUpButton",{ fY = 40, x= -400, y = 315, group=grp_main, callback = callback })
    end
	
    if num == 4 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("waitCustomerUpButtonDone",{ fY = 40, x=-240,y = 3130, group=grp_main, callback = callback })
    end

    if num == 5 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectDiskBurner",{ fY = 40, x= 50, y = 300, group=grp_main, callback = callback })
    end

	if num == 15 then
    	--_G.loadsave.print_r( callback )
    	info = _G.gui.setTutorial("dragDownButton",{ fY = 40, x= -100, y = 180, group=grp_main, callback = callback })
    end

    if num == 6 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("waitCustomerCdDone",{ fY = 40, x=-240,y = 3330, group=grp_main, callback = callback })
    end


    if num == 7 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragCd",{ fY = 40, x= 50, y = 380, group=grp_main, callback = callback })
    end

    if num == 8 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)

        print( "-------------" )
    	print_r(cList[1])
    	print( "-------------" )

        local xSet = 0
       	
        if( cList[1].parent.x > -10 )then
        	print( "Come Here To X + 200" )
            _G.TutorialData.data["collectBackDoorMoney"].type = "right"
            xSet = cList[1].parent.x - 280
        else
        	print( "Come Here To X + 350" )
            _G.TutorialData.data["collectBackDoorMoney"].type = "left"
            xSet = cList[1].parent.x + 250
        end
        local ySet = 0
        print( "Cy ::::: ",cList[1].parent.y )
        if( cList[1].y > 0 )then
        	print( "Come Here To Y + 100" )
        	ySet = cList[1].parent.y + 150
        else
        	print( "Come Here To Y + 150" )
			ySet = cList[1].parent.y - 200
        end
        print( "Cy2 ::::: ",ySet )
        info = _G.gui.setTutorial("collectBackDoorMoney",{ fY = 40, x= xSet, y = ySet, group=grp_main, callback = callback })
    end

    if num == 17 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragGuittar",{ fY = 40, x= 230, y = 220, group=grp_main, callback = callback })
    end

	if num == 16 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragDrum",{ fY = 40, x= 120, y = 250, group=grp_main, callback = callback })
    end

    if num == 9 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragWater",{ fY = 40, x= -430, y = 320, group=grp_main, callback = callback })
    end

    if num == 10 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("orderPizza",{ fY = 40, x= -280, y = 250, group=grp_main, callback = callback })
    end
    if num == 20 then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitOrderPizza",{ fY = 40, x= -280, y = 2150, group=grp_main, callback = callback })
    end
    if num == 11 then
        info = _G.gui.setTutorial("lastBackDorrMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 21 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)

        print( "-------------" )
    	print_r(cList[1])
    	print( "-------------" )

        local xSet = 0
       	
        if( cList[1].parent.x > -10 )then
            _G.TutorialData.data["dragOrderedPizza"].type = "right"
            xSet = cList[1].parent.x - 270
        else
            _G.TutorialData.data["dragOrderedPizza"].type = "left"
            xSet = cList[1].parent.x + 380
        end
        local ySet = 0
        print( "Cy ::::: ",cList[1].parent.y )
        if( cList[1].y > 0 )then
        	ySet = cList[1].parent.y + 130
        else
			ySet = cList[1].parent.y - 130
        end
        print( "Cy2 ::::: ",ySet )
        info = _G.gui.setTutorial("dragOrderedPizza",{ fY = 40, x= xSet, y = ySet, group=grp_main, callback = callback })
    end
    if num == 12 then
        info = _G.gui.setTutorial("wellcomeBackDoorMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end

    if num == 13 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)

        print( "-------------" )
    	print_r(cList[1])
    	print( "-------------" )

        local xSet = 0
       	
        if( cList[1].parent.x > -10 )then
            _G.TutorialData.data["firstBackdoorRecordingsCustomerMessage"].type = "right"
            xSet = cList[1].parent.x - 270
        else
            _G.TutorialData.data["firstBackdoorRecordingsCustomerMessage"].type = "left"
            xSet = cList[1].parent.x + 380
        end
        local ySet = 0
        print( "Cy ::::: ",cList[1].parent.y )
        if( cList[1].y > 0 )then
        	ySet = cList[1].parent.y + 130
        else
			ySet = cList[1].parent.y - 130
        end
        print( "Cy2 ::::: ",ySet )
        info = _G.gui.setTutorial("firstBackdoorRecordingsCustomerMessage",{ fY = 40, x= xSet, y = ySet, group=grp_main, callback = callback })
    end
    

	if info ~= nil then
		print( "infoname ::: ",info.tutName )
    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
    	print_r(info.passData)
    end
    
    return info
        
end
--------------------------- MODULE EVENTS:

