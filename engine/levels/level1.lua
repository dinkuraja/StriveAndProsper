
module(..., package.seeall)

-------------------------- CONSTANTS

local CUSTOMER_OFFSET = 1400

-------------------------- VARIABLES

--[[
local foodValues = {}
foodValues['drink'] = 10
foodValues['fries'] = 10
foodValues['burger'] = 10
foodValues['chicken'] = 10
foodValues['c1'] = 5
foodValues['c2'] = 5
foodValues['c3'] = 5
--]]

local main
local levelData
local foodValues = {}
local cookTimes = {}
local info = nil

--------------------------- GET/SET

function setLevelData(data)
	-- _G.TutorialData.displaying = false
	curCustomer = 1
	levelData = data
	
	-- set food values
	print('level data:')

	print_r(levelData)

	print( _G.levelInfo.upgrades['soda'].name )
	
	-- get user upgrades
	local upgrades = _G.userdata.leveldata[_G.curLevelNum].upgrades
	local ulevel = 0
	local revenue = 0
	local cooktime = 0
	local val = 0
	
	-- set soda
	ulevel = upgrades['soda']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['soda'].revenue[ ulevel+1 ]
	foodValues['drink'] = revenue
	
	ulevel = upgrades['soda machine']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['soda machine'].prepTime[ ulevel+1 ]
	cookTimes['drink'] = cooktime * 60
	
	-- set fries
	ulevel = upgrades['fries']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['fries'].revenue[ ulevel+1 ]
	foodValues['fries'] = revenue
	
	ulevel = upgrades['fryer']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['fryer'].prepTime[ ulevel+1 ]
	cookTimes['fries'] = cooktime * 60
	
	-- set patty
	ulevel = upgrades['patty']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['patty'].revenue[ ulevel+1 ]
	foodValues['burger'] = revenue
	
	ulevel = upgrades['burger grill']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['burger grill'].prepTime[ ulevel+1 ]
	cookTimes['burger'] = cooktime * 60
	
	-- set chicken
	ulevel = upgrades['chicken']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['chicken'].revenue[ ulevel+1 ]
	foodValues['chicken'] = revenue
	
	ulevel = upgrades['chicken grill']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['chicken grill'].prepTime[ ulevel+1 ]
	cookTimes['chicken'] = cooktime * 60
	
	-- set mango
	ulevel = upgrades['mango']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['mango'].revenue[ ulevel+1 ]
	foodValues['c1'] = revenue
	
	-- set lettuce
	ulevel = upgrades['lettuce']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['lettuce'].revenue[ ulevel+1 ]
	foodValues['c2'] = revenue
	
	-- set tomato
	ulevel = upgrades['tomato']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['tomato'].revenue[ ulevel+1 ]
	foodValues['c3'] = revenue
	
	-- set buns
	ulevel = upgrades['buns']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['buns'].revenue[ ulevel+1 ]
	foodValues['buns'] = revenue
	
	-- set rice
	ulevel = upgrades['rice']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['rice'].revenue[ ulevel+1 ]
	foodValues['rice'] = revenue
	
	----------------------------
	--------- INTERIORS --------
	----------------------------
	
	-- tip time, wait time, tip amount, extras
	local vars = {0,0,0,0}
	
	ulevel = upgrades['seating']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['seating'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['bushes']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['bushes'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['tree']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['tree'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['lighting']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['lighting'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['banners']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['banners'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['banners'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['radio']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['radio'].tipAmount[ ulevel+1 ]
	vars[3] = vars[3] + val
	
	ulevel = upgrades['cart']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['cart'].extraCustomer[ ulevel+1 ]
	vars[4] = vars[4] + val
	
	_G.engine.setUpgradableVars( vars )
	_G.gui.setUpgradableVars( vars )
	
end

--------------------------- LEVELS:

function buildLevel(grp_main)
	
	main = grp_main
	-- _G.TutorialData.displaying = false
	-- background 
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level1/bg_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	-- customers layer
	local customers = util.addGroup(grp_main, 'customers', 0, 0, 1)
	local requests = util.addGroup(grp_main, 'requests', 0, 0, 1)
	
	-- foreground
	local fg = util.addGroup(grp_main, 'foreground', 0, 0, 1)
	
	-- cart
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	ulevel = upgrades['cart']
	if( not ulevel or ulevel == 0 )then ulevel = 1 end
	
	local cart = util.addGroup(fg, 'cart', 0, 0, 1)
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	local col = 0
	local row = 0
	for i=1, 4 do
		
		local c = util.addImage('graphics/level1/cart0' .. ulevel ..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * col
		c.y = 384 * row
		
		col=col+1
		if(col==2)then
			col=0
			row=row+1
		end
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	cart.customers = customers
	
	-- trays
	util.addImage('graphics/level1/trays.png', cart, 'trays', 342, 304, 1, 1, 0, 1)
	
	-- counter layer
	local counter = util.addGroup(grp_main, 'counter', 0, 0, 1)

end

function buildItems()
	
	print("******** BUILD ITEMS *********")
	
	local bg = main.background
	local cart = main.foreground.cart
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	-- cart
	local ulevel = upgrades['cart']
	print( upgrades['cart'] )
	if( not ulevel or ulevel == 0 )then 
		
		ulevel = 1 
	
	end
	
	-- rebuild cart
	cart.art:removeSelf()
	cart.trays:removeSelf()
	
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	local col = 0
	local row = 0
	for i=1, 4 do
		
		local c = util.addImage('graphics/level1/cart0' .. ulevel ..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * col
		c.y = 384 * row
		
		col=col+1
		if(col==2)then
			col=0
			row=row+1
		end
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	------------------------------------------------
	--- INTERIORS
	------------------------------------------------
	
	ulevel = upgrades[ 'radio' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level1/radio0'..ulevel..'.png', bg, 'tv', -180, -100, 1, 1, 0, 1)
	end
	
	ulevel = upgrades[ 'banners' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel==1 )then
		_G.util.addImage('graphics/level1/banner0'..ulevel..'.png', bg, 'tv', 200, -150, 1, 1, 0, 1)
	end
	if( ulevel==2 )then
		_G.util.addImage('graphics/level1/banner0'..ulevel..'.png', bg, 'tv', 220, -154, .9, .9, 0, 1)
	end
	if( ulevel==3 )then
		_G.util.addImage('graphics/level1/banner0'..ulevel..'.png', bg, 'tv', 240, -150, .9, .9, 0, 1)
	end
	
	------------------------------------------------
	--- CART ITEMS
	------------------------------------------------
	
	-- trays
	util.addImage('graphics/level1/trays.png', cart, 'trays', 342, 304, 1, 1, 0, 1)
	
	-- soda machine
	_G.util.addImage('graphics/level1/items/soda_machine.png', cart, 'img', -400, 132, 1, 1, 0, 1)

	------------------------------------------------
	--- DRAGS
	------------------------------------------------
	
	_G.util.addGroup(cart, 'locks', 0, 0, 1)
	local col, row
	
	-- soda/coffee
	itemList = {}
	local grp = util.addGroup(cart, 'soda', 0, 0, 1)
	
	ulevel = upgrades[ 'soda machine' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['soda machine'].unlocked[ ulevel+1 ]
	
	for i=1, 3 do
		
		local targets = {'customers'}
		
		local f = _G.engine.buildHitArea('#1abc9c', 54, 64, 'auto-fill', targets)
		f.id = 'hit'..i
		f.food = 'drink'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 54
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('soda')
		f:insert(art)
		f.art = art
		f.art.alpha = 1
		f.cooktime = cookTimes['drink']
		_G.engine.hideObjects(f)
		
		f.audioStart = 'pour_start'
		f.audio = 'pour_stop'
		f.loop = 'pour'
		f.select = 'cola'
		
	end
	grp.x = -455
	grp.y = 204
	grp.itemList = itemList
		
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit3.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -448, 204, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -340, 204, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -448, 204, .85, .85, 0, 1)
		
	end
	
	-- knish
	itemList = {}
	local grp = util.addGroup(cart, 'knish', 0, 0, 1)
	
	ulevel = upgrades[ 'fryer' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['fryer'].unlocked[ ulevel+1 ]
	

	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#af7ac4', 64, 64, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'side'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * 22
		f.y = (i-1) * -68
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('fries')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['fries']
		_G.engine.hideObjects(f)
		
		f.loop = 'fryer'
		f.audio = 'fryer_stop'
		f.select = 'fries'
		
	end
	grp.x = -214-34
	grp.y = 190
	grp.itemList = itemList
	
	if( max==1 )then
	
		grp.hit2.isVisible = false
		grp.hit3.isVisible = false
			
	end
	if( max==2 )then
	
		grp.hit3.isVisible = false
		
	end
		
	-- pita
	itemList = {}
	local grp = util.addGroup(cart, 'pita', 0, 0, 1)
		
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#3498db', 64, 64, 'sandwich', targets)
		f.id = 'hit'..i
		f.food = 'meal'
		f.color = '#3498db'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -15
		f.y = (i-1) * 75
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('burger')
		art.y = 16
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		_G.engine.hideObjects(f)
		
	end
	grp.x = -120
	grp.y = 48
	grp.itemList = itemList
	
	ulevel = upgrades[ 'burger tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['burger tabletop'].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -132, 122, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -118, 54, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -118, 54, .85, .85, 0, 1)
		
	end
	
	-- buns
	itemList = {}
	local grp = util.addGroup(cart, 'buns', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#2ecc71', 100, 64, 'sandwich', targets)
		f.id = 'hit'..i
		f.food = 'meal'
		f.color = '#2ecc71'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * -1
		f.y = (i-1) * 74
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('rice')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		_G.engine.hideObjects(f)
		
		--f.select = 'grill'
		
	end
	grp.x = -18
	grp.y = 48
	grp.itemList = itemList
	
	ulevel = upgrades[ 'rice tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['rice tabletop'].unlocked[ ulevel+1 ]

	_G.util.addImage('graphics/gui/lock.png', cart.locks, 'bun-lock1', -16, 198, .85, .85, 0, 1)

	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 122, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 54, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 54, .85, .85, 0, 1)
		
	end

	-- condiments: special
	local colors = {'#ff0000','#ffff00','#ffffff'}
	local condNames= {'mango','lettuce','tomato'}
	local grp = util.addGroup(cart, 'condiments', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'pita'}
		if(i==1)then
			targets = {'buns'}
		end
	
		local f = _G.engine.buildHitArea('#34495e', 80, 64, 'topping', targets)
		f.id = 'hit'..i
		grp:insert(f)
		grp['hit'..i] = f
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
		icon:setFillColor(_G.util.convertHexToRGB(colors[i]) )
		f.color = colors[i]
		f.num = i
		
		ulevel = upgrades[ condNames[i] ]
		if( not ulevel )then ulevel = 0 end
		
		local img
		if( ulevel == 0 )then
			img = _G.util.addImage('graphics/level1/items/' .. condNames[i] .. '-drag01.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			img = _G.util.addImage('graphics/level1/items/' .. condNames[i] .. '-drag02.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			img = _G.util.addImage('graphics/level1/items/' .. condNames[i] .. '-drag02.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			img = _G.util.addImage('graphics/level1/items/' .. condNames[i] .. '-drag03.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end

		f:insert(img)
		f.art = img
		img.alpha = 0

		f.x = (i-1) * 11
		f.y = (i-1) * 72
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local img
		if( ulevel == 0 )then
			img = util.addImage('graphics/level1/items/' .. condNames[i] .. '01.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			img = util.addImage('graphics/level1/items/' .. condNames[i] .. '02.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			img = util.addImage('graphics/level1/items/' .. condNames[i] .. '02.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			img = util.addImage('graphics/level1/items/' .. condNames[i] .. '03.png', cart, 'img', 0, 0, 1, 1, 0, 1)
		end

		img.x = f.x+74
		img.y = f.y+52
		f.base = img
		if(i==1)then img.x = img.x + 4; img.y=img.y-20 end
		
		_G.engine.hideObjects(f)
		
	end
	grp.x = 75
	grp.y = 52
	
	-- gyro
	itemList = {}
	local grp = util.addGroup(cart, 'gyro', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'pita','warmers','garbage'}
	
		local f = _G.engine.buildHitArea('#f1c40f', 64, 64, 'meat', targets)
		f.id = 'hit'..i
		f.meat = 'burger'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 22
		f.y = (i-1) * 74
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('patty')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['burger']
		_G.engine.hideObjects(f)
		
		f.audio = 'burger_stop'
		f.loop = 'burger'
		f.select = 'grill'
		
		f.cookParticle = 'graphics/effects/smoke.png'
		
	end
	grp.x = 170
	grp.y = 56
	grp.itemList = itemList
	
	ulevel = upgrades[ 'burger grill' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['burger grill'].unlocked[ ulevel+1 ]

	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 184, 122, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 164, 54, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 164, 54, .85, .85, 0, 1)
		
	end

	-- hotdog
	itemList = {}
	local grp = util.addGroup(cart, 'hotdog', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'buns','warmers','garbage'}
	
		local f = _G.engine.buildHitArea('#e67e22', 64, 64, 'meat', targets)
		f.id = 'hit'..i
		f.meat = 'chicken'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 38
		f.y = (i-1) * 74
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('chicken')
		f:insert(art)
		f.art = art
		f.art.y = -10
		f.art.alpha = 0
		f.cooktime = cookTimes['chicken']
		_G.engine.hideObjects(f)
		
		f.audio = 'chicken_stop'
		f.loop = 'chicken'
		f.select = 'grill'
		
		f.cookParticle = 'graphics/effects/smoke.png'
		
	end
	grp.x = 270
	grp.y = 44
	grp.itemList = itemList
	
	ulevel = upgrades[ 'chicken grill' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['chicken grill'].unlocked[ ulevel+1 ]

	_G.util.addImage('graphics/gui/lock.png', cart.locks, 'hotdog-lock1', 350, 198, .85, .85, 0, 1)

	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 308, 122, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 276, 54, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 276, 54, .85, .85, 0, 1)
		
	end
	
	-- warmers
	scaleList = {.82,.88,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'warmers', 0, 0, 1)
	for i=1, 4 do
	
		local targets = {}
	
		local f = _G.engine.buildHitArea('#e74c3c', 64, 54, 'warmer', targets)
		f.id = 'hit'..i
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 40
		f.y = (i-1) * 58
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('warmer')
		f:insert(art)
		f.art = art
		f.art.alpha = 1
		_G.engine.hideObjects(f)
		
		local img = _G.util.addImage('graphics/level1/items/warmer.png', cart, 'warmer'..i, 0, 0, 1, 1, 0, 1)
		img.x = f.x+362
		img.y = f.y+22
		img.xScale = f.xScale
		img.yScale = f.yScale
		
		f.select = 'grill'
		
	end
	grp:toFront()
	grp.x = 362
	grp.y = 22
	grp.itemList = itemList
	
	ulevel = upgrades[ 'warmers' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['warmers'].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		grp.hit3.isVisible = false
		
		cart.warmer1.isVisible = false
		cart.warmer2.isVisible = false
		cart.warmer3.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		cart.warmer1.isVisible = false
		cart.warmer2.isVisible = false
		
	end
	if( max==3 )then
	
		grp.hit1.isVisible = false
		
		cart.warmer1.isVisible = false
		
	end
	
	------------------------------------------------
	--- TAPS
	------------------------------------------------
	
	-- garbage
	local grp = util.addGroup(cart, 'garbage', 0, 0, 1)
	local f = _G.engine.buildHitArea('#333333', 150, 128, 'garbage', nil)
	grp:insert(f)
	f.over:setFillColor(1,0,0)
	grp.x = -370
	grp.y = 320
	f.alpha = .5
	_G.engine.hideObjects(f)
		
	-- knish
	local grp = util.addGroup(cart, 'knish-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 100)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = -250
	grp.y = 304
	f.audio = 'fryer_start'
	f.loop = 'fryer'
	
	local art = buildArtwork('fryer')
	art.y = 2
	grp:insert(art)
	f.art = art
	f.alpha = .01
	
	-- pita
	local grp = util.addGroup(cart, 'pita-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 128, 64)
	f:setFillColor( _G.util.convertHexToRGB('#2980b9') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = -147
	grp.y = 282
	f.audio = 'bun'
	
	ulevel = upgrades[ 'buns' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level1/items/buns-tap01.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level1/items/buns-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level1/items/buns-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level1/items/buns-tap03.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	
	f.alpha = .01
	
	-- buns
	local grp = util.addGroup(cart, 'buns-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 100, 64)
	f:setFillColor( _G.util.convertHexToRGB('#27ae60') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = -16
	grp.y = 281
	f.audio = 'rice'
	
	ulevel = upgrades[ 'rice' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level1/items/rice-tap01.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level1/items/rice-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level1/items/rice-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level1/items/rice-tap03.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end

	f.alpha = .01
	
	-- gyro
	local grp = util.addGroup(cart, 'gyro-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 128, 64)
	f:setFillColor( _G.util.convertHexToRGB('#f39c12') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = 264
	grp.y = 310
	f.audio = 'burger_start'
	f.loop = 'burger'
	
	ulevel = upgrades[ 'patty' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level1/items/burger-tap01.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level1/items/burger-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level1/items/burger-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level1/items/burger-tap03.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end

	f.alpha = .01
	
	-- hotdog
	local grp = util.addGroup(cart, 'hotdog-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 128, 64)
	f:setFillColor( _G.util.convertHexToRGB('#d35400') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = 414
	grp.y = 298
	f.audio = 'chicken_start'
	f.loop = 'chicken'
	
	ulevel = upgrades[ 'chicken' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level1/items/chicken-tap01.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level1/items/chicken-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level1/items/chicken-tap02.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level1/items/chicken-tap03.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	end
	
	f.alpha = .01
		
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


	print( "#############",high )

	-- testing
	if(_G.launchType=='Debug')then high=30 end
	
	-- eval
	if( high < 4-1 )then
	
		cart.warmer4.isVisible = false
		cart['warmers'].y = 2000
		cart['hotdog-tap'].isVisible = false
		cart['buns-tap'].isVisible = false
		cart['condiments'].hit1.isVisible = false
		cart['condiments'].hit1.base.isVisible = false
		cart['condiments'].hit2.isVisible = false
		cart['condiments'].hit2.base.isVisible = false
		cart['condiments'].hit3.isVisible = false
		cart['condiments'].hit3.base.isVisible = false
		cart['knish-tap'].isVisible = false
		
	elseif( high < 5-1 )then
	
		cart['condiments'].hit1.isVisible = false
		cart['condiments'].hit1.base.isVisible = false
		cart['condiments'].hit2.isVisible = false
		cart['condiments'].hit2.base.isVisible = false
		cart['condiments'].hit3.isVisible = false
		cart['condiments'].hit3.base.isVisible = false
		cart['knish-tap'].isVisible = false
		
		cart.locks['bun-lock1'].isVisible = false
		cart.locks['hotdog-lock1'].isVisible = false
		
	elseif( high < 11-1 )then
	
		cart['condiments'].hit2.isVisible = false
		cart['condiments'].hit2.base.isVisible = false
		cart['condiments'].hit3.isVisible = false
		cart['condiments'].hit3.base.isVisible = false
		cart['knish-tap'].isVisible = false

		cart.locks['bun-lock1'].isVisible = false
		cart.locks['hotdog-lock1'].isVisible = false
		
	elseif( high < 12-1 )then
	
		cart['condiments'].hit3.isVisible = false
		cart['condiments'].hit3.base.isVisible = false
		cart['knish-tap'].isVisible = false
		
		cart.locks['bun-lock1'].isVisible = false
		cart.locks['hotdog-lock1'].isVisible = false
		
	elseif( high < 18-1 )then
	
		cart['knish-tap'].isVisible = false
		
		cart.locks['bun-lock1'].isVisible = false
		cart.locks['hotdog-lock1'].isVisible = false
		
	else
	
		cart.locks['bun-lock1'].isVisible = false
		cart.locks['hotdog-lock1'].isVisible = false
	
	end
	
end

--------------------------- CUSTOMERS:

function buildCustomers(grp_main)

	-- pull main
	local customers = grp_main.customers
	
	-- build 4
	local cList = {}
	for i=1, 4 do
	
		local c = _G.engine.buildCustomer()
		c.y = -128
		customers:insert(c)
		
		c.x = ( (i-1) * 256 ) - 512 + 128
		c.endX = c.x
		c.endY = c.y
		
		local dir = math.floor(math.random()*2)+1
		if( dir==1 )then
	
			c.x = c.x + CUSTOMER_OFFSET
		
		else
		
			c.x = c.x - CUSTOMER_OFFSET
		
		end 
		
		cList[#cList+1] = c
		
		grp_main.requests:insert( c.request )
		c.request.x = c.request.x + c.endX
		c.request.y = c.request.y + c.endY
		
	end
	_G.util.table.shuffle(cList)
	grp_main.customers.cList = cList
	
end

function setCustomerRequest(customer)

	-- remove requests
	if( customer.requests )then
		customer.requests:removeSelf()
		customer.requests = nil
	end

	-- 3 types: drink, side, meal
	local rtypes = {'drink','side','meal'}
	
	local request = _G.util.addGroup(customer, 'requests', 0, 0, 1)
	local food = nil
	local art = nil
	
	-- save request num
	customer.rlimit = rlimit
	
	-- pull order
	local order = levelData.orders[ curCustomer ].order
	for i=1, #order do
	
		print(order[i])
		
	end
	local rlimit = #order
	curCustomer = curCustomer+1
	
	-- build request
	for i=1, rlimit do
		
		local rnum = math.floor(math.random()*3)+1
		
		-- add drink
		if( order[i] == 'S' )then
			
			food = _G.engine.buildHitArea('#1abc9c', 64, 64, 'none')
			food.food = 'drink'
			food.value = foodValues['drink']
			
			art = buildArtwork('soda')
			art.full.alpha = 1
			art.empty.alpha = 0
			food:insert(art)

		end
		
		-- add side
		if( order[i] == 'F' )then
			
			print('add fries')
			
			food = _G.engine.buildHitArea('#af7ac4', 64, 64, 'none')
			food.food = 'side'
			food.color = '#af7ac4'
			food.value = foodValues['fries']
			
			art = buildArtwork('fries')
			art.shadow.alpha = 0
			food:insert(art)
			
		end
		
		-- add meal
		if( (order[i] ~= 'S') and (order[i] ~= 'F') )then
			
			local rmeat = order[i]:sub( 1,1 )
			
			if( rmeat == 'B' )then
			
				-- pita
				food = _G.engine.buildHitArea('#3498db', 64, 64, 'none')
				util.addFill(food.contents, 'meat', 0, 0, 0, 1, 0, -12, 48, 24)
				food.contents.meat:setFillColor( _G.util.convertHexToRGB('#f1c40f') )
				food.meat = true
				
				food.color = '#3498db'
				food.contents.meat.color = '#f1c40f'
				food.value = foodValues['burger']
				food.value = food.value + foodValues['buns']
				
				-- get artwork
				art = buildArtwork('burger')
				art.y = 22
				art.shadow.alpha = 0
				art.full.alpha = 1
				art.top.y = art.top.y - 7
				food:insert(art)
				
				-- choose toppings
				local t1 = order[i]:sub( 2,2 )
				local t2 = order[i]:sub( 3,3 )
				
				if(t1~='')then
					
					if(t1=='L')then
					
						food.topping2 = true
						art.lettuce.alpha = 1
						art.lettuce.y = art.lettuce.y-7
						art.tomato.y = art.tomato.y-7
						art.top.y = art.top.y - 7
						
					end
					
					if(t1=='T')then
					
						food.topping3 = true
						art.tomato.alpha = 1
						art.tomato.y = art.tomato.y-7
						art.top.y = art.top.y - 7
						
					end
					
					art.xScale = .9
					art.yScale = .9
				
				end
				
				if(t2~='')then
					
					if(t2=='L')then
					
						food.topping2 = true
						art.lettuce.alpha = 1
						art.lettuce.y = art.lettuce.y-7
						art.tomato.y = art.tomato.y-7
						art.top.y = art.top.y - 7
						
					end
					
					if(t2=='T')then
					
						food.topping3 = true
						art.tomato.alpha = 1
						art.tomato.y = art.tomato.y-7
						art.top.y = art.top.y - 7
						
					end
					
					art.xScale = .9
					art.yScale = .9
				
				end
				
			end
			
			if( rmeat == 'C' )then
				
				-- buns
				food = _G.engine.buildHitArea('#2ecc71', 64, 64, 'none')
				util.addFill(food.contents, 'meat', 0, 0, 0, 1, 0, -12, 48, 24)
				food.contents.meat:setFillColor( _G.util.convertHexToRGB('#e67e22') )
				
				food.color = '#2ecc71'
				food.contents.meat.color = '#e67e22'
				food.value = foodValues['chicken']
				food.value = food.value + foodValues['rice']
				
				-- get artwork
				art = buildArtwork('rice')
				art.y = 0
				art.shadow.alpha = 0
				art.chicken.alpha = 1
				art.xScale = .8
				art.yScale = .8
				food:insert(art)
				
				-- choose toppings
				local t1 = order[i]:sub( 2,2 )
				
				if(t1~='')then
					
					if(t1=='M')then
					
						food.topping1 = true
						art.mango1.alpha = 1
						art.mango2.alpha = 1
						
					end
				
				end
				
			end
			
			food.food = 'meal'
			
		end
		
		-- place food
		food.y = i * 80
		request:insert(food)
		
		-- hide objects
		_G.engine.hideObjects(food)
		
	end
	
	-- position request
	request.value = 0
	request.x = 65
	request.y = -58
	request.xScale = .65
	request.yScale = request.xScale
	request.y = request.y - (request.height * request.xScale * .5)
	
	-- reposition
	customer.request:insert( request )
	request.x = 10
	request.y = request.y + 33
	
end

--------------------------- OBJECTS:

function buildArtwork(food)

	local grp = display.newGroup()
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	if(food=='soda')then
		
		ulevel = upgrades[ 'soda' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/soda01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level1/items/soda02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/soda03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level1/items/soda04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/soda03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level1/items/soda04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/soda05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level1/items/soda06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='fryer')then

		_G.util.addImage('graphics/level1/items/fryer00.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/level1/items/fryer01.png', grp, 'cooking', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/level1/items/fryer02.png', grp, 'done', 0, 0, 1, 1, 0, 0)
		
	end
	
	if(food=='fries')then

		ulevel = upgrades[ 'fries' ]
		if( not ulevel )then ulevel = 0 end

		_G.util.addImage('graphics/level1/items/fries00.png', grp, 'shadow', 2, 14, 1, 1, 0, 1)
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/fries01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/fries02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/fries02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/fries03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		
	end
		
	if(food=='burger')then
		
		_G.util.addImage('graphics/level1/items/burger00.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
		
		-- bun bottom
		ulevel = upgrades[ 'buns' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/bun-bottom01.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/bun-bottom02.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/bun-bottom02.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/bun-bottom03.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		
		-- patty
		ulevel = upgrades[ 'patty' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/burger02.png', grp, 'full', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp, 'full', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp, 'full', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/burger08.png', grp, 'full', 0, -21, 1, 1, 0, 1)
		end

		-- lettuce
		ulevel = upgrades[ 'lettuce' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/lettuce-drag01.png', grp, 'lettuce', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/lettuce-drag02.png', grp, 'lettuce', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/lettuce-drag02.png', grp, 'lettuce', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/lettuce-drag03.png', grp, 'lettuce', 0, -21, 1, 1, 0, 1)
		end
		
		-- tomato
		ulevel = upgrades[ 'tomato' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/tomato-drag01.png', grp, 'tomato', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/tomato-drag02.png', grp, 'tomato', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/tomato-drag02.png', grp, 'tomato', 0, -21, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/tomato-drag03.png', grp, 'tomato', 0, -21, 1, 1, 0, 1)
		end
		
		-- bun top
		ulevel = upgrades[ 'buns' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/bun-top01.png', grp, 'top', 0, -26, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/bun-top02.png', grp, 'top', 0, -26, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/bun-top02.png', grp, 'top', 0, -26, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/bun-top03.png', grp, 'top', 0, -26, 1, 1, 0, 1)
		end
		
		-- init
		grp.lettuce.alpha = 0
		grp.tomato.alpha = 0
		grp.full.alpha = 0
		
		grp.top.baseY = grp.top.y
		grp.lettuce.baseY = grp.lettuce.y
		grp.tomato.baseY = grp.tomato.y
		
	end
	
	if(food=='rice')then

		_G.util.addImage('graphics/level1/items/rice00.png', grp, 'shadow', 0, 12, 1, 1, 0, 1)	
		
		-- rice
		ulevel = upgrades[ 'rice' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/rice01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/rice02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/rice02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/rice03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		-- mangos (do not upgrade graphics)
		_G.util.addImage('graphics/level1/items/mango-drag01.png', grp, 'mango1', -20, -8, 1, 1, 0, 0)
		_G.util.addImage('graphics/level1/items/mango-drag01.png', grp, 'mango2', 20, -8, 1, 1, 0, 0)
		
		-- plantains
		ulevel = upgrades[ 'rice' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/plantain01.png', grp, 'plantains', -25, -8, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/plantain02.png', grp, 'plantains', -25, -8, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/plantain02.png', grp, 'plantains', -25, -8, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/plantain03.png', grp, 'plantains', -25, -8, 1, 1, 0, 1)
		end
		
		-- chicken
		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/chicken02.png', grp, 'chicken', 23, -28, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp, 'chicken', 23, -28, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp, 'chicken', 23, -28, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/chicken08.png', grp, 'chicken', 23, -28, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='patty')then

		_G.util.addImage('graphics/level1/items/burger00.png', grp, 'shadow', 0, 6, 1, 1, 0, 1)
		print( ":::: Ulavel:::", ulevel )
		ulevel = upgrades[ 'patty' ]
		if( not ulevel )then ulevel = 0 end
		
		-- patty: raw
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/burger03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/burger06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/burger06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/burger09.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		-- patty: full
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/burger02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/burger08.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
		-- patty: burnt
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/burger01.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/burger04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/burger04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/burger07.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
				
	end
	
	if(food=='chicken')then

		_G.util.addImage('graphics/level1/items/chicken00.png', grp, 'shadow', 0, 22, 1, 1, 0, 1)
		
		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end
		
		-- chicken: raw
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/chicken03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/chicken06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/chicken06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/chicken09.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		-- chicken: cooked
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/chicken02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/chicken08.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
		-- chicken: burnt
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/chicken01.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/chicken04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/chicken04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/chicken07.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end

	end
	
	if(food=='warmer')then
		
		--_G.util.addImage('graphics/level1/items/warmer.png', grp, 'warmer', -10, 10, 1, 1, 0, 1)
		
		_G.util.addGroup(grp, 'chicken', 4, -30, 1)
		_G.util.addImage('graphics/level1/items/chicken00.png', grp.chicken, 'shadow_chicken', 0, 22, 1, 1, 0, 1)
		
		-- chicken: cooked
		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/chicken02.png', grp.chicken, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp.chicken, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/chicken05.png', grp.chicken, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/chicken08.png', grp.chicken, 'full', 0, 0, 1, 1, 0, 1)
		end
			
		grp.chicken.xScale = .9
		grp.chicken.yScale = .9
		grp.chicken.alpha = 0
		
		-- burger
		_G.util.addGroup(grp, 'burger', 2, -8, 1)
		_G.util.addImage('graphics/level1/items/burger00.png', grp.burger, 'shadow', 0, 6, 1, 1, 0, 1)
		
		-- patty: cooked
		ulevel = upgrades[ 'patty' ]
		if( not ulevel )then ulevel = 0 end
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level1/items/burger02.png', grp.burger, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp.burger, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level1/items/burger05.png', grp.burger, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level1/items/burger08.png', grp.burger, 'full', 0, 0, 1, 1, 0, 1)
		end
		
		grp.burger.alpha = 0
		
	end
	
	return grp
	
end

function updateArtwork(targ)

	if(targ.mode == 'sandwich')then
	
		if(targ.parent.id == 'pita')then
			
			targ.art.lettuce.y = targ.art.lettuce.baseY
			targ.art.tomato.y = targ.art.tomato.baseY
			targ.art.top.y = targ.art.top.baseY
			
			if( targ.meat )then
				
				targ.art.full.alpha = 1
				
				targ.art.lettuce.y = targ.art.lettuce.y-7
				targ.art.tomato.y = targ.art.tomato.y-7
				targ.art.top.y = targ.art.top.y - 7
				
			end
			
			if( (targ['topping2']) )then
				
				targ.art.lettuce.alpha = 1
				
				targ.art.tomato.y = targ.art.tomato.y-7
				targ.art.top.y = targ.art.top.y - 7
				
			end
			
			if( (targ['topping3']) )then
				
				targ.art.tomato.alpha = 1
				
				targ.art.top.y = targ.art.top.y - 7
				
			end
					
		end
		
		if(targ.parent.id == 'buns')then
						
			if( targ.meat )then
				
				targ.art.chicken.alpha = 1

			end
			
			if( (targ['topping1']) )then
				
				targ.art.mango1.alpha = 1
				targ.art.mango2.alpha = 1
				
			end
					
		end
		
	end
	
end

function resetCooker()

	local obj = main.foreground.cart['knish-tap']
	obj.hit.art.empty.alpha = 1
	obj.hit.art.cooking.alpha = 0
	
	local grp = main.foreground.cart['knish']
	for i=1, grp.numChildren do
	
		local obj = grp[i]
		obj.meter.alpha = 0
		obj.off.alpha = 0
		obj.art.alpha = 1
		obj.art.full.alpha = 1
		obj.empty.alpha = 0
		
	end
	
end

function evaluateTrash(obj)
	
	local value = 0
	
	-- meats
	if(obj.mode == 'meat')then
		
		if(obj.meat=='burger')then
	
			value = value + foodValues['burger']
	
		else
	
			value = value + foodValues['chicken']
	
		end
		
	end
	
	-- sandwiches
	if(obj.mode == 'sandwich')then
		
		-- bun or rice
		if(obj.color=='#3498db')then
		
			value = value + foodValues['buns']
		
		else
		
			value = value + foodValues['rice']
		
		end
		
		-- burger or chicken
		if(obj.meat)then
		
			if(obj.meatType=='burger')then
		
				value = value + foodValues['burger']
		
			else
		
				value = value + foodValues['chicken']
		
			end
			
		end
		
		-- toppings
		if(obj.topping1)then value = value + foodValues['c1'] end
		if(obj.topping2)then value = value + foodValues['c2'] end
		if(obj.topping3)then value = value + foodValues['c3'] end
		
	end
	
	-- warmed meat
	if(obj.mode == 'warmer')then
	
		if(obj.meatType=='burger')then
	
			value = value + foodValues['burger']
	
		else
	
			value = value + foodValues['chicken']
	
		end
		
	end
	
	-- half value
	value = math.floor(value * .5)
	
	return value
	
end

--------------------------- EVENTS:

function addToSandwich(obj, targ)
				
	if( obj.mode == 'meat' )then
	
		util.addFill(targ.contents, 'meat', 0, 0, 0, 0, 0, -12, 48, 24)
		targ.contents.meat:setFillColor( _G.util.convertHexToRGB(obj.color) )
		targ.meat = true
		
		targ.meatType = obj.meat
		
		-- show art
		updateArtwork(targ)
		
		if(obj.meat == 'burger')then
			_G.mixer.playSFX('bun_meat')
		end
		if(obj.meat == 'chicken')then
			_G.mixer.playSFX('rice_meat')
		end
		
	end
	
	if( obj.mode == 'topping' )then
		
		if( targ['topping'..obj.num] == nil )then
			
			local f = util.addFill(targ.contents, 'c', 0, 0, 0, 0, 0, 12, 14, 14)
			f:setFillColor( _G.util.convertHexToRGB(obj.color) )
			targ['topping'..obj.num] = true
			
			f.x = ( (obj.num) * -16 ) + 32
			
			updateArtwork(targ)
			
			if( obj.num == 1 )then
			
				_G.mixer.playSFX('mango')
				
			end
			if( obj.num == 2 )then
			
				_G.mixer.playSFX('lettuce')
				
			end
			if( obj.num == 3 )then
			
				_G.mixer.playSFX('tomato')
				
			end
			
		end
					
	end
	
	if( obj.mode == 'warmer' )then
	
		util.addFill(targ.contents, 'meat', 0, 0, 0, 0, 0, -12, 48, 24)
		targ.contents.meat:setFillColor( _G.util.convertHexToRGB(obj.color) )
		targ.meat = true
		targ.meatType = obj.meat
		
		updateArtwork(targ)
		
	end
	
end

function addToWarmer(obj, targ)
	
	util.addFill(targ.contents, 'meat', 0, 0, 0, 1, 0, 0, 48, 24)
	targ.contents.meat:setFillColor( _G.util.convertHexToRGB(obj.color) )
	targ.full = true
	targ.color = obj.color
	
	targ.meatType = obj.meat
	
	targ.targets = {}
	targ.targets = obj.targets
	
	-- artwork
	if( targ.art )then
		
		targ.contents.isVisible = false
		targ.art[ obj.meat ].alpha = 1
		
	end
	
	-- audio
	_G.mixer.playSFX('warmer')
	
end

----------------------------- TUTORIAL:
--
--function startTutorial( num )
--	local num = num or 1
--	setTutorial(num)
--	
--end

--function onTutorialTouch(e)
--
--	if(e.phase~='began')then return end
--	if(e.target.alpha ~= 1)then return end
--        
--         _G.tutorialRunning = false
--
--        -- hide window
--        local endClosure = function() return _G.util.dropImage(info) end	
--        transition.to( info, {delay=0, time=100, y=info.y+40, alpha=0, transition=easing.inBack,onComplete=endClosure})
--        
--        loadNextTutorial()
--end
---- hide Tutorial window
--function hideTutorial()
--    
--        _G.util.dropImage(info)
--        
--end
--
--function loadNextTutorial()
--        
--        if info then
--            _G.util.dropImage(info)
--        end
--    
--        -- set by step	
--	if(info.step == 1)then
--		-- force entry
--		local cList = main.customers.cList
--		_G.engine.resetCustomer( cList[1] )
--		timer.cancel( cList[1].curTimer )
--		local myclosure = function() return _G.engine.enterCustomer(cList[1]) end	
--		cList[1].curTimer = timer.performWithDelay( 300, myclosure)
--		
----		-- set next step
----		local myclosure = function() return setTutorial(2) end	
----		timer.performWithDelay( 2500, myclosure )
--		
--	end	
--	
----	if(info.step == 2)then
----		-- set next step
----		local myclosure = function() return setTutorial(3) end
----		timer.performWithDelay( 500, myclosure )
----		
----	end
--        
----        if(info.step == 3)then
----                -- set next step
----		local myclosure = function() return setTutorial(4) end	
----		timer.performWithDelay( 1000, myclosure )
----        end
--        
--end
--
function setTutorial(num, callback, xPass, yPass,parentPass)
    local info
	if(num==1)then
        local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["firstCustomerMessage"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["firstCustomerMessage"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("firstCustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
	end
    if(num==13) then
    	info = _G.gui.setTutorial("dragDrink",{ fY = 40, x= -120, y = 310 + 20, group=grp_main })
    end
    if(num==32) then
    	info = _G.gui.setTutorial("waitDrinkReady",{ fY = 40, x= -350, y = 2170, group=grp_main })
    end
    if(num==2)then               
        local cList = {_G.engine.runningCust}
        print("get Clist x pos ::: ",cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["collectMoney"].type = "right"
            xSet = cList[1].x - 280
        else
            _G.TutorialData.data["collectMoney"].type = "left"
            xSet = cList[1].x + 250
        end
        print("xList ::: ",cList[1].x)
        info = _G.gui.setTutorial("collectMoney",{ fY = 40, x= xSet, y = 70, group=grp_main })
        print( "Info :::: " )
        _G.loadsave.print_r(info)
    end
    if(num==25)then
        local cList = {_G.engine.runningCust}                
        print("get Clist x pos ::: ",cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["collectMoney2"].type = "right"
            xSet = cList[1].x - 280
        else
            _G.TutorialData.data["collectMoney2"].type = "left"
            xSet = cList[1].x + 250
        end
        print("xList ::: ",cList[1].x)
        info = _G.gui.setTutorial("collectMoney2",{ fY = 40, x= xSet, y = 70, group=grp_main })
        print( "Info :::: " )
        _G.loadsave.print_r(info)
    end
    if (num==4) then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("pattyToFries",{ fY = 40, x= 260, y = 260, group=grp_main, callback = callback })
    end
        
	if num == 3 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("burgerBanBottom",{ fY = 40, x= -150, y = 240, group=grp_main, callback = callback })
    end

    if num == 5 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("pattyFried",{ fY = 40, x= -150, y = 140, group=grp_main, callback = callback })
    end
	if (num==7) then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("chikanFrier",{ fY = 40, x= 380, y = 260, group=grp_main, callback = callback })
    end
    if (num==29) then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("secondChikanFrier",{fY = 40, x= 380, y = 260, group=grp_main, callback = callback })
    end
	if num == 6 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("ricePlat",{ fY = 40, x= -10, y = 230, group=grp_main, callback = callback })
    end
    if num == 8 then
    	print( "Come here  to 8 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("chikanFried",{ fY = 40, x= -50, y = 160, group=grp_main, callback = callback })
    end
    if num == 31 then
    	print( "Come here  to 8 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("warmerMessageChikanFrier",{ fY = 40, x= 450, y = 160, group=grp_main, callback = callback })
    end
    
    if(num==33)then
        local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["dragPattyToCustomer"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["dragPattyToCustomer"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("dragPattyToCustomer",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
	end
	if num == 34 then
    	print( "Come here  to 8 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitFrier",{ fY = 40, x= -250, y = 240, group=grp_main, callback = callback })
    end
	
	if num == 18 then
    	print( "Come here  to 18 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitPattyFried",{ fY = 40, x= 220, y = 140, group=grp_main, callback = callback })
    end
    if num == 30 then
    	print( "Come here  to 29 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("wait2PattyFried",{ fY = 40, x= 380, y = 140, group=grp_main, callback = callback })
    end
    if num == 26 then
    	print( "Come here  to 26 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitChikanFried",{ fY = 40, x= 380, y = 140, group=grp_main, callback = callback })
    end
    if num == 9 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("PitaSelect",{ fY = 40, x= 325, y = 140, group=grp_main, callback = callback })
    end

    if num == 10 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("lettuceTopings",{ fY = 40, x= 355, y = 200, group=grp_main, callback = callback })
    end

    if num == 11 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("tometoToping",{ fY = 40, x= 355, y = 290, group=grp_main, callback = callback })
    end

    if num == 12 then
    	_G.loadsave.print_r( callback )
    	print("Decay Item Call")
        info = _G.gui.setTutorial("decayItem",{ fY = 40, x= -350, y = 290, group=parentPass, callback = callback })
    end
    
    if num == 15 then
    	_G.loadsave.print_r( callback )
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["dragFrier"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["dragFrier"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("dragFrier",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end
    
    if num == 14 then
    	print( "Come here  to 15 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("tapFrier",{ fY = 40, x= -250, y = 240, group=grp_main, callback = callback })
    end
    if num == 16 then
    	print( "Come here  to 16 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("wellcomeHaggisMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 22 then
    	print( "Come here  to 22 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("wellcomeHaggisMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 23 then
    	print( "Come here  to 23 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("wellcomeTopingsMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 24 then
    	print( "Come here  to 24 data" )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("wellcomeLastMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end

    
    print( "Number ::::: ",num )
	if num == 19 then
    	print( "Come here  to 19 data" )
    	_G.loadsave.print_r( callback )
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["dragBurgerBanBottom"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["dragBurgerBanBottom"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("dragBurgerBanBottom",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
        -- info = _G.gui.setTutorial("dragBurgerBanBottom",{ fY = 40, x= -150, y = 140, group=grp_main, callback = callback })
    end
    
 --    print( "Number ::::: ",num )
	-- if num == 20 then
 --    	print( "Come here  to 20 data" )
 --    	_G.loadsave.print_r( callback )
 --        info = _G.gui.setTutorial("upgradInfo",{ fy = 100, y=110, group=grp_main, callback = callback })
 --    end
	if num == 21 then
		local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["thirdCustomerMessage"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["thirdCustomerMessage"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("thirdCustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end

    print( "Number :::: ",num )
    if num == 17 then
    	local cList = {_G.engine.runningCust}
        print_r(cList)
        local xSet = 0
        if( cList[1].x > 0 )then
                _G.TutorialData.data["secondCustomerMessage"].type = "right"
                xSet = cList[1].x - 330
        else
                _G.TutorialData.data["secondCustomerMessage"].type = "left"
                xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("secondCustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
        print_r(info)
    end

    print( "Number :::: ",num )
    if num == 27 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("throwOtherBurger",{ fY = 40, x= 260, y = 260, group=grp_main, callback = callback })
    end
    print( "Number :::: ",num )
    if num == 28 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("secondWaitPattyFried",{ fY = 40, x= 250, y = 140, group=grp_main, callback = callback })
    end
    if info ~= nil then
		print( "infoname ::: ",info.tutName )
    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
    	print_r(info.passData)
    end

    return info
        
end

--------------------------- MODULE EVENTS:

