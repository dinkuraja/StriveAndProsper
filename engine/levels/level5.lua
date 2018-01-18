
module(..., package.seeall)

-------------------------- CONSTANTS

local CUSTOMER_OFFSET = 1400

-------------------------- VARIABLES

local main
local levelData
local foodValues = {}
local cookTimes = {}
isTutDisplay = false
local tutObj = nil
isTutDisplayed = false
--------------------------- GET/SET

function setLevelData(data)
	
	curCustomer = 1
	levelData = data
	
	-- set food values
	print('level data:')
	--print( _G.levelInfo.upgrades['soda'].name )
	
	-- get user upgrades
	local upgrades = _G.userdata.leveldata[_G.curLevelNum].upgrades
	local ulevel = 0
	local revenue = 0
	local cooktime = 0
	
	-- set iced tea
	ulevel = upgrades['iced-tea']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['iced-tea'].revenue[ ulevel+1 ]
	foodValues['iced-tea'] = revenue
	
	ulevel = upgrades['drink-machine']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['drink-machine'].prepTime[ ulevel+1 ]
	cookTimes['drink-machine'] = cooktime * 60
	
	-- set lemonade
	ulevel = upgrades['lemonade']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['lemonade'].revenue[ ulevel+1 ]
	foodValues['lemonade'] = revenue
	
	-- set chicken
	ulevel = upgrades['chicken']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['chicken'].revenue[ ulevel+1 ]
	foodValues['chicken'] = revenue
	
	ulevel = upgrades['chicken-pot']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['chicken-pot'].prepTime[ ulevel+1 ]
	cookTimes['chicken'] = cooktime * 60
	
	-- set pork
	ulevel = upgrades['pork']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['pork'].revenue[ ulevel+1 ]
	foodValues['pork'] = revenue
	
	ulevel = upgrades['pork-pot']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['pork-pot'].prepTime[ ulevel+1 ]
	cookTimes['pork'] = cooktime * 60
	
	-- set beef
	ulevel = upgrades['beef']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['beef'].revenue[ ulevel+1 ]
	foodValues['beef'] = revenue
	
	ulevel = upgrades['beef-pot']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['beef-pot'].prepTime[ ulevel+1 ]
	cookTimes['beef'] = cooktime * 60
	
	-- set plates
	ulevel = upgrades['plates']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['plates'].revenue[ ulevel+1 ]
	foodValues['plates'] = revenue
	
	-- set containers
	ulevel = upgrades['containers']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['containers'].revenue[ ulevel+1 ]
	foodValues['containers'] = revenue
	
	-- set waffles
	ulevel = upgrades['waffles']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['waffles'].revenue[ ulevel+1 ]
	foodValues['waffles'] = revenue
	
	-- set greens
	ulevel = upgrades['greens']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['greens'].revenue[ ulevel+1 ]
	foodValues['greens'] = revenue
	
	-- set mac
	ulevel = upgrades['mac']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['mac'].revenue[ ulevel+1 ]
	foodValues['mac'] = revenue
	
	----------------------------
	--------- INTERIORS --------
	----------------------------
	
	-- tip time, wait time, tip amount, extras
	local vars = {0,0,0,0}
	
	ulevel = upgrades['tvs']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['tvs'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['tvs'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['plants']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['plants'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['air conditioner']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['air conditioner'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['speakers']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['speakers'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['speakers'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['pinball']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['pinball'].tipAmount[ ulevel+1 ]
	vars[3] = vars[3] + val
	
	ulevel = upgrades['restaurant']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['restaurant'].extraCustomer[ ulevel+1 ]
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
	ulevel = upgrades[ 'restaurant' ]
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then  ulevel = 1 end
	
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -390
	
	-- midground 
	local mg = util.addGroup(grp_main, 'midground', 0, 0, 1)
	local grp = util.addGroup(mg, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/mg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -210
	
	-- customers layer
	local customers = util.addGroup(grp_main, 'customers', 0, 0, 1)
	local requests = util.addGroup(grp_main, 'requests', 0, 0, 1)
	
	-- foreground
	local fg = util.addGroup(grp_main, 'foreground', 0, 0, 1)
	
	-- cart
	local cart = util.addGroup(fg, 'cart', 0, 0, 1)
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/fg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -46
	cart.customers = customers
	
	-- counter layer
	local counter = util.addGroup(grp_main, 'counter', 0, 0, 1)

end

function buildItems()
	
	print("******** BUILD ITEMS *********")
	
	local bg = main.background
	local mg = main.midground
	local cart = main.foreground.cart
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	local col = 0
	local row = 0
	
	-- rebuild bg
	bg.art:removeSelf()	
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	
	ulevel = upgrades[ 'restaurant' ]
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then  ulevel = 1 end
	
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	-- rebuild mg
	mg.art:removeSelf()
	local grp = util.addGroup(mg, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/mg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.alpha = 1
	grp.x = grp.width * -.5
	grp.y = -210
	
	-- rebuild fg
	cart.art:removeSelf()	
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	
	for i=1, 2 do
		
		local c = util.addImage('graphics/level5/fg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -46

	------------------------------------------------
	--- INTERIORS
	------------------------------------------------

	ulevel = upgrades[ 'tvs' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level5/tv0'..ulevel..'.png', bg, 'tv', 452, -310, 1, 1, 0, 1)
	end
	
	-- speakers
	ulevel = upgrades[ 'speakers' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level5/speaker0'..ulevel..'.png', bg, 's', 111, -260, 1, 1, 0, 1)
		_G.util.addImage('graphics/level5/speaker0'..ulevel..'.png', bg, 's', -114, -260, -1, 1, 0, 1)
	end
	
	-- plants
	ulevel = upgrades[ 'plants' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level5/plant0'..ulevel..'.png', bg, 'plant', 111, -190, 1, 1, 0, 1)
		_G.util.addImage('graphics/level5/plant0'..ulevel..'.png', bg, 'plant', -116, -190, 1, 1, 0, 1)
	end
	
	-- ac
	ulevel = upgrades[ 'air conditioner' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level5/ac0'..ulevel..'.png', bg, 'plant', -460, -280, 1, 1, 0, 1)
	end
	
	-- pinball
	ulevel = upgrades[ 'pinball' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level5/pinball.png', bg, 'pb', -500, -170, 1, 1, 0, 1)
	end
	
	------------------------------------------------
	--- CART ARTWORK
	------------------------------------------------
	
	-- soda machine
	_G.util.addImage('graphics/level5/items/soda-machine.png', cart, 'img', -386, 86, 1, 1, 0, 1)
	
	-- waffle tray
	_G.util.addImage('graphics/level5/items/tray-waffles.png', cart, 'img', -234, 108, 1, 1, 0, 1)
	
	-- water tray
	_G.util.addImage('graphics/level5/items/tray-water.png', cart, 'img', 100-10, 108, 1, 1, 0, 1)
	
	-- cupcake tray
	_G.util.addImage('graphics/level5/items/tray-cupcakes.png', cart, 'img', -62-10, 318, 1, 1, 0, 1)
	
	------------------------------------------------
	--- DRAGS
	------------------------------------------------
		
	-- soda/lemonade
	itemList = {}
	local grp = util.addGroup(cart, 'soda', 0, 0, 1)
	
	ulevel = upgrades[ 'drink-machine' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['drink-machine'].unlocked[ ulevel+1 ]
	
	for i=1, 4 do
		
		local targets = {'customers'}
		
		local f = _G.engine.buildHitArea('#1abc9c', 50, 64, 'auto-fill', targets)
		f.id = 'hit'..i
		f.food = 'drink'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 46
		f.y = (i-1) * 3
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art
		if( i<3 )then
			art = buildArtwork('lemonade')
			f.drinktype = 'lemonade'
		else
			art = buildArtwork('iced-tea')
			f.drinktype = 'iced-tea'
		end
		
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
	grp.x = -462
	grp.y = 132
	grp.itemList = itemList
	
	if( max==2 )then
	
		grp.hit1.isVisible = false
		grp.hit4.isVisible = false
		
	end
	if( max==3 )then
	
		grp.hit4.isVisible = false
		
	end
		
	-- waffles
	scaleList = {1,.95,.9}
	itemList = {}
	local grp = util.addGroup(cart, 'waffle', 0, 0, 1)
	
	ulevel = upgrades[ 'waffle-iron' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['waffle-iron'].unlocked[ ulevel+1 ]
	
	for i=1, 3 do
	
		local targets = {'plate','garbage'}
	
		local f = _G.engine.buildHitArea('#af7ac4', 64, 58, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'side'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * 17
		f.y = (i-1) * -57
		f.xScale = scaleList[i]
		f.yScale = f.xScale
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('waffle')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['fries']
		_G.engine.hideObjects(f)
		
		f.audioStart = 'fryer_start'
		f.audio = 'fryer_stop'
		f.loop = 'fryer'
		f.select = 'waffle'
		
	end
	grp.x = -234-10
	grp.y = 160
	grp.itemList = itemList
	
	if( max==1 )then
	
		grp.hit2.isVisible = false
		grp.hit3.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit3.isVisible = false
		
	end

	-- plate
	scaleList = {.88,.95,1}
	itemList = {}
	local grp = util.addGroup(cart, 'plate', 0, 0, 1)
		
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#3498db', 90, 64, 'sandwich', targets)
		f.id = 'hit'..i
		f.food = 'meal'
		f.color = '#3498db'
		f.type = 'plate'
		grp:insert(f)
		grp['hit'..i] = f
		
		f.sMeat = ''
		f.sWaffle = ''
		f.sGreens = ''
		f.sMac = ''

		itemList[i] = f
		f.x = (i-1) * -10
		f.y = (i-1) * 62
		f.xScale = scaleList[i]
		f.yScale = f.xScale
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		f.select = 'plate'
	
		local art = buildArtwork('plate')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		_G.engine.hideObjects(f)
		
	end
	grp.x = -110-10
	grp.y = 44
	grp.itemList = itemList
	
	ulevel = upgrades[ 'plates tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['plates tabletop'].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end

	-- containers
	scaleList = {.88,.95,1}
	itemList = {}
	local grp = util.addGroup(cart, 'container', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#2ecc71', 100, 64, 'sandwich', targets)
		f.id = 'hit'..i
		f.food = 'meal'
		f.type = 'container'
		f.color = '#2ecc71'
		grp:insert(f)
		grp['hit'..i] = f
		
		f.sMeat = ''
		f.sWaffle = ''
		f.sGreens = ''
		f.sMac = ''
		
		f.select = 'container'
		
		itemList[i] = f
		f.x = (i-1) * 3
		f.y = (i-1) * 64
		f.xScale = scaleList[i]
		f.yScale = f.xScale
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('container')
		f:insert(art)
		f.art = art
		art.x = 2
		f.art.alpha = 0
		_G.engine.hideObjects(f)
		
		--f.select = 'grill'
		
	end
	grp.x = -10-10
	grp.y = 42
	grp.itemList = itemList
	
	ulevel = upgrades[ 'containers tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades['containers tabletop'].unlocked[ ulevel+1 ]

	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- condiments: special
	local colors = {'#ff0000','#ffff00'}
	local condNames= {'condiment01','condiment02'}
	local grp = util.addGroup(cart, 'condiments', 0, 0, 1)
	for i=1, 2 do
	
		local targets = {'plate','container'}

		local f = _G.engine.buildHitArea('#34495e', 80, 64, 'topping', targets)
		f.id = 'hit'..i
		grp:insert(f)
		grp['hit'..i] = f
		
		if(i==1)then
			f.select = 'greens'
		else
			f.select = 'mac'
		end
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
		icon:setFillColor(_G.util.convertHexToRGB(colors[i]) )
		f.color = colors[i]
		f.num = i
		f.food = 'topping'..i
		
		ulevel = upgrades[ condNames[i] ]
		if( not ulevel )then ulevel = 0 end
		
		local art = buildArtwork( condNames[i] .. '-drag' )
		f:insert(art)
		f.art = art
		art.alpha = 0

		f.x = (i-1) * 20
		f.y = (i-1) * 76
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork( condNames[i] )
		cart:insert(art)

		art.x = f.x+85-10
		art.y = f.y+64
		f.base = art
		grp['base'..i] = art

		_G.engine.hideObjects(f)
		
	end
	grp.x = 85-10
	grp.y = 64
	
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
		img.x = f.x+372-10
		img.y = f.y+22
		img.xScale = f.xScale
		img.yScale = f.yScale
		
		f.select = 'grill'
		
	end
	grp:toFront()
	grp.x = 372-10
	grp.y = 12
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
	--- COOKING ARTWORK
	------------------------------------------------
	
	-- toaster oven
	local art = buildArtwork('toaster-oven')
	art.x = 240-6
	art.y = 20
	cart:insert(art)
	cart.toaster = art
	
	-- toaster tray
	local art = buildArtwork('toaster-tray')
	art.x = 264-10
	art.y = 100
	cart:insert(art)
	cart['toaster-tray'] = art
	
	-- chicken tray
	_G.util.addImage('graphics/level5/items/tray-chicken.png', cart, 'chicken-tray', 280-10, 278, 1, 1, 0, 1)
	
	-- pork tray
	_G.util.addImage('graphics/level5/items/tray-pork.png', cart, 'pork-tray', 410-10, 264, 1, 1, 0, 1)
	
	------------------------------------------------
	--- TAPS
	------------------------------------------------
	
	-- garbage
	local grp = util.addGroup(cart, 'garbage', 0, 0, 1)
	local f = _G.engine.buildHitArea('#333333', 150, 128, 'garbage', nil)
	grp:insert(f)
	f.over:setFillColor(1,0,0)
	grp.x = -390-10
	grp.y = 280
	f.alpha = .01
	_G.engine.hideObjects(f)
		
	-- waffle-iron
	local grp = util.addGroup(cart, 'waffle-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 100)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = -224-10
	grp.y = 284
	f.audio = 'fryer_start'
	f.loop = 'fryer'
	
	local art = buildArtwork('waffle-iron')
	grp:insert(art)
	f.art = art
	f.alpha = .01
	
	-- pita
	local grp = util.addGroup(cart, 'plate-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 108, 64)
	f:setFillColor( _G.util.convertHexToRGB('#2980b9') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = -126-10
	grp.y = 248
	f.audio = 'plate'
	
	local art = buildArtwork('plate-tap')
	grp:insert(art)
	f.art = art
	f.alpha = .01
	
	-- containers
	local grp = util.addGroup(cart, 'container-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 100, 64)
	f:setFillColor( _G.util.convertHexToRGB('#27ae60') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = -11-10
	grp.y = 250
	f.audio = 'container'
	
	local art = buildArtwork('container')
	grp:insert(art)
	f.art = art
	art.xScale = .9
	art.yScale = .9
	f.alpha = .01
	
	-- beef-oven
	local grp = util.addGroup(cart, 'beef-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 90, 50)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', onMeatTouch)
	f.type = 'all'
	grp.x = 268-10
	grp.y = 82
	
	local art = buildArtwork('beef')
	art.y = 0
	grp:insert(art)
	f.art = art
	art.alpha = 1
	f.alpha = .01
	
	-- pot-chicken
	local grp = util.addGroup(cart, 'chicken-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 80, 64)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', onMeatTouch)
	f.type = 'all'
	grp.x = 280-10
	grp.y = 282
	
	local art = buildArtwork('chicken-pot')
	art.x = -30-10
	art.y = -96
	f.pot = art
	grp:insert(art)
	
	local art = buildArtwork('chicken')
	art.y = -18
	grp:insert(art)
	f.art = art
	art.alpha = 1
	f.alpha = .01
	
	-- pot-pork
	local grp = util.addGroup(cart, 'pork-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 80, 64)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', onMeatTouch)
	f.type = 'all'
	grp.x = 410-10
	grp.y = 264
	
	local art = buildArtwork('pork-pot')
	art.x = -40-10
	art.y = -86
	f.pot = art
	grp:insert(art)
	
	local art = buildArtwork('pork')
	art.y = 0
	grp:insert(art)
	f.art = art
	art.alpha = 1
	f.alpha = .01
	
	------------------------------------------------
	--- MEATS
	------------------------------------------------
	
	-- meats: special
	local colors = {'#f1c40f','#e67e22','#00ff00'}
	local condNames= {'beef','chicken','pork'}
	local cX = {0,-8,116}
	local cY = {-10,110,104}
	local grp = util.addGroup(cart, 'meats', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'plate','container','warmers','garbage'}

		local f = _G.engine.buildHitArea('#34495e', 80, 64, 'topping', targets)
		f.id = 'hit'..i
		grp:insert(f)
		grp['hit'..i] = f
		grp[ condNames[i] ] = f
		
		f.isMeat = true
		f.meat = condNames[i]
		f.food = 'meat'
		
		----------- stock -----------
		
		local stock = 0
		ulevel = upgrades[ condNames[i] .. '-pot' ]
		if( not ulevel )then ulevel = 0 end
		
		if(ulevel==0)then stock=1 end
		if(ulevel==1)then stock=1 end
		if(ulevel==2)then stock=2 end
		if(ulevel==3)then stock=3 end
		
		print(condNames[i], ulevel, stock)
		
		f.maxStock = stock
		
		------------------------------
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
		icon:setFillColor(_G.util.convertHexToRGB(colors[i]) )
		f.color = colors[i]
		f.num = i
		
		ulevel = upgrades[ condNames[i] ]
		if( not ulevel )then ulevel = 0 end
		
		local art = buildArtwork( condNames[i] .. '-drag' )
		f:insert(art)
		f.art = art
		art.alpha = 0

		f.x = cX[i]
		f.y = cY[i]
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		-- special
		f.isVisible = false
		f.stock = 0
				
		_G.engine.hideObjects(f)
		
	end
	grp.x = 260-10
	grp.y = 40
		
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
	
	--high = 9
	
	-- shut off
	if( high < 5-1 )then
		
		cart.meats.hit3.y = -1000
		cart['pork-tap'].isVisible = false
		cart['pork-tray'].isVisible = false
				
		cart.condiments.hit2.isVisible = false
		cart.condiments.base2.isVisible = false
		
		cart.condiments.hit1.isVisible = false
		cart.condiments.base1.isVisible = false
		
		cart.meats.hit1.y = -1000
		cart['beef-tap'].isVisible = false
		cart['toaster'].isVisible = false
		cart['toaster-tray'].isVisible = false
		
	elseif( high < 8-1 )then
						
		cart.condiments.hit2.isVisible = false
		cart.condiments.base2.isVisible = false
		
		cart.condiments.hit1.isVisible = false
		cart.condiments.base1.isVisible = false
		
		cart.meats.hit1.y = -1000
		cart['beef-tap'].isVisible = false
		cart['toaster'].isVisible = false
		cart['toaster-tray'].isVisible = false
		
	elseif( high < 10-1 )then
		
		cart.condiments.hit1.isVisible = false
		cart.condiments.base1.isVisible = false
		
		cart.meats.hit1.y = -1000
		cart['beef-tap'].isVisible = false
		cart['toaster'].isVisible = false
		cart['toaster-tray'].isVisible = false
		
	elseif( high < 12-1 )then
		
		cart.meats.hit1.y = -1000
		cart['beef-tap'].isVisible = false
		cart['toaster'].isVisible = false
		cart['toaster-tray'].isVisible = false
		
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
	
		--print(order[i])
		
	end
	local rlimit = #order
	curCustomer = curCustomer+1
	
	-- build request
	for i=1, rlimit do
		
		local rnum = math.floor(math.random()*3)+1
		
		-- add iced tea
		if( order[i] == 'I' )then
			
			food = _G.engine.buildHitArea('#1abc9c', 64, 64, 'none')
			food.food = 'drink'
			food.value = foodValues['iced-tea']
			food.drinktype = 'iced-tea'
			
			art = buildArtwork('iced-tea')
			art.full.alpha = 1
			art.empty.alpha = 0
			food:insert(art)

		end
		
		-- add lemonade
		if( order[i] == 'L' )then
			
			food = _G.engine.buildHitArea('#1abc9c', 64, 64, 'none')
			food.food = 'drink'
			food.value = foodValues['lemonade']
			food.drinktype = 'lemonade'
			
			art = buildArtwork('lemonade')
			art.full.alpha = 1
			art.empty.alpha = 0
			food:insert(art)

		end
		
		-- add meal
		if( (order[i] ~= 'I') and (order[i] ~= 'L') )then
			
			local holder = order[i]:sub( 1,1 )
			local meat = order[i]:sub( 2,2 )
			local side1 = order[i]:sub( 3,3 )
			local side2 = order[i]:sub( 4,4 )
			
			-- choose holder
			if( holder == 'S' )then
				
				food = _G.engine.buildHitArea('#3498db', 64, 64, 'none')
				food.xScale = .8
				food.yScale = .8
				food.value = foodValues['plates']
				
				art = buildArtwork('plate')
				food:insert(art)
				
			end
			
			if( holder == 'T' )then
				
				food = _G.engine.buildHitArea('#2ecc71', 64, 64, 'none')
				food.xScale = .8
				food.yScale = .8
				food.value = foodValues['containers']
				
				art = buildArtwork('container')
				food:insert(art)
				
			end
			
			-- null toppings
			food.meat = nil
			food.topping1 = nil
			food.topping2 = nil
			food.topping3 = nil
			food.cooker = nil
			
			-- choose side(s)
			for i=1, 2 do
			
				local s = nil
				if(i==1)then s=side1 else s=side2 end
				if( s~='' )then
				
					if( s == 'W' )then
						
						art = buildArtwork('waffle')
						art.x = -10
						art.y = -6
						art.xScale = .85
						art.yScale = art.xScale
						food:insert(art)
						
						food.value = food.value + foodValues['waffles']
						food.cooker = true
						
					end
					
					if( s == 'G' )then
						
						art = buildArtwork('condiment01-drag')
						art.x = -17
						art.y = -4
						art.xScale = .75
						art.yScale = art.xScale
						food:insert(art)
						
						food.value = food.value + foodValues['greens']
						food.topping1 = true
						
					end
					
					if( s == 'M' )then
						
						art = buildArtwork('condiment02-drag')
						art.x = 22
						art.y = -4
						art.xScale = .75
						art.yScale = art.xScale
						food:insert(art)
						
						food.value = food.value + foodValues['mac']
						food.topping2 = true
						
					end
					
				end
				
			end
			
			-- choose meat
			if( meat == 'C' )then
				
				art = buildArtwork( 'chicken' )
				art.empty.alpha = 0
				art.full.alpha = 1
				art.x = 22
				art.y = -26
				food:insert(art)
				
				food.value = food.value + foodValues['chicken']
				food.meat = true
				food.mtype = 'chicken'
				
			end
			
			if( meat == 'P' )then
				
				art = buildArtwork( 'pork-drag' )
				art.x = 24
				art.y = -10
				food:insert(art)
				
				food.value = food.value + foodValues['pork']
				food.meat = true
				food.mtype = 'pork'
				
			end
			
			if( meat == 'B' )then
				
				art = buildArtwork( 'beef-drag' )
				art.x = 24
				art.y = -10
				food:insert(art)
				
				food.value = food.value + foodValues['beef']
				food.meat = true
				food.mtype = 'beef'
				
			end
			
			-- set to meal
			food.order = order[i]
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
	
	
	if(food=='lemonade')then
		
		ulevel = upgrades[ 'lemonade' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/cup01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/cup04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/cup04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/cup07.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup08.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='iced-tea')then
		
		ulevel = upgrades[ 'iced-tea' ]
		if( not ulevel )then ulevel = 0 end
		
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/cup01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/cup04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/cup04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/cup07.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/cup09.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	
	if(food=='waffle-iron')then

		ulevel = upgrades[ 'waffle-iron' ]
		if( not ulevel or ulevel == 0 )then ulevel = 1 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/waffle-iron02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/waffle-iron01.png', grp, 'cooking', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/waffle-iron02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/waffle-iron01.png', grp, 'cooking', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/waffle-iron04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/waffle-iron03.png', grp, 'cooking', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/waffle-iron06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/waffle-iron05.png', grp, 'cooking', 0, 0, 1, 1, 0, 0)
		end
	
	end
	
	if(food=='waffle')then

		ulevel = upgrades[ 'waffles' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/waffle01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/waffle02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/waffle02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/waffle03.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	
	if(food=='plate')then

		ulevel = upgrades[ 'plates' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/plate01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/plate02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/plate02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/plate03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		local contents = display.newGroup()
		grp:insert(contents)
		grp.food = contents
		
	end
	
	if(food=='plate-tap')then

		ulevel = upgrades[ 'plates' ]
		if( not ulevel )then ulevel = 0 end
		
		print("plate setting: " .. ulevel )

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/plate-tap01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/plate-tap02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/plate-tap02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/plate-tap03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	
	if(food=='container')then

		ulevel = upgrades[ 'containers' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/container01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/container02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/container02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/container03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		local contents = display.newGroup()
		grp:insert(contents)
		grp.food = contents
		
	end
	
			
	if(food=='condiment01-drag')then

		ulevel = upgrades[ 'greens' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/condiment-drag01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/condiment-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/condiment-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/condiment-drag03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='condiment02-drag')then

		ulevel = upgrades[ 'mac' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/condiment-drag04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/condiment-drag05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/condiment-drag05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/condiment-drag06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
		
	if(food=='condiment01')then

		ulevel = upgrades[ 'greens' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/condiment01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/condiment02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/condiment02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/condiment03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='condiment02')then

		ulevel = upgrades[ 'mac' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/condiment04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/condiment05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/condiment05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/condiment06.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	
	if(food=='chicken')then

		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/chicken01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/chicken02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/chicken03.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/chicken04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/chicken05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/chicken06.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/chicken04.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/chicken05.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/chicken06.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/chicken07.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/chicken08.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/chicken09.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='chicken-pot')then

		ulevel = upgrades[ 'chicken-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pot-chicken01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pot-chicken01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pot-chicken02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pot-chicken03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
	
		-- chicken 
		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/chicken-cook01.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/chicken-cook02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/chicken-cook02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/chicken-cook03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		grp.full.x = 4
		grp.full.y = -34
		
		local chk = grp.full
		
		--lid
		ulevel = upgrades[ 'chicken-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pot-chicken-lid01.png', grp, 'lid', 0, -22, 1, 1, 0, 0)
			chk.y=chk.y+12
			chk.x=chk.x-4
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pot-chicken-lid01.png', grp, 'lid', 0, -22, 1, 1, 0, 0)
			chk.y=chk.y+12
			chk.x=chk.x-4
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pot-chicken-lid02.png', grp, 'lid', 3, -30, 1, 1, 0, 0)
			chk.y=chk.y+6
			chk.x=chk.x-2
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pot-chicken-lid03.png', grp, 'lid', 3, -35, 1, 1, 0, 0)
			chk.y=chk.y-0
			chk.x=chk.x-1
		end

	end
	
		
	if(food=='pork')then

		ulevel = upgrades[ 'pork' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pork01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/pork02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/pork02.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pork03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/pork04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/pork04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pork03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/pork04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/pork04.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pork05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/pork06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/pork06.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='pork-pot')then

		ulevel = upgrades[ 'pork-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pot-pork01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pot-pork01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pot-pork02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pot-pork03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
		ulevel = upgrades[ 'pork' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pork-cook01.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pork-cook02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pork-cook02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pork-cook03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		grp.full.x = 4
		grp.full.y = -20
		
		-- lid
		ulevel = upgrades[ 'pork-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pot-pork-lid01.png', grp, 'lid', 4, -30, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pot-pork-lid01.png', grp, 'lid', 4, -30, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pot-pork-lid02.png', grp, 'lid', 4, -30, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pot-pork-lid03.png', grp, 'lid', 4, -30, 1, 1, 0, 0)
		end

	end
	
	
	if(food=='beef')then

		ulevel = upgrades[ 'beef' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/beef01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/beef02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			--_G.util.addImage('graphics/level5/items/chicken03.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/beef03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/beef04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			--_G.util.addImage('graphics/level5/items/chicken06.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/beef03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/beef04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			--_G.util.addImage('graphics/level5/items/chicken06.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/beef05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/beef06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
			--_G.util.addImage('graphics/level5/items/chicken09.png', grp, 'burnt', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='toaster-oven')then
	
		ulevel = upgrades[ 'beef-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/toaster01.png', grp, 'img', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/toaster02.png', grp, 'lit', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/toaster01.png', grp, 'img', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/toaster02.png', grp, 'lit', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/toaster04.png', grp, 'img', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/toaster05.png', grp, 'lit', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/toaster07.png', grp, 'img', 0, 10, 1, 1, 0, 1)
			_G.util.addImage('graphics/level5/items/toaster08.png', grp, 'lit', 0, 10, 1, 1, 0, 0)
		end
		
		-- beef
		ulevel = upgrades[ 'beef' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/beef01.png', grp, 'empty', 11, 8, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/beef02.png', grp, 'full', 11, 8, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/beef03.png', grp, 'empty', 11, 8, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/beef04.png', grp, 'full', 11, 8, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/beef03.png', grp, 'empty', 11, 8, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/beef04.png', grp, 'full', 11, 8, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/beef05.png', grp, 'empty', 11, 8, 1, 1, 0, 0)
			_G.util.addImage('graphics/level5/items/beef06.png', grp, 'full', 11, 8, 1, 1, 0, 0)
		end
		
		--grp.empty.alpha = 1
		
		-- lid
		ulevel = upgrades[ 'beef-pot' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/toaster03.png', grp, 'lid', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/toaster03.png', grp, 'lid', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/toaster06.png', grp, 'lid', 0, 10, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/toaster09.png', grp, 'lid', 0, 10, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='toaster-tray')then
	
		ulevel = upgrades[ 'beef-pot' ]
		if( not ulevel or ulevel == 0 )then ulevel = 1 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/toaster-tray01.png', grp, 'img', 4, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/toaster-tray01.png', grp, 'img', 4, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/toaster-tray02.png', grp, 'img', 4, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/toaster-tray03.png', grp, 'img', 4, 0, 1, 1, 0, 1)
		end
			
	end
	
	if(food=='beef-drag')then

		ulevel = upgrades[ 'beef' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/beef-drag01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/beef-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/beef-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/beef-drag03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='chicken-drag')then

		ulevel = upgrades[ 'chicken' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/chicken02.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/chicken05.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/chicken05.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/chicken08.png', grp, 'empty', 0, -10, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='pork-drag')then

		ulevel = upgrades[ 'beef' ]
		if( not ulevel )then ulevel = 0 end

		if( ulevel == 0 )then
			_G.util.addImage('graphics/level5/items/pork-drag01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level5/items/pork-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level5/items/pork-drag02.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level5/items/pork-drag03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
		end
		
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

	local obj = main.foreground.cart['waffle-tap']
	obj.hit.art.empty.alpha = 1
	obj.hit.art.cooking.alpha = 0
	
	local grp = main.foreground.cart['waffle']
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
	
	return value
	
end

local function checkTutorialData()
	local checkTutFlagVal = false
	if not _G.TutorialData.displaying and _G.curLevelNum == 5 then
		for k, v in pairs(_G.TutorialData.data) do
			if v.display and _G.curStageNum == v.level and _G.curLevelNum == v.stage then
				print( "K::::",k )
				checkTutFlagVal = true
			end
		end
	end
	return checkTutFlagVal
end

--------------------------- EVENTS:

function onMeatTouch(e)

	if( e.phase ~= 'began' )then return end
	if checkTutorialData() then return end
	if _G.TutorialData.checkTargetTouch(34) then return end
	
	local grp = e.target.parent
	local targ = string.gsub( grp.id, "-tap", "" )
	
	local cookDelay = 6000
	local myclosure = nil
	local drag = nil
	print( "---------Chicking---------" )
	print( "_G.TutorialData.displaying :: ",_G.TutorialData.displaying )
	print_r( tutObj )
	print( "------------------" )
	if _G.TutorialData.displaying and tutObj ~= nil then

		print( "Pass Mode :: ",tutObj.targ )

		if _G.TutorialData.displaying and tutObj.targ ~= targ then return end
	end


	-- chicken pot
	if(targ == 'chicken')then

		print('cook chicken')
		
		drag = main.foreground.cart.meats.chicken
		
		if( drag.stock > 0 )then return end
		if(e.target.pot.lid.alpha==1)then return end
		
		drag.isVisible = false
		e.target.pot.lid.alpha = 1
		cookDelay = (cookTimes['chicken']/60)*1000
		isTutDisplay = false
		_G.gui.hideTutorial()
		if _G.curStageNum == 1 then

			option = {
	    		id = 3,
	    		nextCall = 4,
	    		lastCall = 5,

	    	}
	    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
	    end
		myclosure = function()
		print( isTutDisplay, isTutDisplayed, isTutDisplay and not isTutDisplayed )
			if isTutDisplay and not isTutDisplayed then
				if _G.curStageNum == 1 then
					isTutDisplayed = true
					print( "displaying Tutorial 7" )
					_G.gui.hideTutorial()
					option = {
			    		id = 7,
			    		nextCall=19,
			    		lastCall=19
			    	}
			    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
			    end
			end
			print( "Tutorial Old ::: ", isTutDisplay)
			isTutDisplay = true
			return onPotCooked(e.target) 
		end
		transition.to( e.target.pot.lid, {delay=cookDelay, time=0, alpha=0, onComplete=myclosure })
		
		_G.mixer.playSFX('chicken_start')
		_G.mixer.playLoop('chicken')
		
	end
	
	-- pork pot
	if(targ == 'pork')then
		
		drag = main.foreground.cart.meats.pork
		
		if( drag.stock > 0 )then return end
		if(e.target.pot.lid.alpha==1)then return end
		
		drag.isVisible = false
		e.target.pot.lid.alpha = 1
		cookDelay = (cookTimes['pork']/60)*1000
		
		_G.gui.hideTutorial()
		
		if _G.curStageNum == 4 then
			option = {
	    		id = 21,
	    	}
	    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
	    end

		myclosure = function()
			_G.gui.hideTutorial()
			--setTutorial(10)
			if _G.curStageNum == 4 then
				option = {
					id = 10,
		    		nextCall = 27,
		    		lastCall = 27
		    	}
		    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
		    end
			return onPotCooked(e.target)
		end
		transition.to( e.target.pot.lid, {delay=cookDelay, time=0, alpha=0, onComplete=myclosure })
		
		_G.mixer.playSFX('cooker_start')
		_G.mixer.playLoop('cooker')
				
	end
	
	-- beef over
	if(targ == 'beef')then
	
		drag = main.foreground.cart.meats.beef
		
		if( drag.stock > 0 )then return end
		if( main.foreground.cart.toaster.lid.alpha==1 )then return end
		
		drag.isVisible = false
		main.foreground.cart.toaster.lid.alpha = 1
		main.foreground.cart.toaster.empty.alpha = 1
		
		_G.gui.hideTutorial()

		-- if _G.curStageNum == 11 then
		-- 	option = {
	 --    		id = 24,
	 --    	}
	 --    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
	 --    end

		cookDelay = (cookTimes['beef']/60)*1000
		myclosure = function()
			--setTutorial(14)

			if isTutDisplay and not isTutDisplayed then
				if _G.curStageNum == 11 then
					isTutDisplayed = true
					print( "displaying Tutorial 7" )
					_G.gui.hideTutorial()
					option = {
			    		id = 14,
			    	}
			    	_G.engine.checkDataFunction(nil,nil,nil,nil,option)
			    end
			end
			print( "Tutorial Old ::: ", isTutDisplay)
			isTutDisplay = true
			return onPotCooked(e.target)
		end
		transition.to( e.target, {delay=cookDelay, time=0, alpha=.01, onComplete=myclosure })
		
		_G.mixer.playSFX('burger_start')
		_G.mixer.playLoop('burger')
		
	end

end

function onPotCooked(grp)

	local targ = string.gsub( grp.parent.id, "-tap", "" )
	local drag = nil
	
	-- chicken
	if( targ == 'chicken' )then
	
		grp.pot.full.alpha = 1
		drag = main.foreground.cart.meats.chicken
		
		_G.mixer.playSFX('chicken_stop')
		_G.mixer.stopSFX('chicken')
		_G.mixer.playSFX('ready')
		
	end
	
	-- pork
	if( targ == 'pork' )then
	
		grp.pot.full.alpha = 1
		drag = main.foreground.cart.meats.pork
		
		_G.mixer.playSFX('cooker_stop')
		_G.mixer.stopSFX('cooker')
		_G.mixer.playSFX('ready')
		
	end
	
	-- pork
	if( targ == 'beef' )then
	
		drag = main.foreground.cart.meats.beef
		main.foreground.cart.toaster.lid.alpha = 0
		main.foreground.cart.toaster.empty.alpha = 0
		main.foreground.cart.toaster.full.alpha = 1
		
		_G.mixer.playSFX('burger_stop')
		_G.mixer.stopSFX('burger')
		_G.mixer.playSFX('ready')
		
	end
	
	-- set dragger
	drag.isVisible = true
	drag.stock = drag.maxStock
	
end

function addToSandwich(obj, targ)
	
	local art = nil
	
	local sContainter = ''
	local order = ''
	
	-- determine container
	
	if(targ.type == 'plate')then
	
		sHolder = 'S'
		
	end
	
	if(targ.type == 'container')then
	
		sHolder = 'T'
		
	end
	
	-- add object
					
	if( obj.mode == 'topping' )then
		
		print('add topping to plate')
		
		if(obj.isMeat)then
		
			print('add meat')
			
			-- destock
			obj.stock = obj.stock - 1
			if(obj.stock==0)then
				
				obj.isVisible = false
				
			end
			
			-- if chicken
			if( obj.meat == 'chicken' )then
				
				art = buildArtwork( 'chicken' )
				art.empty.alpha = 0
				art.full.alpha = 1
				
				art.x = 22
				art.y = -26
				
				if(obj.stock==0)then
				
					main.foreground.cart['chicken-tap'].hit.pot.full.alpha = 0
				
				end
				
				targ.sMeat = 'C'
				
			end
			
			-- if pork
			if( obj.meat == 'pork' )then
				
				art = buildArtwork( 'pork-drag' )
				
				art.x = 24
				art.y = -10
				
				if(obj.stock==0)then
				
					main.foreground.cart['pork-tap'].hit.pot.full.alpha = 0
				
				end
				
				targ.sMeat = 'P'
				
			end
			
			-- if beef
			if( obj.meat == 'beef' )then
				
				art = buildArtwork( 'beef-drag' )
				
				art.x = 24
				art.y = -10
				
				if(obj.stock==0)then
				
					main.foreground.cart.toaster.full.alpha = 0
				
				end
				
				targ.sMeat = 'B'
				
			end
			
			art.xScale = .85
			art.yScale = art.xScale
					
			targ.art.food:insert(art)
			targ.meat = true
			art:toFront()
		
			targ.art.food.alpha = 1
				
		elseif( obj.mode == 'topping' )then
		
			art = buildArtwork( 'condiment0' .. obj.num .. '-drag' )
			
			if(obj.num==1)then
				art.x = -17
				targ.sGreens = 'G'
				_G.mixer.playSFX('greens')
			else
				art.x = 22
				targ.sMac = 'M'
				_G.mixer.playSFX('mac')
			end
			
			art.y = -4
			art.xScale = .75
			art.yScale = art.xScale
		
			targ.art.food.alpha = 1
			targ.art.food:insert(art)
			art:toBack()
			
			targ['topping'..obj.num] = true
			targ.cooker = true
				
		end
					
	end
	
	if( obj.mode == 'cooker' )then
		
		art = buildArtwork('waffle')
		art.x = -10
		art.y = -6
		art.xScale = .85
		art.yScale = art.xScale
		
		targ.art.food:insert(art)
		
		targ.art.food.alpha = 1
		art:toBack()
		
		targ.cooker = true
		targ.topping1 = true
		targ.topping2 = true
		
		targ.sWaffle = 'W'
					
	end
	
	if( obj.mode == 'warmer' )then
	
		print('add warm meat')
		
		-- if chicken
		if( obj.meat == 'chicken' )then
			
			art = buildArtwork( 'chicken' )
			art.empty.alpha = 0
			art.full.alpha = 1
			art.x = 22
			art.y = -26
			
			targ.sMeat = 'C'
			
		end
		
		-- if pork
		if( obj.meat == 'pork' )then
			
			art = buildArtwork( 'pork-drag' )
			art.x = 24
			art.y = -10
			
			targ.sMeat = 'P'
			
		end
		
		-- if beef
		if( obj.meat == 'beef' )then
			
			art = buildArtwork( 'beef-drag' )
			art.x = 24
			art.y = -10
			
			targ.sMeat = 'B'
			
		end
		
		art.xScale = .85
		art.yScale = art.xScale
				
		targ.art.food:insert(art)
		targ.meat = true
		art:toFront()
	
		targ.art.food.alpha = 1
		
	end
	
	-- update order
	order = sHolder .. targ.sMeat .. targ.sWaffle .. targ.sGreens .. targ.sMac
	targ.order = order
	
	print('order: ' .. order)
	
end

function addToWarmer(obj, targ)
	
	print('add meat to warmer')
	
	-- update targets
	targ.targets = {}
	targ.targets = obj.targets
	targ.meat = obj.meat
	targ.food = 'meat'
	
	-- destock
	obj.stock = obj.stock - 1
	if(obj.stock==0)then
		
		obj.isVisible = false
		
	end
	
	-- if chicken
	if( obj.meat == 'chicken' )then
		
		art = buildArtwork( 'chicken' )
		art.empty.alpha = 0
		art.full.alpha = 1
		
		art.y = -12

		if(obj.stock==0)then
		
			main.foreground.cart['chicken-tap'].hit.pot.full.alpha = 0
		
		end
		
	end
	
	-- if pork
	if( obj.meat == 'pork' )then
		
		art = buildArtwork( 'pork-drag' )
		
		if(obj.stock==0)then
		
			main.foreground.cart['pork-tap'].hit.pot.full.alpha = 0
		
		end
		
	end
	
	-- if beef
	if( obj.meat == 'beef' )then
		
		art = buildArtwork( 'beef-drag' )
		
		if(obj.stock==0)then
		
			main.foreground.cart.toaster.full.alpha = 0
		
		end
		
	end
	
	art.xScale = .9
	art.yScale = art.xScale
			
	targ.contents:insert(art)
	targ.full = true

	-- audio
	_G.mixer.playSFX('warmer')
	
end

--------------------------- UI:
function setTutorial(num, callback, xPass, yPass,parentPass)
    local info
    tutObj= nil
     print( num )
	if num == 1 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragLemonadeDrink5",{ fY = 40, x= -410, y = 90, group=grp_main, callback = callback })
    	
    end

	-- if (num==2) then
 --    	--_G.loadsave.print_r( callback )
 --        info = _G.gui.setTutorial("dragIcedTea5",{ fY = 40, x= -370, y = 90, group=grp_main, callback = callback })
 --    end

    if num == 3 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPlatesPreperingDishes5",{ fY = 40, x= -20, y = 200, group=grp_main, callback = callback })
    	
    end

	if (num==4) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragtravesPreperingDishes5",{ fY = 40, x= -120, y = 200, group=grp_main, callback = callback })
    end

    if (num==5) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPlatesPreperingDishes52",{ fY = 40, x= -120, y = 200, group=grp_main, callback = callback })
    end
    if (num==29) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPlatesPreperingDishes511",{ fY = 40, x= -120, y = 200, group=grp_main, callback = callback })
    end

    if num == 17 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectChicken5",{ fY = 40, x= 250, y = 250, group=grp_main, callback = callback })
    	
    end

	if (num==18) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitChikenFriesReady",{ fY = 40, x= -230, y = 2230, group=grp_main, callback = callback })
    end
    if (num==21) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitPorkFriesReady",{ fY = 40, x= -230, y = 2230, group=grp_main, callback = callback })
    end
    if (num==24) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("waitBiscutFriesReady",{ fY = 40, x= -230, y = 2230, group=grp_main, callback = callback })
    end
    if num == 22 then
        info = _G.gui.setTutorial("wellcomeMessage57",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    
	if (num==6) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectWafflesIron5",{ fY = 40, x= -230, y = 230, group=grp_main, callback = callback })
    end

    if num == 7 then
    	_G.TutorialData.defaultData.waitChikenFriesReady.display = false
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragChickenPlate5",{ fY = 40, x= -120, y = 110, group=grp_main, callback = callback })
    	
    end

	-- if (num==8) then
 --    	--_G.loadsave.print_r( callback )
 --        info = _G.gui.setTutorial("dragWafflesCustomer5",{ fY = 40, x= -230, y = 120, group=grp_main, callback = callback })
 --    end

    if num == 9 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectPork5",{ fY = 40, x= 390, y = 230, group=grp_main, callback = callback })
    	
    end
    print("NUmber :::::::: ",num)
	if (num==10) then

    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPorkCustomer5",{ fY = 40, x= 340, y = 115, group=grp_main, callback = callback })
    end
    if (num==27) then

    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPorkCustomer52",{ fY = 40, x= 455, y = 145, group=grp_main, callback = callback })
    end

    if num == 11 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragGreen5",{ fY = 40, x= -170, y = 160, group=grp_main, callback = callback })
    	
    end

	if (num==12) then
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragmacAndCheese5",{ fY = 40, x= -150, y = 240, group=grp_main, callback = callback })
    end

    if num == 13 then
		--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectBrisket5",{ fY = 40, x= 250, y = 40, group=grp_main, callback = callback })
    	
    end

	if (num==14) then
		_G.TutorialData.defaultData.waitBiscutFriesReady.display = false
    	--_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragBrisket5",{ fY = 40, x= 240, y = 0, group=grp_main, callback = callback })
    end
    
	if num == 15 then
        info = _G.gui.setTutorial("wellcomeCopelandMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 26 then
        info = _G.gui.setTutorial("wellcomeCopelandMessage2",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    
    if num == 19 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["dragChickenPlateCustomer5"].type = "right"
            xSet = cList[1].x - 330
        else
            _G.TutorialData.data["dragChickenPlateCustomer5"].type = "left"
            xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("dragChickenPlateCustomer5",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end
    if num == 16 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["firstCopelendCustomerMessage"].type = "right"
            xSet = cList[1].x - 330
        else
            _G.TutorialData.data["firstCopelendCustomerMessage"].type = "left"
            xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("firstCopelendCustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end
    if(num==20)then               
        local cList = {_G.engine.runningCust}
        print("get Clist x pos ::: ",cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["collectMoney51"].type = "right"
            xSet = cList[1].x - 280
        else
            _G.TutorialData.data["collectMoney51"].type = "left"
            xSet = cList[1].x + 250
        end
        print("xList ::: ",cList[1].x)
        info = _G.gui.setTutorial("collectMoney51",{ fY = 40, x= xSet, y = 70, group=grp_main, callback = callback })
        print( "Info :::: " )
        _G.loadsave.print_r(info)
    end
	if info ~= nil then
		print( "infoname ::: ",info.tutName )
    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
    	tutObj = info.passData
    	print_r(info.passData)
    end
    
    return info
        
end
--------------------------- MODULE EVENTS:

