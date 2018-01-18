
module(..., package.seeall)

-------------------------- CONSTANTS

local STENCIL_CHANCE = 5
local CUSTOMER_OFFSET = 1400
local ROOM_WAIT_TIME = 6000

local colorSet = {'#863d44','#97894f','#497b60','#5e93a4','#6f526f','#b7946f'}

local csetA = {'#873e44','#9b8d51','#4a7c61','#5e94a5','#705270','#ffffff'}
local csetB = {'#932230','#a58a17','#23844c','#288ea5','#702a72','#808285'}
local csetC = {'#ce0d2d','#ffce00','#04af49','#00dbff','#92049e','#231f20'}
local cSets = {csetA,csetB,csetC}

-------------------------- VARIABLES

local dRooms = {}
local itemValues = {}
local cookTimes = {}

itemValues['drink'] = 10
itemValues['shoes01'] = 10
itemValues['shoes02'] = 10
itemValues['shirt'] = 10
itemValues['pants'] = 10
itemValues['sweater'] = 10
itemValues['hat'] = 10
itemValues['case'] = 10
itemValues['paint'] = 10
itemValues['application'] = 10
itemValues['gift'] = 10

local main
local levelData

--------------------------- GET/SET

function setLevelData(data)
	
	print('set level data')
	curCustomer = 1
	levelData = data
	
	-- get user upgrades
	local upgrades = _G.userdata.leveldata[_G.curLevelNum].upgrades
	local ulevel = 0
	local revenue = 0
	local cooktime = 0
	
	-- set shoes01
	ulevel = upgrades['shoes01']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['shoes01'].revenue[ ulevel+1 ]
	itemValues['shoes01'] = revenue
	
	ulevel = upgrades['shoes01 supplies']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['shoes01 supplies'].prepTime[ ulevel+1 ]
	cookTimes['shoes01'] = cooktime * 60
	
	-- set shoes02
	ulevel = upgrades['shoes02']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['shoes02'].revenue[ ulevel+1 ]
	itemValues['shoes02'] = revenue
	
	ulevel = upgrades['shoes02 supplies']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['shoes02 supplies'].prepTime[ ulevel+1 ]
	cookTimes['shoes02'] = cooktime * 60
	
	-- set tops
	print('get tops upgrades')
	ulevel = upgrades['tops']
	if(not ulevel)then 
		
		print('resetting tops level')
		ulevel=0 
	
	end
	revenue = _G.levelInfo.upgrades['tops'].revenue[ ulevel+1 ]
	itemValues['shirt'] = revenue

	-- set pants
	ulevel = upgrades['pants']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['pants'].revenue[ ulevel+1 ]
	itemValues['pants'] = revenue
	
	-- set tees
	ulevel = upgrades['tees']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['tees'].revenue[ ulevel+1 ]
	itemValues['sweater'] = revenue
	
	-- set hats
	ulevel = upgrades['hats']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['hats'].revenue[ ulevel+1 ]
	itemValues['hat'] = revenue
	
	-- set paints
	ulevel = upgrades['paints']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['paints'].revenue[ ulevel+1 ]
	itemValues['paint'] = revenue
	
	-- set cases
	ulevel = upgrades['cases']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['cases'].revenue[ ulevel+1 ]
	itemValues['case'] = revenue
	
	ulevel = upgrades['case supplies']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['case supplies'].prepTime[ ulevel+1 ]
	cookTimes['case'] = cooktime * 60
	
	-- set coffee
	ulevel = upgrades['coffee']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['coffee'].revenue[ ulevel+1 ]
	itemValues['drink'] = revenue
	
	ulevel = upgrades['coffee machine']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['coffee machine'].prepTime[ ulevel+1 ]
	cookTimes['drink'] = cooktime * 60
	
	-- set appliction
	ulevel = upgrades['application']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['application'].revenue[ ulevel+1 ]
	itemValues['application'] = revenue
	
	-- set gift
	ulevel = upgrades['gift']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['gift'].revenue[ ulevel+1 ]
	itemValues['gift'] = revenue
	
	----------------------------
	--------- INTERIORS --------
	----------------------------
	
	-- tip time, wait time, tip amount, extras
	local vars = {0,0,0,0}
	
	ulevel = upgrades['plants']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['plants'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['chairs']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['chairs'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['chairs'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['minibar']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['minibar'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['speakers']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['speakers'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['speakers'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['manequins']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['manequins'].tipAmount[ ulevel+1 ]
	vars[3] = vars[3] + val
	
	ulevel = upgrades['store']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['store'].extraCustomer[ ulevel+1 ]
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
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	
	ulevel = upgrades[ 'store' ]
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then  ulevel = 1 end
	
	for i=1, 2 do
		
		local c = util.addImage('graphics/level4/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -384
	
	-- dressing room(s)
	local inroom = util.addGroup(grp_main, 'inroom', 0, 0, 1)
	local dressers = util.addGroup(grp_main, 'dressers', 0, 0, 1)
	for i=1, 4 do
	
		local grp = util.addGroup(bg, 'room'..i, 0, 0, 1)
		_G.util.addFill(grp, 'fill', 1, 0, 0, .5, 0, 0, 130, 160)
		grp.fill.anchorX = 0
		grp.fill.anchorY = 0
		grp.x = ((i-1)*173) - 312 - 12
		grp.y = -240-2
		grp.fill.alpha = .01
		grp.status = 'empty'
		
		-- build curtain
		local options =
		{
		    width = 128,
		    height = 128,
		    numFrames = 7
		}
		local sheet = graphics.newImageSheet( "graphics/level4/curtain.png", options )

		-- consecutive frames
		local sequenceData =
		{
			{ name="close",  start=1, count=4, time=0200, loopCount = 1 },
			{ name="open", start=4, count=4, time=0200, loopCount = 1 }
		}

		local curtain = display.newSprite( sheet, sequenceData )
		curtain.x = grp.x + 66
		curtain.y = grp.y + 73
		--curtain:play()
		curtain.alpha = 1
		dressers:insert(curtain)
		dressers['curtain'..i] = curtain
		
	end
	
	--bg.room1.isVisible = false
	--bg.room2.isVisible = false
	--bg.room3.isVisible = false
	--bg.room4.isVisible = false
	
	-- midground 
	local mg = util.addGroup(grp_main, 'midground', 0, 0, 1)
	local grp = util.addGroup(mg, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level4/mg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.alpha = 1
	grp.x = grp.width * -.5
	grp.y = -145
	
	-- customers layer
	local customers = util.addGroup(grp_main, 'customers', 0, 0, 1)
	local requests = util.addGroup(grp_main, 'requests', 0, 0, 1)
	
	-- foreground
	local fg = util.addGroup(grp_main, 'foreground', 0, 0, 1)
	
	-- cart
	local cart = util.addGroup(fg, 'cart', 0, 0, 1)
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level4/fg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -45
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
	
	ulevel = upgrades[ 'store' ]
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then  ulevel = 1 end
	
	for i=1, 2 do
		
		local c = util.addImage('graphics/level4/bg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
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
		
		local c = util.addImage('graphics/level4/mg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.alpha = 1
	grp.x = grp.width * -.5
	grp.y = -145
	
	-- rebuild fg
	cart.art:removeSelf()
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	for i=1, 2 do
		
		local c = util.addImage('graphics/level4/fg0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
		c.anchorX = 0
		c.anchorY = 0
		c.x = 683 * (i-1)
		
	end
	grp.x = grp.width * -.5
	grp.y = -45
	
	-- rooms
	ulevel = upgrades[ 'rooms' ]
	if( not ulevel or ulevel == 0 )then ulevel = 1 end
	local max = _G.levelInfo.upgrades[ 'rooms' ].unlocked[ ulevel+1 ]
		
	if(max==2)then
	
		bg.room1.isVisible = false
		bg.room4.isVisible = false
		
		main.dressers.curtain1:setSequence('open')
		main.dressers.curtain4:setSequence('open')
	
	end
	
	if(max==3)then
	
		bg.room4.isVisible = false
		main.dressers.curtain4:setSequence('open')
	
	end
	
	
	------------------------------------------------
	--- INTERIORS
	------------------------------------------------
	
	ulevel = upgrades[ 'speakers' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level4/speaker0'..ulevel..'.png', bg, 'tv', -364, -260, 1, 1, 0, 1)
		_G.util.addImage('graphics/level4/speaker0'..ulevel..'.png', bg, 'tv', 366, -260, -1, 1, 0, 1)
	end
	
	ulevel = upgrades[ 'manequins' ]
	if( not ulevel )then ulevel = 0 end
	if( ulevel>0 )then
		_G.util.addImage('graphics/level4/right0'..ulevel..'.png', bg, 'tv', -420, -182, 1, 1, 0, 1)
		_G.util.addImage('graphics/level4/left0'..ulevel..'.png', bg, 'tv', 456, -182, 1, 1, 0, 1)
	end
	
	------------------------------------------------
	--- CART ARTWORK
	------------------------------------------------
	
	-- coffee machine
	util.addImage('graphics/level2/items/coffee-machine.png', cart.art, 'machine', 286-10, 120, 1, 1, 0, 1)

	------------------------------------------------
	--- DRAGS
	------------------------------------------------
	
	_G.util.addGroup(cart, 'locks', 0, 0, 1)
	local col, row
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	-- soda/coffee
	itemList = {}
	local grp = util.addGroup(cart, 'soda', 0, 0, 1)
	for i=1, 3 do
		
		local targets = {'customers'}
		
		local f = _G.engine.buildHitArea('#1abc9c', 50, 64, 'auto-fill', targets)
		f.id = 'hit'..i
		f.food = 'drink'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * 43
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		if(i==2)then
			
			f.y = 15
			f.x = f.x - 4
		
		end
		
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
		f.select = 'coffee'
		
	end
	grp.x = -448-10
	grp.y = 90
	grp.itemList = itemList
	
	ulevel = upgrades[ 'coffee machine' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'coffee machine' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit3.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- shoes 01
	scaleList = {.86,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'shoes01', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#af7ac4', 74, 62, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'shoes'
		f.name = 'shoes'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -26
		f.y = (i-1) * 62
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('shoes01')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		--f.alpha = .5
		f.cooktime = cookTimes['shoes01']
		_G.engine.hideObjects(f)
		
		f.select = 'sneakers'
		
	end
	grp.x = -258-10
	grp.y = 70
	grp.itemList = itemList
	
	ulevel = upgrades[ 'shoes01 supplies' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'shoes01 supplies' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- shoes 02
	scaleList = {.86,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'shoes02', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#e74c3c', 62, 62, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'shoes'
		f.name = 'shoes'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -20
		f.y = (i-1) * 60
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('shoes02')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		--f.alpha = .5
		f.cooktime = cookTimes['shoes02']
		_G.engine.hideObjects(f)
		
		f.select = 'sneakers'
		
	end
	grp.x = -198-10
	grp.y = 78
	grp.itemList = itemList
	
	ulevel = upgrades[ 'shoes02 supplies' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'shoes02 supplies' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- shirts
	scaleList = {.80,.90,1}
	itemList = {}
	local grp = util.addGroup(cart, 'shirts', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#3498db', 86, 64, 'clothes', targets)
		f.id = 'hit'..i
		f.food = 'clothes'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -15
		f.y = (i-1) * 73
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('shirt')
		art.x = 4
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['shirt']
		_G.engine.hideObjects(f)
		
		f.select = 'tshirt'
		
	end
	grp.x = -120-10
	grp.y = 54
	grp.itemList = itemList
	
	ulevel = upgrades[ 'tops tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'tops tabletop' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- jeans
	scaleList = {.80,.90,1}
	itemList = {}
	local grp = util.addGroup(cart, 'pants', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#2ecc71', 90, 64, 'clothes', targets)
		f.id = 'hit'..i
		f.food = 'clothes'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -2
		f.y = (i-1) * 72
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('pants')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['jeans']
		_G.engine.hideObjects(f)
		
		f.select = 'jeans'
		
	end
	grp.x = -32-10
	grp.y = 54
	grp.itemList = itemList
	
	ulevel = upgrades[ 'pants tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'pants tabletop' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- tees
	scaleList = {.80,.90,1}
	itemList = {}
	local grp = util.addGroup(cart, 'tee', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#f1c40f', 90, 70, 'clothes', targets)
		f.id = 'hit'..i
		f.food = 'clothes'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 7
		f.y = (i-1) * 72
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('tee')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['hat']
		_G.engine.hideObjects(f)
		
		f.select = 'sweater'
		
	end
	grp.x = 58-10
	grp.y = 54
	grp.itemList = itemList
	
	ulevel = upgrades[ 'tees tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'tees tabletop' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- hats
	scaleList = {.82,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'hat', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#ff0000', 70, 70, 'clothes', targets)
		f.id = 'hit'..i
		f.food = 'clothes'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 19
		f.y = (i-1) * 68
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('hat')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['hat']
		_G.engine.hideObjects(f)
		
		f.select = 'hat'
		
	end
	grp.x = 130-10
	grp.y = 60
	grp.itemList = itemList
	
	ulevel = upgrades[ 'hats tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'hats tabletop' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- color artwork
	ulevel = upgrades[ 'paints' ]
	if( not ulevel )then ulevel = 0 end
								
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level4/items/paints01.png', cart, 'img', 285-10, 111, 1, 1, 0, 1)
		colorSet = cSets[1]
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level4/items/paints02.png', cart, 'img', 285-10, 111, 1, 1, 0, 1)
		colorSet = cSets[2]
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level4/items/paints02.png', cart, 'img', 285-10, 111, 1, 1, 0, 1)
		colorSet = cSets[2]
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level4/items/paints03.png', cart, 'img', 285-10, 111, 1, 1, 0, 1)
		colorSet = cSets[3]
	end
	
	-- colors: special
	col = 0
	row = 0
	local colors = colorSet
	local letters = {'a','b','c','d','e','f'}
	local xoff = {0,-30,26,-2,50,20}
	local grp = util.addGroup(cart, 'colors', 0, 0, 1)
	for i=1, 6 do
		
		local targets = {'shirts','pants','tee','hat'}
	
		local f = _G.engine.buildHitArea('#34495e', 64, 54, 'color', targets)
		f.id = 'hit'..i
		grp:insert(f)
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 60, 44)
		icon:setFillColor(_G.util.convertHexToRGB(colors[i]) )
		f.color = colors[i]
		f.num = i

		f.x = col * 108
		f.x = f.x + xoff[i]
		f.y = row * 50
		f:addEventListener('touch', _G.engine.onColorTouch)
		f.alpha = .01
		_G.engine.hideObjects(f)
		
		col = col + 1
		if( col == 2 )then
			col = 0
			row = row + 1
		end
		
	end
	grp.x = 216-10
	grp.y = 56
	
	-- appications, gifts: special
	local colors = {'#ffff00','#ff00ff'}
	local condNames= {'application','gift'}
	local soundNames = {'application','gift_box'}
	local cX = {196,280}
	local cY = {192,179}
	local grp = util.addGroup(cart, 'condiments', 0, 0, 1)
	for i=1, 2 do
	
		local targets = {'customers'}

		local f = _G.engine.buildHitArea(colors[i], 80, 64, 'topping', targets)
		f.id = 'hit'..i
		f.food = 'topping'
		grp:insert(f)
		grp['hit'..i] = f
		
		local img = buildArtwork( condNames[i] )
		f:insert(img)
		f.art = img
		img.alpha = 0

		f.x = cX[i]
		f.y = cY[i]
		f:addEventListener('touch', _G.engine.onHitTouch)

		local img = buildArtwork( condNames[i] )
		cart:insert(img)
		grp['art'..i] = img
		
		f.select = soundNames[i]

		img.x = f.x+74
		img.y = f.y+52
		f.base = img

		_G.engine.hideObjects(f)
		
	end
	grp.x = 75-10
	grp.y = 52
	
	-- cases
	scaleList = {.80,.90,1}
	itemList = {}
	local grp = util.addGroup(cart, 'cases', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#e67e22', 64, 64, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'side'
		f.name = 'case'
		grp:insert(f)
		grp['hit'..i] = f
		
		local art = buildArtwork('case')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['case']
		_G.engine.hideObjects(f)
			
		itemList[i] = f
		f.x = (i-1) * 40
		f.y = (i-1) * 62
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		if(i==1)then f.y=f.y+2; f.x=f.x+2 end
		if(i==2)then f.y=f.y-3 end
		
		f.select = 'case'
		
		-- add phone image
		local art = buildArtwork('phone')
		art.x = f.x+grp.x+410
		art.y = f.y+grp.y+0
		art.xScale = f.xScale
		art.yScale = f.yScale
		cart:insert(art)
		grp['phone'..i] = art
		
	end
	grp.x = 354-10
	grp.y = 26
	grp.itemList = itemList
	
	ulevel = upgrades[ 'case supplies' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'case supplies' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		grp.phone1.isVisible = false
		grp.phone2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		grp.phone1.isVisible = false
		
	end	
	
	------------------------------------------------
	--- TAPS
	------------------------------------------------
	
	-- garbage
	local grp = util.addGroup(cart, 'garbage', 0, 0, 1)
	local f = _G.engine.buildHitArea('#333333', 128, 100, 'garbage', nil)
	grp:insert(f)
	f.over:setFillColor(1,0,0)
	grp.x = -426-10
	grp.y = 230
	f.alpha = .01
	
	-- shoes01
	local grp = util.addGroup(cart, 'shoes01-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 74, 68)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = -312-10
	grp.y = 277
	
	_G.util.addImage('graphics/level4/items/shoes01-tap.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	f.alpha = .01
	f.audio = 'sneakers'
		
	-- shoes02
	local grp = util.addGroup(cart, 'shoes02-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 74, 68)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = -229-10
	grp.y = 283
	
	_G.util.addImage('graphics/level4/items/shoes02-tap.png', grp, 'img', 0, 0, 1, 1, 0, 1)
	f.alpha = .01
	f.audio = 'sneakers'
	
	-- shirts
	local grp = util.addGroup(cart, 'shirts-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 80, 64)
	f:setFillColor( _G.util.convertHexToRGB('#2980b9') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#3498db'
	grp.x = -136-10
	grp.y = 278
	f.alpha = .01
	f.audio = 'tshirt'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('shirt-tap')
	art.alpha = 1
	art.y = 0
	grp:insert(art)
	grp.art = art
	
	-- jeans
	local grp = util.addGroup(cart, 'pants-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 90, 64)
	f:setFillColor( _G.util.convertHexToRGB('#27ae60') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#2ecc71'
	grp.x = -32-10
	grp.y = 279
	f.alpha = .01
	f.audio = 'jeans'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('pants-tap')
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
	-- tee
	local grp = util.addGroup(cart, 'tee-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 64)
	f:setFillColor( _G.util.convertHexToRGB('#f39c12') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#f1c40f'
	grp.x = 72-10
	grp.y = 278
	f.alpha = .01
	f.audio = 'sweater'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('tee-tap')
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
	-- hats
	local grp = util.addGroup(cart, 'hat-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 64)
	f:setFillColor( _G.util.convertHexToRGB('#f39c12') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#ff0000'
	grp.x = 164-10
	grp.y = 282
	f.alpha = .01
	f.audio = 'hat'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('hat-tap')
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
	-- cases
	local grp = util.addGroup(cart, 'cases-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 120, 80)
	f:setFillColor( _G.util.convertHexToRGB('#d35400') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = 470-10
	grp.y = 223
	f.alpha = .01
	f.audio = 'case'
	
	local art = buildArtwork('cases-tap')
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
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
	
	-- set items
	if( high < 4-1 )then
		
		cart.art['machine'].isVisible = false
		cart['soda'].hit1.isVisible = false
		cart['soda'].hit2.isVisible = false
		cart['soda'].hit3.isVisible = false
		cart['tee-tap'].isVisible = false
		cart['hat-tap'].isVisible = false
		cart['shoes02-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		cart['cases'].phone3.isVisible = false
		cart.condiments.hit1.isVisible = false
		cart.condiments.art1.isVisible = false
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
		
	elseif( high < 6-1 )then
		
		cart['tee-tap'].isVisible = false
		cart['hat-tap'].isVisible = false
		cart['shoes02-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		cart['cases'].phone3.isVisible = false
		cart.condiments.hit1.isVisible = false
		cart.condiments.art1.isVisible = false
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
	

	elseif( high < 8-1 )then
	
		cart['hat-tap'].isVisible = false
		cart['shoes02-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		cart['cases'].phone3.isVisible = false
		cart.condiments.hit1.isVisible = false
		cart.condiments.art1.isVisible = false
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
	
	elseif( high < 12-1 )then
	
		cart['cases-tap'].isVisible = false
		cart['cases'].phone3.isVisible = false
		cart.condiments.hit1.isVisible = false
		cart.condiments.art1.isVisible = false
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
	
	elseif( high < 13-1 )then
	
		cart.condiments.hit1.isVisible = false
		cart.condiments.art1.isVisible = false
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
		
	elseif( high < 17-1 )then
	
		cart.condiments.hit2.isVisible = false
		cart.condiments.art2.isVisible = false
			
	end
	
end

--------------------------- SET LEVEL:

function setLevel(num)
	
end

--------------------------- CUSTOMERS:

function buildCustomers(grp_main)

	-- pull main
	local customers = grp_main.customers
	
	-- build 4: customers
	local cList = {}
	for i=1, 4 do
	
		local c = _G.engine.buildCustomer()
		c.y = -128
		customers:insert(c)
		
		c.x = ( (i-1) * (256-6) ) - 512 + 128
		c.x = c.x + 24
		
		c.endX = c.x
		c.endY = c.y
		
		local dir = math.floor(math.random()*2)+1
		if( dir==1 )then
	
			c.x = c.x + CUSTOMER_OFFSET
		
		else
		
			c.x = c.x - CUSTOMER_OFFSET
		
		end 
		
		-- set to have multi-requests
		c.totalRequests = 3
		c.curRequest = 1
		
		-- add to list
		cList[#cList+1] = c
		
		grp_main.requests:insert( c.request )
		c.request.alpha = 1
		c.request.x = c.request.x + c.endX
		c.request.y = c.request.y + c.endY
		
	end
	_G.util.table.shuffle(cList)
	grp_main.customers.cList = cList
	
end

function setCustomerRequest(customer)

	--print('Define Request:')
	
	-- remove requests
	local oldValue = 0
	if( customer.requests )then
		
		if( customer.requests.oldValue )then
		
			oldValue = customer.requests.oldValue
			
		end
		
		customer.requests:removeSelf()
		customer.requests = nil
		
	end

	-- set vars
	local rtypes = {'drink','side','volumeup','volumedown','instrument'}
	local rlimit = math.floor(math.random()*3)+1
	local request = _G.util.addGroup(customer, 'requests', 0, 0, 1)
	local food = nil
	local art = nil
	
	-- save request num
	customer.rlimit = rlimit
	
	-- if first request...
	local order
	if( customer.curRequest == 1 )then
		
		customer.totalRequests = #levelData.orders[ curCustomer ].order
		--print('set total r: ' .. customer.totalRequests)
		
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
	
	-- build request
	for i=1, rlimit do
		
		local fletter = order[i]:sub(1,1)

		-- add drink
		if( order[i] == 'C' )then
			
			food = _G.engine.buildHitArea('#1abc9c', 64, 64, 'none')
			food.food = 'drink'
			food.value = itemValues['drink']
			
			art = buildArtwork('soda')
			art.full.alpha = 1
			art.empty.alpha = 0
			food:insert(art)
			
		end
		
		-- add shoes01
		if( order[i] == 'B' )then
			
			food = _G.engine.buildHitArea('#af7ac4', 64, 64, 'none')
			food.food = 'shoes'
			food.color = '#af7ac4'
			food.value = itemValues['shoes01']
			
			art = buildArtwork('shoes01')
			food:insert(art)
			
		end
		
		-- add shoes02
		if( order[i] == 'T' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'shoes'
			food.color = '#e74c3c'
			food.value = itemValues['shoes02']
			
			art = buildArtwork('shoes02')
			food:insert(art)
			
		end
		
		-- add clothes
		if( (fletter == 'S') or (fletter == 'P') or (fletter == 'W') or (fletter == 'H') )then
						
			if( fletter == 'S' )then
			
				-- t-shirt
				food = _G.engine.buildHitArea('#3498db', 64, 64, 'none')
				food.color = '#3498db'
				food.food = 'clothes'
				food.value = itemValues['shirt']
				
				-- get artwork
				art = buildArtwork('shirt')
				art.xScale = .85
				art.yScale = .85
				art.x = 4
				art.shadow.alpha = 0
				food:insert(art)
								
			end
			
			if( fletter == 'P' )then
				
				food = _G.engine.buildHitArea('#2ecc71', 64, 64, 'none')
				food.color = '#2ecc71'
				food.food = 'clothes'
				food.value = itemValues['pants']
				
				-- get artwork
				art = buildArtwork('pants')
				art.xScale = .85
				art.yScale = .85
				art.x = 4
				art.shadow.alpha = 0
				food:insert(art)
				
			end
			
			if( fletter == 'W' )then
				
				food = _G.engine.buildHitArea('#f1c40f', 64, 64, 'none')
				food.color = '#f1c40f'
				food.food = 'clothes'
				food.value = itemValues['sweater']
				
				-- get artwork
				art = buildArtwork('tee')
				art.xScale = .85
				art.yScale = .85
				art.x = 4
				art.shadow.alpha = 0
				food:insert(art)
				
			end
			
			if( fletter == 'H' )then
				
				food = _G.engine.buildHitArea('#ff0000', 64, 64, 'none')
				food.color = '#ff0000'
				food.food = 'clothes'
				food.value = itemValues['hat']
				
				-- get artwork
				art = buildArtwork('hat')
				art.xScale = .85
				art.yScale = .85
				art.x = 4
				art.shadow.alpha = 0
				food:insert(art)
				
			end
			
			-- choose color
			local cnum = tonumber( order[i]:sub( 2,2 ) )
			local col = colorSet[ cnum ]
			local icon = util.addFill(food, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
			icon:setFillColor(_G.util.convertHexToRGB( col ) )
			icon.color = col
			art.fill:setFillColor(_G.util.convertHexToRGB( col ) )
			
			-- paint
			food.value = food.value + itemValues['paint']
			
		end
			
		-- add phone case
		if( order[i] == 'I' )then
			
			food = _G.engine.buildHitArea('#e67e22', 64, 64, 'none')
			food.food = 'side'
			food.color = '#e67e22'
			food.value = itemValues['case']
			
			art = buildArtwork('case')
			--art.shadow.alpha = 0
			food:insert(art)
			
		end
		
		-- add application
		if( order[i] == 'A' )then
			
			food = _G.engine.buildHitArea('#ffff00', 64, 64, 'none')
			food.food = 'topping'
			food.color = '#ffff00'
			food.value = itemValues['application']
			
			art = buildArtwork('application')
			food:insert(art)
			
		end
		
		-- add gift
		if( order[i] == 'G' )then
			
			food = _G.engine.buildHitArea('#ff00ff', 64, 64, 'none')
			food.food = 'topping'
			food.color = '#ff00ff'
			food.value = itemValues['gift']
			
			art = buildArtwork('gift')
			food:insert(art)
			
		end
		
		
		-- place food
		food.y = i * 74
		request:insert(food)
		
		-- hide objects
		_G.engine.hideObjects(food)
		
	end
	
	-- position request
	request.value = 0
	request.x = 64
	request.y = -58
	request.xScale = .65
	request.yScale = request.xScale
	request.y = request.y - (request.height * request.xScale * .5)
	
	-- reposition
	customer.request:insert( request )
	request.x = 10
	request.y = request.y + 33
	
end

--------------------------- WAITING ROOMS:

function handleRequestWait(customer)
	
	-- save old value
	customer.requests.oldValue = customer.requests.value 
	
	-- find open room
	local emptyRooms = {}
	for i=1, 4 do
	
		local r = main.background['room'..i]
		if( (r.status == 'empty') and (r.isVisible) )then
		
			emptyRooms[#emptyRooms+1] = i
			
		end
		
	end
	_G.util.table.shuffle( emptyRooms )
	
	-- set dresser to customer
	local num = customer.body.art.num
	local art = _G.customers.buildArtwork(num)
	art.alpha = 0
	art.xScale = .4
	art.yScale = .4
	art.y = -110
	
	customer.dresser = art
	main.dressers:insert(art)
	
	-- check if rooms avail
	if( #emptyRooms > 0 )then
	
		customer.roomNum = emptyRooms[1]
		main.background['room'.. customer.roomNum].status = 'full'
		
	else
	
		print('no rooms avaiable')
		customer.waitingForRoom = true
		return
		
	end
	
	-- hide customer
	walkCustomerOff( customer )
	
	-- send in dresser
	local myclosure = function() return sendToRoom( customer ) end	
	customer.curTimer = timer.performWithDelay( 2500, myclosure )
	
end

function walkCustomerOff(targ)
	
	-- shift layers
	if(not targ.masked)then
		targ:toBack()
	end
	
	-- stop animations
	if(targ.body.art)then
	
		_G.customers.prepForExit(targ.body.art)
		
	end
	
	-- hide request
	transition.to( targ.request, {delay=0000, time=100, 
								  xScale=.001, yScale=.001, 
								  transition=easing.outQuad})
								  
	-- choose direction
	local newX
	local dir = math.floor(math.random()*2)+1
	if( dir==1 )then
	
		newX = targ.x + CUSTOMER_OFFSET
		
	else
		
		newX = targ.x - CUSTOMER_OFFSET
		
	end 
	
	-- walk away
	targ.isHiding = true
	local myclosure = function() return resetCustomer(targ) end	
	transition.to( targ, {delay=0300, time=2500, x=newX, 
							transition=easing.linear})
							
	-- bounce step
	transition.to( targ, {delay=0300, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=0612, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=0925, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=1237, time=0312, y=targ.endY, transition=easing.inOutQuad})

	transition.to( targ, {delay=1550, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=1862, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=2175, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=2487, time=0312, y=targ.endY, transition=easing.inOutQuad})
							
end

function sendToRoom(customer)
	
	print('send to room: ' .. customer.roomNum )
	
	local room = main.background['room' .. customer.roomNum ]
	
	local targ = customer.dresser
	targ.endX = room.x + 65
	targ.endY = targ.y
	
	if( customer.x < 0 )then
		targ.x = targ.endX - 1024
	else
		targ.x = targ.endX + 1024
	end

	targ.alpha = 1
	
	-- move to position
	transition.to( targ, {delay=000, time=3200, x=targ.endX, 
							transition=easing.linear})
	
	-- bounce step					
	transition.to( targ, {delay=0000, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=0400, time=0400, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=0800, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=1200, time=0400, y=targ.endY, transition=easing.inOutQuad})
	
	transition.to( targ, {delay=1600, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=2000, time=0400, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=2400, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=2800, time=0400, y=targ.endY, transition=easing.inOutQuad})
	
	-- move into room
	local myclosure = function() return moveIntoRoom(customer) end	
	customer.curTimer = timer.performWithDelay(3200, myclosure )
							
end

function moveIntoRoom(customer)
	
	local targ = customer.dresser
	local curtain = main.dressers['curtain' .. customer.roomNum ]
	
	main.inroom:insert(targ)
	
	curtain:setSequence('close')
	curtain:play()
	_G.mixer.playSFX('curtain_close')
	
	-- open curtain
	local myclosure = function() return openCurtain( customer ) end	
	customer.curTimer = timer.performWithDelay(ROOM_WAIT_TIME, myclosure )
	
end

function openCurtain(customer)

	local curtain = main.dressers['curtain'.. customer.roomNum]
	curtain:setSequence( "open" )
	curtain:play()
	_G.mixer.playSFX('curtain_open')
	
	-- send out customer
	local myclosure = function() return exitRoom( customer ) end	
	customer.curTimer = timer.performWithDelay(600, myclosure )
	
end

function exitRoom(customer)
	
	-- reset wait-time
	customer.countDown = customer.countDown + 1200
	if( customer.countDown > customer.countDelay )then
		customer.countDown = customer.countDelay
	end
	
	-- get targ
	local targ = customer.dresser
	if( customer.x < 0 )then
		targ.endX = targ.endX - 1024
	else
		targ.endX = targ.endX + 1024
	end
	
	-- update status
	main.background['room'.. customer.roomNum].status = 'empty'
	
	-- switch layers
	main.dressers:insert(customer.dresser)

	-- move to position
	transition.to( targ, {delay=000, time=3200, x=targ.endX, 
							transition=easing.linear})
	
	-- bounce step					
	transition.to( targ, {delay=0000, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=0400, time=0400, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=0800, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=1200, time=0400, y=targ.endY, transition=easing.inOutQuad})
	
	transition.to( targ, {delay=1600, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=2000, time=0400, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=2400, time=0400, y=targ.endY-10, transition=easing.inOutQuad})
	transition.to( targ, {delay=2800, time=0400, y=targ.endY, transition=easing.inOutQuad})
	
	-- send out customer
	local myclosure = function() return walkCustomerOn( customer ) end	
	customer.curTimer = timer.performWithDelay( 3200, myclosure )
	
	-- check current customers for waiting
	local waiters = {}
	for i=1, 4 do
	
		local c = main.customers[i]
		if(c.waitingForRoom)then
		
			waiters[#waiters+1] = c
			
		end
		
	end
	
	-- if waiters, find lowest bar
	if(#waiters > 0)then
	
		local lowestPer = 1
		local nextC = nil
	
		-- get lowest percentage
		for i=1, #waiters do
		
			local w = waiters[i]
			local per = w.request.bar.yScale
			if( per <= lowestPer )then
			
				lowestPer = per
				nextC = w
				
			end
			
		end
		
		-- send customer off
		main.background['room'.. customer.roomNum].status = 'full'
		nextC.waitingForRoom = false
		nextC.roomNum = customer.roomNum
		walkCustomerOff( nextC )
		
		-- send in dresser
		local myclosure = function() return sendToRoom( nextC ) end	
		nextC.curTimer = timer.performWithDelay( 2500, myclosure )
		
	end
	
end

function walkCustomerOn(targ)
		
	-- move to position
	transition.to( targ, {delay=000, time=2500, x=targ.endX, 
							transition=easing.linear})
	
	-- bounce step					
	transition.to( targ, {delay=0000, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=0312, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=0625, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=0937, time=0312, y=targ.endY, transition=easing.inOutQuad})
	
	transition.to( targ, {delay=1250, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=1562, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=1875, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=2187, time=0312, y=targ.endY, transition=easing.inOutQuad})
							
	-- show request
	local myclosure = function() return setCustomerRequest(targ) end	
	transition.to( targ.request, {delay=2500, time=100, 
								  xScale=1, yScale=1, 
								  transition=easing.outQuad,
							  	  onComplete=myclosure})
								  
	-- start pupils	
	local myclosure = function() return _G.customers.startPupils(targ.body.art) end
	timer.performWithDelay(2500, myclosure)
	
	-- audio
	local myclosure = function() return _G.mixer.playSFX('order') end
	targ.curTimer = timer.performWithDelay(2500, myclosure)
	
end

--------------------------- OBJECTS:

function evaluateTrash(obj)
	
	local value = 0
	
	return value
	
end

--------------------------- EVENTS:

function buildArtwork(food)

	local grp = display.newGroup()
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	

	if(food=='soda')then
		
		ulevel = upgrades[ 'coffee' ]
		if( not ulevel )then ulevel = 0 end
				
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level2/items/coffee05.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/coffee06.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/coffee03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/coffee04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/coffee03.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/coffee04.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/coffee01.png', grp, 'empty', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/coffee02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		
	end
	
	if(food=='shoes01')then
		
		ulevel = upgrades[ 'sketch' ]
		if( not ulevel )then ulevel = 0 end
				
		_G.util.addImage('graphics/level4/items/shoes01.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='shoes02')then
		
		ulevel = upgrades[ 'sketch' ]
		if( not ulevel )then ulevel = 0 end
				
		_G.util.addImage('graphics/level4/items/shoes02.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	
	if(food=='shirt')then
		
		ulevel = upgrades[ 'tops' ]
		if( not ulevel )then 
			
			print('check level on shirt - reset')
			ulevel = 0 
		
		end
		
		print('shirt: ' .. ulevel )
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/shirt03.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/shirt06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/shirt06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/shirt09.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='pants')then

		ulevel = upgrades[ 'pants' ]
		if( not ulevel )then ulevel = 0 end
		
		print('pants: ' .. ulevel )
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/pants03.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/pants06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/pants06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/pants09.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='tee')then

		ulevel = upgrades[ 'tees' ]
		if( not ulevel )then ulevel = 0 end
		
		print('tee: ' .. ulevel )
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/tee03.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/tee06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/tee06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/tee09.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	if(food=='hat')then

		ulevel = upgrades[ 'hats' ]
		if( not ulevel )then ulevel = 0 end
		
		print('hats: ' .. ulevel )
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/hat05.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/hat05.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat02.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/hat05.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat02.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/hat05.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	
	if(food=='case')then

		ulevel = upgrades[ 'cases' ]
		if( not ulevel )then ulevel = 0 end
			
		--_G.util.addImage('graphics/level2/items/case04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
								
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level4/items/case01.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/case02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/case02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/case03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/case-shadow.png', grp, 'shadow', 6, 4, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/case.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='phone')then

		ulevel = upgrades[ 'phone' ]
		if( not ulevel )then ulevel = 0 end
			
		--_G.util.addImage('graphics/level2/items/case04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
								
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level4/items/phone01.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/phone02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/phone02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/phone03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end

	end
	

	if(food=='shirt-tap')then

		ulevel = upgrades[ 'tops' ]
		if( not ulevel )then ulevel = 0 end
									
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/shirt-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt-tap01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/shirt-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/shirt-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/shirt-tap08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/shirt-tap07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

	end
	
	if(food=='pants-tap')then

		ulevel = upgrades[ 'pants' ]
		if( not ulevel )then ulevel = 0 end
									
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/pants-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants-tap01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/pants-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/pants-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/pants-tap08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/pants-tap07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

	end
	
	if(food=='tee-tap')then

		ulevel = upgrades[ 'tees' ]
		if( not ulevel )then ulevel = 0 end
									
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/tee-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee-tap01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/tee-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/tee-tap05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee-tap04.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/tee-tap08.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/tee-tap07.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

	end
	
	if(food=='hat-tap')then

		ulevel = upgrades[ 'hats' ]
		if( not ulevel )then ulevel = 0 end
		
		_G.util.addImage('graphics/level4/items/hat-tap05.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
									
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level4/items/hat-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat-tap01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/hat-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat-tap02.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/hat-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat-tap02.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/hat-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level4/items/hat-tap03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

	end
	
	if(food=='cases-tap')then

		ulevel = upgrades[ 'cases' ]
		if( not ulevel )then ulevel = 0 end
									
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level4/items/case-tap01.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level4/items/case-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level4/items/case-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level4/items/case-tap03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end

	end
	
	
	if(food=='application')then
		
		ulevel = upgrades[ 'sketch' ]
		if( not ulevel )then ulevel = 0 end
				
		_G.util.addImage('graphics/level4/items/app-tap.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='gift')then
		
		ulevel = upgrades[ 'sketch' ]
		if( not ulevel )then ulevel = 0 end
				
		_G.util.addImage('graphics/level4/items/gift-tap.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
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


end

--------------------------- UI:
function setTutorial(num, callback, xPass, yPass,parentPass)
    local info
    print( "Number ::::  :::: ",num )
	if num == 1 then
		_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragDrink3",{ fY = 40, x= -100, y = 200, group=grp_main, callback = callback })
    	
    end

	if (num==4) then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectColor3",{ fY = 40, x= 40, y = 150, group=grp_main, callback = callback })
    end

    if num == 3 then
    	-- print( "NUm :::: ",num )
    	-- _G.loadsave.print_r( callback )
     --    info = _G.gui.setTutorial("selectPent3",{ fY = 40, x= -20, y = 230, group=grp_main, callback = callback })
    end
    
	if num == 2 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectMultiColorT3",{ fY = 40, x= -140, y = 230, group=grp_main, callback = callback })
    end   

    if num == 6 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectPlainColorT3",{ fY = 40, x= 80, y = 230, group=grp_main, callback = callback })
    end

    if num == 13 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectCap3",{ fY = 40, x= 170, y = 220, group=grp_main, callback = callback })
    end

	if num == 7 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectWhiteShoseColorT3",{ fY = 40, x= -240, y = 230, group=grp_main, callback = callback })
    end

    if num == 5 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectBlackShoseColorT3",{ fY = 40, x= -320, y = 230, group=grp_main, callback = callback })
    end

    if num == 9 then
    end

    if num == 10 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragPent3",{ fY = 40, x= -20, y = 130, group=grp_main, callback = callback })
    end

    if num == 11 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragSingleColorT3",{ fY = 40, x=80, y = 130, group=grp_main, callback = callback })
    end

    if num == 12 then
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("dragMultiColorT3",{ fY = 40, x=-140, y = 130, group=grp_main, callback = callback })
    end

    -- if num == 13 then
    -- 	print( "_____-Displaying-_______" )
    -- 	_G.loadsave.print_r( callback )
    --     info = _G.gui.setTutorial("dragCap3",{ fY = 40, x=170, y = 130, group=grp_main, callback = callback })
    -- end

    if num == 14 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["dragWhiteShoseT3"].type = "right"
            xSet = cList[1].x - 330
        else
            _G.TutorialData.data["dragWhiteShoseT3"].type = "left"
            xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("dragWhiteShoseT3",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end

    if num == 40 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("waitShoseReady",{ fY = 40, x=-240,y = 3130, group=grp_main, callback = callback })
    end
    
	if num == 15 then
    	-- print("Pass Data ::::: ", xPass,yPass)
     --    info = _G.gui.setTutorial("dragBlackShoseT3",{ fY = 40, x=-320,y = 130, group=grp_main, callback = callback })
    end

    if num == 16 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("dragGift",{ fY = 40, x=380,y = 180, group=grp_main, callback = callback })
    end

    if num == 17 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("dragjobRequestT3",{ fY = 40, x=280,y = 200, group=grp_main, callback = callback })
    end

    if num == 18 then
    	print("Pass Data ::::: ", xPass,yPass)
        info = _G.gui.setTutorial("selectPhoneCaseT3",{ fY = 40, x=450,y = 180, group=grp_main, callback = callback })
    end

    if num == 19 then
    end

    if num == 20 then
        info = _G.gui.setTutorial("wellcomeFregsApparelMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
    if num == 42 then
        info = _G.gui.setTutorial("wellcomeFregsApparelMessage2",{ fy = 100, y=110, group=grp_main, callback = callback })
    end
	if num == 21 then
    	print( "NUm :::: ",num )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("selectPent23",{ fY = 40, x= -20, y = 230, group=grp_main, callback = callback })
    end
	if(num==22)then               
        local cList = {_G.engine.runningCust}
        print("get Clist x pos ::: ",cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["collectFregsApperalMoney"].type = "right"
            xSet = cList[1].x - 280
        else
            _G.TutorialData.data["collectFregsApperalMoney"].type = "left"
            xSet = cList[1].x + 250
        end
        print("xList ::: ",cList[1].x)
        info = _G.gui.setTutorial("collectFregsApperalMoney",{ fY = 40, x= xSet, y = 70, group=grp_main, callback = callback })
        print( "Info :::: " )
        _G.loadsave.print_r(info)
    end
    if num == 23 then
    	print( "NUm :::: ",num )
    	_G.loadsave.print_r( callback )
        info = _G.gui.setTutorial("removeItemFragApperalItem",{ fY = 40, x= -20, y = 230, group=grp_main, callback = callback })
    end
    if info ~= nil then
		print( "infoname ::: ",info.tutName )
    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
    	print_r(info.passData)
    end
    if num == 24 then
    	local cList = {_G.engine.runningCust}
        print(cList[1].x)
        local xSet = 0
        if( cList[1].x > 0 )then
            _G.TutorialData.data["firstFragsApperal2CustomerMessage"].type = "right"
            xSet = cList[1].x - 330
        else
            _G.TutorialData.data["firstFragsApperal2CustomerMessage"].type = "left"
            xSet = cList[1].x + 330
        end
        info = _G.gui.setTutorial("firstFragsApperal2CustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
    end

    return info     
end

--------------------------- MODULE EVENTS:

