
module(..., package.seeall)

-------------------------- CONSTANTS

local STENCIL_CHANCE = 5
local CUSTOMER_OFFSET = 1400

local colorSet = {'#863d44','#97894f','#497b60','#5e93a4','#6f526f','#b7946f'}

local csetA = {'#873e44','#9b8d51','#4a7c61','#5e94a5','#705270','#ffffff'}
local csetB = {'#932230','#a58a17','#23844c','#288ea5','#702a72','#808285'}
local csetC = {'#ce0d2d','#ffce00','#04af49','#00dbff','#92049e','#231f20'}
local cSets = {csetA,csetB,csetC}

-------------------------- VARIABLES

local itemValues = {}
local cookTimes = {}

itemValues['drink'] = 10
itemValues['sketch'] = 10
itemValues['shirt'] = 10
itemValues['jeans'] = 10
itemValues['hat'] = 10
itemValues['stencila'] = 5
itemValues['stencilb'] = 5
itemValues['stencilc'] = 5
itemValues['mug'] = 10
itemValues['case'] = 10
itemValues['paint'] = 10

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
	
	-- set coffee
	ulevel = upgrades['coffee']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['coffee'].revenue[ ulevel+1 ]
	itemValues['drink'] = revenue
	
	ulevel = upgrades['coffee machine']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['coffee machine'].prepTime[ ulevel+1 ]
	cookTimes['drink'] = cooktime * 60
	
	-- set sketch
	ulevel = upgrades['sketch']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['sketch'].revenue[ ulevel+1 ]
	itemValues['sketch'] = revenue
	
	ulevel = upgrades['sketchpad']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['sketchpad'].prepTime[ ulevel+1 ]
	cookTimes['sketch'] = cooktime * 60
	
	-- set tops
	ulevel = upgrades['tops']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['tops'].revenue[ ulevel+1 ]
	itemValues['shirt'] = revenue
	
	ulevel = upgrades['spray can']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['spray can'].prepTime[ ulevel+1 ]
	cookTimes['shirt'] = cooktime * 60
	
	-- set jeans
	ulevel = upgrades['pants']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['pants'].revenue[ ulevel+1 ]
	itemValues['jeans'] = revenue
	
	ulevel = upgrades['spray can']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['spray can'].prepTime[ ulevel+1 ]
	cookTimes['jeans'] = cooktime * 60
	
	-- set hats
	ulevel = upgrades['hats']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['hats'].revenue[ ulevel+1 ]
	itemValues['hat'] = revenue
	
	ulevel = upgrades['spray can']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['spray can'].prepTime[ ulevel+1 ]
	cookTimes['hat'] = cooktime * 60
	
	-- set stencil
	ulevel = upgrades['stencils']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['stencils'].revenue[ ulevel+1 ]
	itemValues['stencila'] = revenue
	itemValues['stencilb'] = revenue
	itemValues['stencilc'] = revenue
	
	-- set mugs
	ulevel = upgrades['mugs']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['mugs'].revenue[ ulevel+1 ]
	itemValues['mug'] = revenue
	
	ulevel = upgrades['mug supplies']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['mug supplies'].prepTime[ ulevel+1 ]
	cookTimes['mug'] = cooktime * 60
	
	-- set cases
	ulevel = upgrades['cases']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['cases'].revenue[ ulevel+1 ]
	itemValues['case'] = revenue
	
	ulevel = upgrades['case supplies']
	if(not ulevel)then ulevel=0 end
	cooktime = _G.levelInfo.upgrades['case supplies'].prepTime[ ulevel+1 ]
	cookTimes['case'] = cooktime * 60
	
	-- set paints
	ulevel = upgrades['paints']
	if(not ulevel)then ulevel=0 end
	revenue = _G.levelInfo.upgrades['paints'].revenue[ ulevel+1 ]
	itemValues['paint'] = revenue
	
	----------------------------
	--------- INTERIORS --------
	----------------------------
	
	-- tip time, wait time, tip amount, extras
	local vars = {0,0,0,0}
	
	ulevel = upgrades['lighting']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['lighting'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	
	ulevel = upgrades['banners']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['banners'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['banners'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['salesman']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['salesman'].tipTime[ ulevel+1 ]
	vars[1] = vars[1] + val
	val = _G.levelInfo.upgrades['salesman'].waitTime[ ulevel+1 ]
	vars[2] = vars[2] + val
	
	ulevel = upgrades['musicians']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['musicians'].tipAmount[ ulevel+1 ]
	vars[3] = vars[3] + val
	
	ulevel = upgrades['table']
	if(not ulevel)then ulevel=0 end
	val = _G.levelInfo.upgrades['table'].extraCustomer[ ulevel+1 ]
	vars[4] = vars[4] + val
	
	_G.engine.setUpgradableVars( vars )
	_G.gui.setUpgradableVars( vars )
		
end

--------------------------- LEVELS:

function buildLevel(grp_main)
	
	main = grp_main
	
	local col = 0
	local row = 0
	
	-- background 
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local grp = util.addGroup(bg, 'art', 0, 0, 1)
	for i=1, 4 do
		
		local c = util.addImage('graphics/level2/bg_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
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
	
	-- customers layer
	local customers = util.addGroup(grp_main, 'customers', 0, 0, 1)
	local requests = util.addGroup(grp_main, 'requests', 0, 0, 1)
	
	-- foreground
	local fg = util.addGroup(grp_main, 'foreground', 0, 0, 1)
	
	-- cart
	col = 0
	row = 0
	local cart = util.addGroup(fg, 'cart', 0, 0, 1)
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	for i=1, 4 do
		
		local c = util.addImage('graphics/level2/table01_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
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
	
	-- counter layer
	local counter = util.addGroup(grp_main, 'counter', 0, 0, 1)
	
end

function buildItems()

	print("******** BUILD ITEMS *********")

	local cart = main.foreground.cart
	local ulevel = nil
	local upgrades = _G.userdata.leveldata[ _G.curLevelNum ].upgrades
	
	-- rebuild cart
	cart.art:removeSelf()	
	local grp = util.addGroup(cart, 'art', 0, 0, 1)
	
	-- below table
	util.addImage('graphics/level2/items/box-shirts.png', cart.art, 'box-shirts', 526, 780, 1, 1, 0, 1)
	util.addImage('graphics/level2/items/box-hats.png', cart.art, 'box-hats', 780, 738, 1, 1, 0, 1)
	util.addImage('graphics/level2/items/box-pants.png', cart.art, 'box-pants', 656, 733, 1, 1, 0, 1)
	util.addImage('graphics/level2/items/box-mugs.png', cart.art, 'box-mugs', 1120, 733, 1, 1, 0, 1)
	util.addImage('graphics/level2/items/box-cases.png', cart.art, 'box-cases', 1020, 733, 1, 1, 0, 1)
	util.addImage('graphics/level2/items/trash.png', cart.art, 'trash', 910, 733, 1, 1, 0, 1)
	
	-- interiors: 
	local bg = main.background
	
	local ulevel = upgrades['musicians']
	if( not ulevel )then 
		
		ulevel = 0 
	
	end
	
	if( ulevel==1 )then
		util.addImage('graphics/level2/musicians01.png', bg, 'musicians', -352, -130, 1, 1, 0, 1)	
	end
	if( ulevel==2 )then
		util.addImage('graphics/level2/musicians02.png', bg, 'musicians', -352, -130, 1, 1, 0, 1)	
	end
	if( ulevel==3 )then
		util.addImage('graphics/level2/musicians03.png', bg, 'musicians', -352, -130, 1, 1, 0, 1)	
	end

	local ulevel = upgrades['salesman']
	if( not ulevel )then 
		
		ulevel = 0 
	
	end
	
	if( ulevel==1 )then
		util.addImage('graphics/level2/salesman01.png', bg, 'salesman', 326, -126, 1, 1, 0, 1)
	end
	if( ulevel==2 )then
		util.addImage('graphics/level2/salesman02.png', bg, 'salesman', 326, -126, 1, 1, 0, 1)
	end
	if( ulevel==3 )then
		util.addImage('graphics/level2/salesman03.png', bg, 'salesman', 326, -126, 1, 1, 0, 1)
	end
	
	local ulevel = upgrades['table']
	print("---------------",upgrades['table'],"---------------" )
	if( not ulevel or tostring(ulevel) == " " or tostring(ulevel) == '' or tonumber(ulevel) == 0 )then 
		
		ulevel = 1 
	
	end
	
	-- table
	local col = 0
	local row = 0
	for i=1, 4 do
		print( 'graphics/level2/table0'..ulevel..'_0'..i..'.png' )
		local c = util.addImage('graphics/level2/table0'..ulevel..'_0'..i..'.png', grp, 'c', 0, 0, 1, 1, 0, 1)
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
	
	-- coffee machine
	util.addImage('graphics/level2/items/coffee-machine.png', cart.art, 'machine', 334, 120+334, 1, 1, 0, 1)
	
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
	grp.x = -396
	grp.y = 85
	grp.itemList = itemList
	
	ulevel = upgrades[ 'coffee machine' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'coffee machine' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit3.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -394, 88, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -306, 88, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -394, 88, .85, .85, 0, 1)
		
	end
	
	-- sketches
	itemList = {}
	local grp = util.addGroup(cart, 'sketch', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#af7ac4', 80, 80, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'sketch'
		grp:insert(f)
		grp['hit'..i] = f

		itemList[i] = f
		f.x = (i-1) * -22
		f.y = (i-1) * 76
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('sketch')
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['sketch']
		_G.engine.hideObjects(f)
		
		f.loop = 'sketch_loop'
		f.audio = 'sketch_stop'
		f.select = 'sketch'
		
	end
	grp.x = -206
	grp.y = 48
	grp.itemList = itemList
	
	ulevel = upgrades[ 'sketchpad' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'sketchpad' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- shirts
	scaleList = {.84,.92,1}
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
		
		f.loop = 'stencil_loop'
		f.audio = 'stencil_stop'
		f.select = 'tshirt'
		
	end
	grp.x = -120+10
	grp.y = 54
	grp.itemList = itemList
	
	ulevel = upgrades[ 'tops tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'tops tabletop' ].unlocked[ ulevel+1 ]
	
	_G.util.addImage('graphics/gui/lock.png', cart.locks, 'shirt-lock1', -130, 190, .85, .85, 0, 1)
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -106, 50, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -118, 116, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -106, 50, .85, .85, 0, 1)
		
	end
	
	-- jeans
	scaleList = {.84,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'jeans', 0, 0, 1)
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
		
		local art = buildArtwork('jeans')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['jeans']
		_G.engine.hideObjects(f)
		
		f.loop = 'stencil_loop'
		f.audio = 'stencil_stop'
		f.select = 'jeans'
		
	end
	grp.x = -26+10
	grp.y = 56
	grp.itemList = itemList
	
	ulevel = upgrades[ 'pants tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'pants tabletop' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 50, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 116, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', -16, 50, .85, .85, 0, 1)
		
	end
	
	-- hats
	scaleList = {.84,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'hats', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers','garbage'}
	
		local f = _G.engine.buildHitArea('#f1c40f', 70, 70, 'clothes', targets)
		f.id = 'hit'..i
		f.food = 'clothes'
		grp:insert(f)
		grp['hit'..i] = f
		
		itemList[i] = f
		f.x = (i-1) * 8
		f.y = (i-1) * 72
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		local art = buildArtwork('hats')
		art.x = 0
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['hat']
		_G.engine.hideObjects(f)
		
		f.loop = 'stencil_loop'
		f.audio = 'stencil_stop'
		f.select = 'hat'
		
	end
	grp.x = 60+10
	grp.y = 54
	grp.itemList = itemList
	
	ulevel = upgrades[ 'hats tabletop' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'hats tabletop' ].unlocked[ ulevel+1 ]
	
	_G.util.addImage('graphics/gui/lock.png', cart.locks, 'hat-lock1', 90, 190, .85, .85, 0, 1)
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 70, 50, .85, .85, 0, 1)
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 80, 116, .85, .85, 0, 1)
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
		_G.util.addImage('graphics/gui/lock.png', cart.locks, 'img', 70, 50, .85, .85, 0, 1)
		
	end
	
	-- color artwork
	ulevel = upgrades[ 'paints' ]
	if( not ulevel )then ulevel = 0 end
								
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level2/items/colors01.png', cart, 'img', 240, 160, 1, 1, 0, 1)
		colorSet = cSets[1]
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level2/items/colors01.png', cart, 'img', 240, 160, 1, 1, 0, 1)
		colorSet = cSets[1]
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level2/items/colors02.png', cart, 'img', 240, 160, 1, 1, 0, 1)
		colorSet = cSets[2]
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level2/items/colors03.png', cart, 'img', 240, 160, 1, 1, 0, 1)
		colorSet = cSets[3]
	end
	
	-- colors: special
	col = 0
	row = 0
	local colors = colorSet
	local letters = {'a','b','c','d','e','f'}
	local xoff = {0,-30,16,-10,30,10}
	local grp = util.addGroup(cart, 'colors', 0, 0, 1)
	for i=1, 6 do
		
		local targets = {'shirts','jeans','hats'}
	
		local f = _G.engine.buildHitArea('#34495e', 64, 54, 'color', targets)
		f.id = 'hit'..i
		grp:insert(f)
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 60, 44)
		icon:setFillColor(_G.util.convertHexToRGB(colors[i]) )
		f.color = colors[i]
		f.num = i
		
		--_G.util.addImage('graphics/level2/items/color-'..letters[i]..'.png', f, 'img', 0, 0, 1, 1, 0, 1)

		f.x = col * 108
		f.x = f.x + xoff[i]
		f.y = row * 50
		f:addEventListener('touch', _G.engine.onColorTouch)
		f.alpha = 1
		_G.engine.hideObjects(f)
		
		col = col + 1
		if( col == 2 )then
			col = 0
			row = row + 1
		end
		
	end
	grp.x = 180
	grp.y = 107
	
	-- condiments: stencils
	local stencils = {'b','c','a'}
	local grp = util.addGroup(cart, 'stencils', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'shirts','jeans','hats'}
	
		local f = _G.engine.buildHitArea('#34495e', 58, 70, 'stencil', targets)
		f.id = 'hit'..i
		grp:insert(f)
		
		local icon = util.addFill(f, 'icon', 0, 0, 0, 1, 0, 0, 26, 26)
		_G.util.addText(stencils[i], f, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
		f.letter = stencils[i]
		f.num = i
		
		f.select = 'stencil'
		
		icon.alpha = 0
		f.stencil.alpha = 0
		_G.engine.hideObjects(f)
		
		local img = util.addImage('graphics/level2/items/stencil-'..stencils[i]..'.png', f, 'img', 0, 0, 1, 1, 0, 1)
		img:setFillColor(0,0,0)
		f.art = img
		img.alpha = 0

		f.x = (i-1) * 60
		f.alpha = 1
		f:addEventListener('touch', _G.engine.onHitTouch)
		
	end
	grp.x = 130+10
	grp.y = 28
	
	-- mugs
	scaleList = {.84,.92,1}
	itemList = {}
	local grp = util.addGroup(cart, 'mugs', 0, 0, 1)
	for i=1, 3 do
	
		local targets = {'customers'}
	
		local f = _G.engine.buildHitArea('#e74c3c', 64, 64, 'cooker', targets)
		f.id = 'hit'..i
		f.food = 'side'
		f.name = 'mug'
		grp:insert(f)
		grp['hit'..i] = f
		
		local art = buildArtwork('mug')
		art.x = 10
		f.xScale = scaleList[i]
		f.yScale = scaleList[i]
		f:insert(art)
		f.art = art
		f.art.alpha = 0
		f.cooktime = cookTimes['mug']
		_G.engine.hideObjects(f)
		
		itemList[i] = f
		f.x = (i-1) * 30
		f.y = (i-1) * 66
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		f.select = 'mug'
		
	end
	grp.x = 390+8
	grp.y = 60
	grp.itemList = itemList
	
	ulevel = upgrades[ 'mug supplies' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'mug supplies' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
	
	-- cases
	scaleList = {.84,.90,1}
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
		f.x = (i-1) * 26
		f.y = (i-1) * 64
		f:addEventListener('touch', _G.engine.onHitTouch)
		
		if(i==1)then f.y=f.y+1 end
		if(i==2)then f.y=f.y-2 end
		
		f.select = 'case'
		
	end
	grp.x = 324+8
	grp.y = 80
	grp.itemList = itemList
	
	ulevel = upgrades[ 'case supplies' ]
	if( not ulevel )then ulevel = 0 end
	local max = _G.levelInfo.upgrades[ 'case supplies' ].unlocked[ ulevel+1 ]
	
	if( max==1 )then
	
		grp.hit1.isVisible = false
		grp.hit2.isVisible = false
		
	end
	if( max==2 )then
	
		grp.hit1.isVisible = false
		
	end
		
	------------------------------------------------
	--- TAPS
	------------------------------------------------
	
	-- garbage
	local grp = util.addGroup(cart, 'garbage', 0, 0, 1)
	local f = _G.engine.buildHitArea('#333333', 128, 100, 'garbage', nil)
	grp:insert(f)
	f.over:setFillColor(1,0,0)
	grp.x = 216
	grp.y = 330
	f.alpha = .01
	
	-- sketchpad
	local grp = util.addGroup(cart, 'sketch-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 150, 80)
	f:setFillColor( _G.util.convertHexToRGB('#8e44ad') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	grp.x = -380
	grp.y = 186
	
	ulevel = upgrades[ 'sketch' ]
	if( not ulevel )then ulevel = 0 end
								
	if( ulevel == 0 )then
		_G.util.addImage('graphics/level2/items/sketchpad01.png', grp, 'img', 10, 12, 1, 1, 0, 1)
	end
	if( ulevel == 1 )then
		_G.util.addImage('graphics/level2/items/sketchpad02.png', grp, 'img', 10, 12, 1, 1, 0, 1)
	end
	if( ulevel == 2 )then
		_G.util.addImage('graphics/level2/items/sketchpad02.png', grp, 'img', 10, 12, 1, 1, 0, 1)
	end
	if( ulevel == 3 )then
		_G.util.addImage('graphics/level2/items/sketchpad03.png', grp, 'img', 10, 12, 1, 1, 0, 1)
	end
	
	f.alpha = .01
	
	f.audio = 'sketch_start'
	f.loop = 'sketch_loop'
	
	-- shirts
	local grp = util.addGroup(cart, 'shirts-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 80, 100)
	f:setFillColor( _G.util.convertHexToRGB('#2980b9') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#3498db'
	grp.x = -144
	grp.y = 324
	f.alpha = .01
	
	f.audio = 'tshirt'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('shirt-tap')
	art.alpha = 1
	art.y = -6
	grp:insert(art)
	grp.art = art
	
	-- jeans
	local grp = util.addGroup(cart, 'jeans-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 80, 64)
	f:setFillColor( _G.util.convertHexToRGB('#27ae60') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#2ecc71'
	grp.x = -25
	grp.y = 328
	f.alpha = .01
	
	f.audio = 'jeans'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('jeans')
	art.xScale = .85
	art.yScale = art.xScale
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
	-- hats
	local grp = util.addGroup(cart, 'hats-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 64, 64)
	f:setFillColor( _G.util.convertHexToRGB('#f39c12') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'single'
	f.color = '#f1c40f'
	grp.x = 93
	grp.y = 332
	f.alpha = .01
	
	f.audio = 'hat'
	
	local icon = util.addFill(grp, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
	icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
	grp.icon.color = '#ffffff'
	icon.alpha = 0
	
	local art = buildArtwork('hats')
	art.xScale = .85
	art.yScale = art.xScale
	art.alpha = 1
	grp:insert(art)
	grp.art = art
	
	-- mugs
	local grp = util.addGroup(cart, 'mugs-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 100, 80)
	f:setFillColor( _G.util.convertHexToRGB('#e74c3c') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = 460
	grp.y = 320
	f.alpha = .01
	
	f.audio = 'mug'
	
	-- cases
	local grp = util.addGroup(cart, 'cases-tap', 0, 0, 1)
	local f = util.addFill(grp, 'hit', 0, 0, 0, 1, 0, 0, 120, 80)
	f:setFillColor( _G.util.convertHexToRGB('#d35400') )
	f:addEventListener('touch', _G.engine.onHitTouch)
	f.type = 'all'
	grp.x = 350
	grp.y = 320
	f.alpha = .01
	
	f.audio = 'case'
	
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
	
	--high = 1
	
	if( high < 4-1 )then
	
		cart['shirts-tap'].isVisible = false
		cart['hats-tap'].isVisible = false
		cart['sketch-tap'].isVisible = false
		cart['mugs-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		
		cart.art['box-shirts'].isVisible = false
		cart.art['box-hats'].isVisible = false
		cart.art['box-mugs'].isVisible = false
		cart.art['box-cases'].isVisible = false
		
	elseif( high < 7-1 )then

		cart['hats-tap'].isVisible = false
		cart['sketch-tap'].isVisible = false
		cart['mugs-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		
		cart.art['box-hats'].isVisible = false
		cart.art['box-mugs'].isVisible = false
		cart.art['box-cases'].isVisible = false
		
		cart.locks['shirt-lock1'].isVisible = false
		
	elseif( high < 11-1 )then
		
		cart['sketch-tap'].isVisible = false
		cart['mugs-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		
		cart.art['box-mugs'].isVisible = false
		cart.art['box-cases'].isVisible = false
		
		cart.locks['hat-lock1'].isVisible = false
		cart.locks['shirt-lock1'].isVisible = false
		
	elseif( high < 15-1 )then
	
		cart['mugs-tap'].isVisible = false
		cart['cases-tap'].isVisible = false
		
		cart.art['box-mugs'].isVisible = false
		cart.art['box-cases'].isVisible = false
		
		cart.locks['hat-lock1'].isVisible = false
		cart.locks['shirt-lock1'].isVisible = false
		
	elseif( high < 18-1 )then
	
		cart['cases-tap'].isVisible = false
		
		cart.art['box-cases'].isVisible = false
		
		cart.locks['hat-lock1'].isVisible = false
		cart.locks['shirt-lock1'].isVisible = false
		
	else
	
		cart.locks['hat-lock1'].isVisible = false
		cart.locks['shirt-lock1'].isVisible = false
		
	end
	
end

--------------------------- SET LEVEL:

function setLevel(num)
	
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
	if( customer.requests )then
		customer.requests:removeSelf()
		customer.requests = nil
	end

	-- 3 types: drink, side, meal
	local rtypes = {'drink','side','clothes','mug','case'}
	local rlimit = math.floor(math.random()*3)+1
	local request = _G.util.addGroup(customer, 'requests', 0, 0, 1)
	local food = nil
	
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
		
		local rnum = math.floor(math.random()*(#rtypes))+1
		--rnum = 3
		
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
		
		-- add sketch
		if( order[i] == 'S' )then
			
			food = _G.engine.buildHitArea('#af7ac4', 64, 64, 'none')
			food.food = 'sketch'
			food.color = '#af7ac4'
			food.value = itemValues['sketch']
			
			art = _G.util.addImage('graphics/level2/items/sketch-request01.png', food, 'art', 0, 0, .9, .9, 0, 1)
			
		end
		
		-- add phone case
		if( order[i] == 'P' )then
			
			food = _G.engine.buildHitArea('#e67e22', 64, 64, 'none')
			food.food = 'side'
			food.color = '#e67e22'
			food.value = itemValues['case']
			
			art = buildArtwork('case')
			art.shadow.alpha = 0
			food:insert(art)
			
		end
		
		-- add mug
		if( order[i] == 'M' )then
			
			food = _G.engine.buildHitArea('#e74c3c', 64, 64, 'none')
			food.food = 'side'
			food.color = '#e74c3c'
			food.value = itemValues['mug']
			
			art = buildArtwork('mug')
			art.xScale = .9
			art.yScale = .9
			art.shadow.alpha = 0
			food:insert(art)
			
		end
		
		-- add clothes
		if( (order[i] ~= 'C') and (order[i] ~= 'S') and (order[i] ~= 'P') and (order[i] ~= 'M') )then
			
			local ctype = order[i]:sub( 1,1 )
			
			if( ctype == 'T' )then
			
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
			
			if( ctype == 'J' )then
				
				food = _G.engine.buildHitArea('#2ecc71', 64, 64, 'none')
				food.color = '#2ecc71'
				food.food = 'clothes'
				food.value = itemValues['jeans']
				
				-- get artwork
				art = buildArtwork('jeans')
				art.xScale = .85
				art.yScale = .85
				art.x = 4
				art.shadow.alpha = 0
				food:insert(art)
				
			end
			
			if( ctype == 'H' )then
				
				food = _G.engine.buildHitArea('#f1c40f', 64, 64, 'none')
				food.color = '#f1c40f'
				food.food = 'clothes'
				food.value = itemValues['hat']
				
				-- get artwork
				art = buildArtwork('hats')
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
			
			-- choose stencil
			local sletter = order[i]:sub( 3,3 )
			if( sletter ~= '' )then
			
				sletter = sletter:lower()
				local icon = util.addFill(food, 'stencil', 0, 0, 0, 1, 0, 0, 26, 26)
				_G.util.addText(sletter, food, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
				food.letter = sletter
				food.value = food.value + itemValues['stencil'..sletter]
				
				icon.alpha = 0
				food.stencil.alpha = 0
				
				art['stencil-'..sletter].alpha = 1
				
			end

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

--------------------------- OBJECTS:

function evaluateTrash(obj)
	
	local value = 0
	
	if(obj.mode=='clothes')then
			
		-- type
		if(obj.color=='#3498db')then
			
			value = value + itemValues['shirt']
			
		end
		if(obj.color=='#2ecc71')then
			
			value = value + itemValues['jeans']
			
		end
		if(obj.color=='#f1c40f')then
			
			value = value + itemValues['hat']
			
		end
		
		-- stencil
		if(obj.letter)then
			if(obj.letter=='a')then
				value=value+itemValues['stencila']
			end
			if(obj.letter=='b')then
				value=value+itemValues['stencilb']
			end
			if(obj.letter=='c')then
				value=value+itemValues['stencilc']
			end
		end
		
	end
	
	-- half value
	value = math.floor(value * .5)
	
	return value
	
end

--------------------------- EVENTS:

function buildArtwork(food)

	local grp = display.newGroup()
	--grp.x = 512
	--grp.y = 384
	grp.xScale = 1
	grp.yScale = 1

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
	
	if(food=='sketch')then
		
		ulevel = upgrades[ 'sketch' ]
		if( not ulevel )then ulevel = 0 end
				
		_G.util.addImage('graphics/level2/items/sketch-shadow.png', grp, 'shadow', -6, 4, 1, 1, 0, 1)
				
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level2/items/sketch01.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/sketch02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/sketch02.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/sketch03.png', grp, 'full', 0, 0, 1, 1, 0, 0)
		end

		--_G.util.addImage('graphics/level2/items/sketch-shadow.png', grp, 'shadow', -6, 4, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/sketch-a.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='shirt')then
		
		ulevel = upgrades[ 'tops' ]
		if( not ulevel )then ulevel = 0 end
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level2/items/shirt03.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/shirt04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt06.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt05.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/shirt04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt06.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt05.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/shirt07.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt09.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt08.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/shirt_shadow.png', grp, 'shadow', -4, 6, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/shirt_fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/shirt_outline.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		
		local stencil
		stencil = _G.util.addImage('graphics/level2/items/stencil-b.png', grp, 'stencil-b', -2, 3, 1, 1, 0, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-a.png', grp, 'stencil-a', -4, 3, 1, 1, 0, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-c.png', grp, 'stencil-c', -4, 3, 1, 1, 0, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		
		_G.util.addImage('graphics/level2/items/spraycan.png', grp, 'spraycan', 30, 6, 1, 1, 0, 0)
		
	end
	
	if(food=='jeans')then

		ulevel = upgrades[ 'pants' ]
		if( not ulevel )then ulevel = 0 end
			
		_G.util.addImage('graphics/level2/items/pants07.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level2/items/pants02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/pants01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/pants04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/pants03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/pants04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/pants03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/pants06.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/pants05.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/pants_shadow.png', grp, 'shadow', -4, 6, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/pants_fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/pants_outline.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		
		local stencil
		stencil = _G.util.addImage('graphics/level2/items/stencil-b.png', grp, 'stencil-b', -4, 6, .8, .8, 0, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-a.png', grp, 'stencil-a', -4, 3, .75, .75, -1, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-c.png', grp, 'stencil-c', -3, 5, .7, .7, 0, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		
		_G.util.addImage('graphics/level2/items/spraycan.png', grp, 'spraycan', 44, 6, 1, 1, 0, 0)
		
	end
	
	if(food=='hats')then

		ulevel = upgrades[ 'hats' ]
		if( not ulevel )then ulevel = 0 end
			
		_G.util.addImage('graphics/level2/items/hat07.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
								
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level2/items/hat02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/hat01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/hat03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/hat04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/hat03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/hat06.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/hat05.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/hat_shadow.png', grp, 'shadow', -2, 14, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/hat_fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/hat_outline.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		
		local stencil
		stencil = _G.util.addImage('graphics/level2/items/stencil-b.png', grp, 'stencil-b', 1, -6, .8, .8, -4, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-a.png', grp, 'stencil-a', 0, -8, .75, .75, -4, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		stencil = _G.util.addImage('graphics/level2/items/stencil-c.png', grp, 'stencil-c', -2, -9, .75, .75, 2, 1)
		stencil:setFillColor(0,0,0)
		stencil.alpha = 0
		
		_G.util.addImage('graphics/level2/items/spraycan.png', grp, 'spraycan', 46, -10, 1, 1, 0, 0)
		
	end
	
	if(food=='shirt-tap')then

		ulevel = upgrades[ 'tops' ]
		if( not ulevel )then ulevel = 0 end
									
		if( ulevel == 0 )then
			
			_G.util.addImage('graphics/level2/items/shirt-tap02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt-tap01.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
			
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/shirt-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt-tap03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/shirt-tap04.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt-tap03.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/shirt-tap06.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/shirt-tap05.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/shirt-tap_fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/shirt-tap_outline.png', grp, 'outline', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='case')then

		ulevel = upgrades[ 'cases' ]
		if( not ulevel )then ulevel = 0 end
			
		_G.util.addImage('graphics/level2/items/belt04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
								
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level2/items/belt01.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/belt02.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/belt03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/belt03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end

		--_G.util.addImage('graphics/level2/items/case-shadow.png', grp, 'shadow', 6, 4, 1, 1, 0, 1)
		--_G.util.addImage('graphics/level2/items/case.png', grp, 'full', 0, 0, 1, 1, 0, 1)
		
	end
	
	if(food=='mug')then

		ulevel = upgrades[ 'mugs' ]
		if( not ulevel )then ulevel = 0 end
								
		if( ulevel == 0 )then
			_G.util.addImage('graphics/level2/items/mug02.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/mug01.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 1 )then
			_G.util.addImage('graphics/level2/items/mug04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/mug03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 2 )then
			_G.util.addImage('graphics/level2/items/mug04.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/mug03.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		if( ulevel == 3 )then
			_G.util.addImage('graphics/level2/items/mug06.png', grp, 'shadow', 0, 0, 1, 1, 0, 1)
			_G.util.addImage('graphics/level2/items/mug05.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
		end
		
	end
	
	return grp
	
end

function updateArtwork(targ)

	
	
end

function resetCooker()


end

--------------------------- UI:
function setTutorial(num, callback, xPass, yPass,parentPass)
    local info
		if num == 1 then
            info = _G.gui.setTutorial("selectCoffe",{ fY = 40, x= -50, y = 200, group=grp_main, callback = callback })
        end
		if (num==2) then
            info = _G.gui.setTutorial("selectColor",{ fY = 40, x= -70, y = 200, group=grp_main, callback = callback })
        end
        if num == 3 then
            info = _G.gui.setTutorial("selectpaint",{ fY = 40, x= -20, y = 260, group=grp_main, callback = callback })
        end
		if num == 4 then
        	local cList = {_G.engine.runningCust}
	        print(cList[1].x)
	        local xSet = 0
	        if( cList[1].x > 0 )then
                _G.TutorialData.data["dragpaint"].type = "right"
                xSet = cList[1].x - 330
	        else
                _G.TutorialData.data["dragpaint"].type = "left"
                xSet = cList[1].x + 330
	        end
	        info = _G.gui.setTutorial("dragpaint",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
        end
		if num == 5 then
            info = _G.gui.setTutorial("removeCloth",{ fY = 40, x= -20, y = 260, group=grp_main, callback = callback })
        end

        if num == 6 then
            info = _G.gui.setTutorial("selectLogo",{ fY = 40, x= -120, y = 130, group=grp_main, callback = callback })
        end

        if num == 7 then
            info = _G.gui.setTutorial("selectTshirts",{ fY = 40, x= -140, y = 250, group=grp_main, callback = callback })
        end
		if num == 25 then
	        info = _G.gui.setTutorial("wellcomeArtStand4Message",{ fy = 100, y=110, group=grp_main, callback = callback })
	    end

	    if num == 26 then
	    	info = _G.gui.setTutorial("wellcomeArtStand7Message",{ fy = 100, y=110, group=grp_main, callback = callback })
	    end

        if num == 9 then
            info = _G.gui.setTutorial("selectCap",{ fY = 40, x= 100, y = 250, group=grp_main, callback = callback })
        end
		if num == 11 then
            info = _G.gui.setTutorial("selectDrawing",{ fY = 40, x= -100, y = 290, group=grp_main, callback = callback })
        end

		if num == 12 then
            info = _G.gui.setTutorial("dragDrawing",{ fY = 40, x= -230, y = 130, group=grp_main, callback = callback })
        end

        if num == 13 then
            info = _G.gui.setTutorial("selectMug",{ fY = 40, x= 450, y = 250, group=grp_main, callback = callback })
        end

        if num == 15 then
            info = _G.gui.setTutorial("selectBelt",{ fY = 40, x= 350, y = 250, group=grp_main, callback = callback })
        end
		if num == 17 then
	        info = _G.gui.setTutorial("wellcomeArtStandMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
	    end
	    if num == 18 then
	        info = _G.gui.setTutorial("wellcomeArtStandMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
	    end
		if num == 27 then
	        info = _G.gui.setTutorial("wellcomeArtStand11Message",{ fy = 100, y=110, group=grp_main, callback = callback })
	    end
	    if num == 28 then
	        info = _G.gui.setTutorial("waitDrawing",{ fy = 100, x= -230, y = 130, group=grp_main, callback = callback })
	    end
	    if(num==19)then
	        local cList = {_G.engine.runningCust}
	        print(cList[1].x)
	        local xSet = 0
	        if( cList[1].x > 0 )then
                _G.TutorialData.data["artFirstCustomerMessage"].type = "right"
                xSet = cList[1].x - 330
	        else
                _G.TutorialData.data["artFirstCustomerMessage"].type = "left"
                xSet = cList[1].x + 330
	        end
	        info = _G.gui.setTutorial("artFirstCustomerMessage",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
		end
		if num == 21 then
            info = _G.gui.setTutorial("selectpaint2",{ fY = 40, x= -20, y = 260, group=grp_main, callback = callback })
        end
        if num == 24 then
            info = _G.gui.setTutorial("waitPaintReady",{ fY = 40, x= -20, y = 180, group=grp_main, callback = callback })
        end
		if(num==20)then               
	        local cList = {_G.engine.runningCust}
	        print("get Clist x pos ::: ",cList[1].x)
	        local xSet = 0
	        if( cList[1].x > 0 )then
	            _G.TutorialData.data["collectArtStandMoney"].type = "right"
	            xSet = cList[1].x - 280
	        else
	            _G.TutorialData.data["collectArtStandMoney"].type = "left"
	            xSet = cList[1].x + 250
	        end
	        print("xList ::: ",cList[1].x)
	        info = _G.gui.setTutorial("collectArtStandMoney",{ fY = 40, x= xSet, y = 70, group=grp_main, callback = callback })
	        print( "Info :::: " )
	        _G.loadsave.print_r(info)
	    end
	    if(num==22)then
	        local cList = {_G.engine.runningCust}
	        print(cList[1].x)
	        local xSet = 0
	        if( cList[1].x > 0 )then
                _G.TutorialData.data["dragToCustomerLogo"].type = "right"
                xSet = cList[1].x - 330
	        else
                _G.TutorialData.data["dragToCustomerLogo"].type = "left"
                xSet = cList[1].x + 330
	        end
	        info = _G.gui.setTutorial("dragToCustomerLogo",{ fY = 40, x= xSet, y = 20, group=grp_main, callback = callback })
		end

	    if(num==23)then               
	        local cList = {_G.engine.runningCust}
	        print("get Clist x pos ::: ",cList[1].x)
	        local xSet = 0
	        if( cList[1].x > 0 )then
	            _G.TutorialData.data["collectArtStand2Money"].type = "right"
	            xSet = cList[1].x - 280
	        else
	            _G.TutorialData.data["collectArtStand2Money"].type = "left"
	            xSet = cList[1].x + 250
	        end
	        print("xList ::: ",cList[1].x)
	        info = _G.gui.setTutorial("collectArtStand2Money",{ fY = 40, x= xSet, y = 70, group=grp_main, callback = callback })
	        print( "Info :::: " )
	        _G.loadsave.print_r(info)
	    end

        if info ~= nil then
			print( "infoname ::: ",info.tutName )
	    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
	    	print_r(info.passData)
	    end

        return info
        
end
--------------------------- MODULE EVENTS:

