
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local backClosure = nil
local aData = nil

local curBtn = nil

local widget 	= require( "widget" )
local xml 		= require( "info.xml" ).newParser()

--------------------------- INIT

function buildModule(btn)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 40, 1)
		
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(050, showMenu)
	
	-- set module
	_G.curModule = _G.achievements
	
	-- check btn
	if( btn )then curBtn=btn end
	
end

function buildMenu()
	
	-- bg
	_G.util.addImage('graphics/menus/achievements/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ACHIEVEMENTS ', grp_main, 'txt', 'bangers', 0, -226, 60, 1, .86, 0)
	
	-- build list
	local list = _G.util.addGroup(grp_main, 'list', 0, 0, 1)
	local lastY = 0
	local firstOn = nil
	for i=1, #aData do
	
		local item = _G.util.addGroup(list, 'item'..i, 0, 0, 1)
		
		-- base
		_G.util.addImage('graphics/menus/achievements/image.png', item, 'image', 2, 0, 1, 1, 0, 1)
		item.image.anchorX = 0
		item.image.anchorY = 0
		
		_G.util.addImage('graphics/menus/achievements/entry.png', item, 'entry', 152, 0, 1, 1, 0, 1)
		item.entry.anchorX = 0
		item.entry.anchorY = 0
		
		_G.util.addImage('graphics/menus/achievements/payoff.png', item, 'payoff', 560, 0, 1, 1, 0, 1)
		item.payoff.anchorX = 0
		item.payoff.anchorY = 0
		
		-- rewards
		_G.util.addText(' REWARDS: ', item, 'txt', 'bangers', 642, 16, 18, 1, .8, 0)
		_G.util.addText(' XP ', item, 'txt', 'bangers', 628, 40, 40, 1, .8, 0)
		_G.util.addImage('graphics/menus/achievements/cash.png', item, 'icon', 770, 40, 1, 1, 0, 1)
		
		-- fields
		_G.util.addText(aData[i].xp, item, 'xp', 'bangers', 660, 40, 36, 1, 1, 1)
		item.xp.anchorX = 0
		_G.util.addText( _G.util.formatEndScoring( aData[i].cash ), item, 'cash', 'bangers', 804, 40, 36, 1, 1, 1)
		item.cash.anchorX = 0
		
		-- bar
		local f = _G.util.addFill(item, 'filler', 75/255, 134/255, 178/255, 1,  636, 96, 210, 12)
		f.anchorX = 0
		local f = _G.util.addFill(item, 'bar', 57/255, 181/255, 74/255, 1,  636, 96, 210, 12)
		f.anchorX = 0
		f.xScale = .0001
		
		-- set value
		local curValue = _G.achievements.getValueByNum( i )
		_G.util.addText( i, item, 'txt_num', 'bangers', 180, 30, 1, 0, 0, 0)
		_G.util.addText( curValue .. '/' .. aData[i].limit, item, 'txt_value', 'bangers', 740, 78, 18, 1, .8, 0)
		
		local newS = tonumber( curValue )/tonumber(aData[i].limit)
		if(newS<=0)then newS=.0001 end
		if(newS>1)then newS=1 end
		f.xScale = newS

		-- button
		local btn = _G.util.addGroup(item, 'cta', 740, 89, 1)
		_G.util.addImage('graphics/menus/achievements/button.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText( ' COLLECT ', btn, 'txt_b', 'bangers', -2, -2, 20, 0, 0, 0)
		_G.util.addText( ' COLLECT ', btn, 'txt_w', 'bangers', 0, -4, 20, 1, 1, 1)
		
		btn.item = item
		btn.num = i
		btn.xp = tonumber(aData[i].xp)
		btn.cash = tonumber(aData[i].cash)
		btn:addEventListener('tap', onCollectTap)
		
		-- medal
		local mNum = 0
		if( aData[i].medal == 'Bronze' )then mNum=1 end
		if( aData[i].medal == 'Silver' )then mNum=2 end
		if( aData[i].medal == 'Gold' )then mNum=3 end
		
		_G.util.addImage('graphics/menus/achievements/medal0' .. mNum .. '.png', item, 'medal', 58, 54, 1, 1, 0, 1)
		
		-- add info
		_G.util.addTextMulti(aData[i].info, item, 'info', 'bangers', 200, 46, 32,  280, 'left', 1, 1, 1)
		item.info.anchorX = 0
		item.info.anchorY = 0
		item.info.y = item.info.y - (item.info.height*.5) + 10
		
		-- position
		item.x = 8
		item.y = (i-1) * 120
		item.y = item.y + 30
		lastY = item.y
		
		-- check status
		if( tonumber(curValue) >= tonumber(aData[i].limit) )then
			
			item.cta.alpha = 1
			item.txt_value.alpha = 0
			item.filler.alpha = 0
			item.bar.alpha = 0
			
			-- check badge
			local hasBadge = false			
			for j=1, #_G.userdata.badges do
			
				if( i == _G.userdata.badges[j] )then
					hasBadge = true
				end
				
			end
			
			if( hasBadge )then
			
				item.cta.txt_b.text = 'EARNED'
				item.cta.txt_w.text = 'EARNED'
				item.cta.bg:setFillColor(.5,.5,.5)
				item.cta.alpha = .5
				
			else
			
				if( firstOn==nil )then
				
					print('here we go:')
					firstOn = item
					
				end
				
			end
			
		else
			
			item.cta.alpha = 0
				
		end
		
	end
	
	-- add shim
	_G.util.addImage('graphics/menus/levelselect/shim.png', list, 'shim', 200, lastY+140, 1, 1, 0, .01)
	
	-- scrollview
	local sv = widget.newScrollView(
	    {
	        top = -166,
	        left = -460,
	        width = 940,
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
	
	-- if first on
	if( firstOn ~= nil )then
		
		print("move list: " .. firstOn.y)
		sv:scrollToPosition({y=(firstOn.y*-1)+20, time=1})
		
	end
	
	-- shadows
	_G.util.addImage('graphics/menus/achievements/shadow.png', grp_main, 'shadow', 8, -151, 1, -1, 0, 1)
	_G.util.addImage('graphics/menus/achievements/shadow.png', grp_main, 'shadow', 8, 154, 1, 1, 0, 1)
	
	-- buttons
	local btn = _G.util.addImage('graphics/menus/buttons/btn.png', grp_main, 'ok', 0, 0, 1, 1, 0, 1)
	btn.x = 0
	btn.y = 220
	btn:addEventListener('touch', onBtnTouch)
	_G.util.addText(' OK ', grp_main, 'txt', 'bangers', 12, 220-5, 36, 1, .86, 0)

	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- DATA:

function loadDataSet()

	local dataSet = xml:loadFile( "info/xml/achievements.xml" )
	aData = {}
	
	for i=1, #dataSet.child do
	
		local aArr = {}
		local a = dataSet.child[i]
		
		-- word
		aArr.medal = a.child[1].value
		aArr.info = a.child[2].value
		aArr.xp = a.child[3].value
		aArr.cash = a.child[4].value
		aArr.limit = a.child[5].value

		aData[#aData+1] = aArr
		
	end
	
end

function updateAchievement(mode, amt)
		
	local stats = _G.userdata.stats
	local newstat = 0
	
	if( mode == 'customersServed' )then
	
		stats.customersServed = stats.customersServed+1
		newstat = stats.customerStreak+1
		if( stats.customerStreak < newstat )then
			stats.customerStreak = newstat
		end
		
	end
	
	if( mode == 'celebsServed' )then
	
		stats.celebsServed = stats.celebsServed+1
		
	end
	
	if( mode == 'customersLost' )then
	
		stats.customersLost = stats.customersLost+1
		stats.customerStreak = 0
		
	end
		
	if( mode == 'trashStreak' )then
	
		newstat = stats.trashStreak+1
		if( stats.trashStreak < newstat )then
			stats.trashStreak = newstat
		end
		
	end
		
	if( mode == 'tips' )then
	
		stats.tips = stats.tips + amt
		
	end
	
	if( mode == 'burned' )then
	
		stats.burned = stats.burned + amt
		
	end
	
	if( mode == 'cashEarned' )then
	
		stats.cashEarned = stats.cashEarned + amt
		
		
	end
	
	if( mode == 'cashOnHand' )then
	
		if( stats.cashOnHand < amt )then
			stats.cashOnHand = amt
		end
		
	end
	
	if( mode == 'cashSpent' )then
	
		stats.cashSpent = stats.cashSpent + amt
		
	end
	
	if( mode == 'gemsSpent' )then
	
		stats.gemsSpent = stats.gemsSpent + amt
		
	end	
	
	if( mode == 'ceeloBets' )then
	
		stats.ceeloBets = stats.ceeloBets + amt
		
	end
	
	if( mode == 'ceeloWins' )then
	
		stats.ceeloWins = stats.ceeloWins + amt
		
	end		
	
	if( mode == 'dayStreak' )then
	
		newstat = stats.dayStreak+1
		if( stats.dayStreak < newstat )then
			stats.dayStreak = newstat
		end
		
		if( amt==0 )then
			
			stats.dayStreak = 0
			
		end
		
	end		
			
end

function getValueByNum(num)

	local newval = 0
	local val = 'no value'

	-- customers served
	if( num==1 or num==2 or num==3 )then
		val = _G.userdata.stats.customersServed
	end
	
	-- customer streak
	if( num==4 or num==5 or num==6 )then
		val = _G.userdata.stats.customerStreak
	end
	
	-- trash streak
	if( num==7 or num==8 or num==9 )then
		val = _G.userdata.stats.trashStreak
	end
	
	-- total tips
	if( num==10 or num==11 or num==12 )then
		val = _G.userdata.stats.tips
	end
	
	-- 3 star count
	if( num==13 or num==14 or num==15 )then
		
		for i=1, 5 do
		
			for j=1, 30 do
			
				if( userdata.leveldata[i].levelinfo[j].stars == 3 )then
					
					newval = newval + 1
					
				end
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-levels: food cart
	if( num==16 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[1].levelinfo[i].stars >= 1 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-levels: clothing store
	if( num==17 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[2].levelinfo[i].stars >= 1 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-levels: studio
	if( num==18 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[3].levelinfo[i].stars >= 1 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-levels: fergs apparel
	if( num==19 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[4].levelinfo[i].stars >= 1 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-levels: restaurant
	if( num==20 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[5].levelinfo[i].stars >= 1 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- cash on hand
	if( num==21 or num==22 or num==23 )then
		val = _G.userdata.stats.cashOnHand
	end
	
	-- day streak
	if( num==24 or num==25 or num==26 )then
		val = _G.userdata.stats.dayStreak
	end
	
	-- cash spent
	if( num==27 or num==28 or num==29 )then
		val = _G.userdata.stats.cashSpent
	end
	
	-- gems spent
	if( num==30 or num==31 or num==32 )then
		val = _G.userdata.stats.gemsSpent
	end
	
	-- gems spent
	if( num==33 or num==34 or num==35 )then
		val = _G.userdata.stats.burned
	end
	
	-- customers lost
	if( num==36 or num==37 or num==38 )then
		val = _G.userdata.stats.customersLost
	end
	
	-- celebs served
	if( num==39 or num==40 or num==41 )then
		val = _G.userdata.stats.celebsServed
	end
	
	-- locations unlocked
	if( num==42 or num==43 or num==44 )then
		
		for i=1, 5 do
		
			if( _G.userdata.leveldata[i].stats.locked == false )then
			
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- xp level
	if( num==45 or num==46 or num==47 )then
		
		val = _G.userdata.level
		
	end
	
	-- all-stars: food cart
	if( num==48 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[1].levelinfo[i].stars == 3 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-stars: art stand
	if( num==49 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[2].levelinfo[i].stars == 3 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-stars: studio
	if( num==50 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[3].levelinfo[i].stars == 3 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-stars: fergs apparrel
	if( num==51 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[4].levelinfo[i].stars == 3 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- all-stars: restaurant
	if( num==52 )then
		
		for i=1, 30 do
		
			if( userdata.leveldata[5].levelinfo[i].stars == 3 )then
				
				newval = newval + 1
				
			end
			
		end
		
		val = newval
		
	end
	
	-- ceelo bets
	if( num==53 or num==54 or num==55 )then
		
		val = _G.userdata.stats.ceeloBets
		
	end
	
	-- ceelo wins
	if( num==56 or num==57 )then
		
		val = _G.userdata.stats.ceeloWins
		
	end
	
	-- fully upgraded locations
	if( num==58 or num==59 or num==60 )then
		
		-- pull all 5 locations data
		for i=1, 5 do
		
			local path = "info.levelData.level0" .. i .. ".levelInfo"
			local levelClass = require( path )
			local levelInfo = levelClass.getData()
			local order = levelInfo.upgrades['order']
			local upgrades = _G.userdata.leveldata[ i ].upgrades
			local ulevel = 0
			local maxedOut = true
			
			--print('*************')
			--print(" LEVEL: " .. i )
			--print('*************')
			
			for j=1, #order do
			
				if( upgrades[ order[j] ] )then
				
					ulevel = upgrades[ order[j] ]
					--print( order[j] .. ' : ' .. ulevel )
					if( ulevel ~= 3 )then
					
						maxedOut = false
						
					end
					
				else
					
					--print( order[j] .. ' : ' .. 'none' )
					maxedOut = false
					
				end
				
			end
			
			-- if maxed, add to val
			if( maxedOut )then
			
				newval = newval + 1
				
			end
			
		end
		
		-- return
		val = newval
		
	end
	
	return val
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='ok')then
		
		hideMenu()
		
	end
	
end

function onCollectTap(e)

	local btn = e.target
	
	-- update values
	_G.userdata.badges[ #_G.userdata.badges+1 ] = e.target.num
	_G.gui.setCash( e.target.cash )
	_G.gui.setXP( e.target.xp )
	
	-- update button
	e.target.txt_b.text = 'EARNED'
	e.target.txt_w.text = 'EARNED'
	e.target.bg:setFillColor(.5,.5,.5)
	e.target.alpha = .5
	
	-- update gui
	setCounter( curBtn )
	
end

--------------------------- COUNTER:

function addCounter(btn)

	local grp = _G.util.addGroup(btn, 'counter', 0, 0, 1)

	local c = display.newCircle( 0, 0, 16 )
	c:setFillColor( 1,.86,0,1 )
	c.strokeWidth = 2
	c:setStrokeColor( 1, 1, 1 )
	grp:insert(c)
	
	_G.util.addText(' ' .. 1 .. ' ', grp, 'txt', 'bangers', 0, -3, 20, 0, 0, 0)
	
	grp.x = 60
	grp.y = -20
	
	setCounter(btn)
	
end

function setCounter(btn)

	local openBadges = 0

	for i=1, #aData do
	
		local curValue = _G.achievements.getValueByNum( i )
		
		if( tonumber(curValue) >= tonumber(aData[i].limit) )then
			
			local hasBadge = false
			for j=1, #_G.userdata.badges do
			
				if( i==_G.userdata.badges[j] )then
					hasBadge = true
				end
				
			end
			
			if( hasBadge==false )then
			
				openBadges=openBadges+1
				
			end
			
		end
		
	end
	
	-- set counter
	btn.counter.txt.text = openBadges
	if( openBadges==0 )then
		btn.counter.alpha = 0
	end
	
end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
end

function hideMenu()
	_G.TutorialData.displaying = false
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	if( backClosure )then
		
		timer.performWithDelay(500, backClosure, 1)
		backClosure = nil
		
	else
	
		local myclosure = function() return _G.levelselect.buildModule() end
		timer.performWithDelay(500, myclosure, 1)
		
	end
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function setBackClosure(closure)

	backClosure = closure
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

