
module(..., package.seeall)

-------------------------- CONSTANTS

local CUST_TIME_MOD = 20
local ROLL_SPAN = 30
local ROLL_DELAY = 20
local callBack
local tutTimer
local tutTrans
-------------------------- VARIABLES
local main
local stars = {150,300,400}
local levelSteps = {0,25,150,350,575,800,1000,1250,1550,1900,2300,2750,3250,3800,4400,5050,
					5750,6500,7300,8150,9050,10000,11000,12100,13300,14600,16000,17500,19100,20800,22600}

--------------------------- INIT

function buildModule(grp_main, mode)
	
	main = grp_main
	
	print('build gui: ' .. mode)
		
	-- setup gui by mode
	if(mode == 'engine')then
		
		-- add overlay
		_G.util.addFill(grp_main, 'black', 0, 0, 0, .7,  0, 0, 1400, 768)
		grp_main.black:addEventListener('touch', onBlockTouch)
		
		-- add gui
		local gui = util.addGroup(grp_main, 'gui', -6, 0, 1)
	
		-- exit button
		local btn = _G.util.addGroup(gui, 'exit', 0, 0, 1)
		_G.util.addImage('graphics/gui/btn_exit.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' MENU ', btn, 'txt', 'bangers', 10, -8, 26, 1, 218/255, 0)		
		btn.x = -390
		btn.y = -330
		btn:addEventListener('touch', _G.engine.onExitTouch)
	
		-- customers
		local grp = _G.util.addGroup(gui, 'custCount', 0, 0, 1)
		_G.util.addFill(grp, 'fill', .36, .36, .36, 1, -33, 10, 80, 10)
		grp.fill.anchorX = 0
		_G.util.addFill(grp, 'bar', 240/255, 90/255, 41/255, 1, -33, 10, 80, 10)
		grp.bar.anchorX = 0
		_G.util.addImage('graphics/gui/meter_customers.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(16, grp, 'txt', 'bangers', -10, -10, 26, 1, 218/255, 0)		
		grp.x = -260
		grp.y = -329
		grp_main.custCount = grp
		grp.txt.text = ''
	
		-- revenue
		local grp = _G.util.addGroup(gui, 'revenue', 0, 0, 1)
		_G.util.addFill(grp, 'fill', .36, .36, .36, 1, -110, -3, 264, 26)
		grp.fill.anchorX = 0
		_G.util.addFill(grp, 'bar', 240/255, 90/255, 41/255, 1, -110, -3, 264, 26)
		grp.bar.anchorX = 0
		grp.bar.xScale = .0001
		_G.util.addImage('graphics/gui/meter_revenue.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText('0', grp, 'txtb', 'bangers', -98-2, -6+2, 20, 0, 0, 0)	
		_G.util.addText('0', grp, 'txt', 'bangers', -98, -6, 20, 1, 218/255, 0)	
		grp.txt.anchorX = 0	
		grp.txtb.anchorX = 0	
		grp.x = 4
		grp.y = -329
		grp.total = 0
		grp_main.revenue = grp
		
		-- stars
		local x1 = -102 + ( (stars[1]/stars[3]) * 260 )
		local x2 = -102 + ( (stars[2]/stars[3]) * 260 )
		local x3 = -102 + ( (stars[3]/stars[3]) * 260 )
		
		_G.util.addImage('graphics/gui/star.png', grp, 'star1', x1, -3, 1, 1, 0, 0)
		_G.util.addImage('graphics/gui/star.png', grp, 'star2', x2, -3, 1, 1, 0, 0)
		_G.util.addImage('graphics/gui/star.png', grp, 'star3', x3, -3, 1, 1, 0, 0)
	
		-- xp
		local grp = _G.util.addGroup(gui, 'xp', 0, 0, 1)
		_G.util.addFill(grp, 'fill', .36, .36, .36, 1, -60, -10, 150, 26)
		grp.fill.anchorX = 0
		_G.util.addFill(grp, 'bar', 240/255, 90/255, 41/255, 1, -60, -10, 150, 26)
		grp.bar.anchorX = 0
		grp.bar.xScale = .0001
		_G.util.addImage('graphics/gui/meter_xp.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText('XP', grp, 'txt', 'bangers', -74, -17, 26, 1, 218/255, 0)	
		_G.util.addText('000000/000000', grp, 'txt', 'bangers', 12, -14, 20, 1, 1, 1)
		_G.util.addText(_G.userdata.level, grp, 'level', 'bangers', 94, 6, 20, 1, 1, 1)
		grp.x = 320
		grp.y = -320
		grp_main.xp = grp
		
		-- level goal
		
		
		-- for purchasing
		
		-- money button
		local btn = _G.util.addGroup(gui, 'money', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/cash.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 218/255, 0)	
		btn.txt.anchorX = 0	
		btn.x = -200
		btn.y = -332
		btn:addEventListener('touch', onIngameShopTouch)
	
		-- gems button
		local btn = _G.util.addGroup(gui, 'gems', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/gems.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 1, 1)	
		btn.txt.anchorX = 0	
		btn.x = 50
		btn.y = -332
		btn:addEventListener('touch', onIngameShopTouch)
		
		-- set for purchasing
		gui.revenue.alpha = 0
		gui.custCount.alpha = 0
		
	end
	
	if(mode == 'ceelo')then
	
		-- add overlay
		_G.util.addFill(grp_main, 'black', 0, 0, 0, .7,  0, 0, 1400, 768)
		grp_main.black:addEventListener('touch', onBlockTouch)
		grp_main.black.alpha = 0
		
		-- add gui
		local gui = util.addGroup(grp_main, 'gui', 0, 0, 1)	
	
		-- exit button
		local btn = _G.util.addGroup(gui, 'exit', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/menu.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' EXIT ', btn, 'txt', 'bangers', 10, -5, 26, 1, 218/255, 0)		
		btn.x = -390
		btn.y = -340
		btn.endY = btn.y
		btn:addEventListener('touch', _G.ceelo.onExitTouch)
	
		-- money button
		local btn = _G.util.addGroup(gui, 'money', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/cash.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 218/255, 0)	
		btn.txt.anchorX = 0	
		btn.x = -210
		btn.y = -340
		btn.endY = btn.y
		btn:addEventListener('touch', onIngameShopTouch)
	
		-- gems button
		local btn = _G.util.addGroup(gui, 'gems', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/gems.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 1, 1)	
		btn.txt.anchorX = 0	
		btn.x = 36
		btn.y = -340
		btn.endY = btn.y
		btn:addEventListener('touch', onIngameShopTouch)
	
		-- xp meter
		local btn = _G.util.addGroup(gui, 'xp', 0, 0, 1)
		
		_G.util.addFill(btn, 'fill', .36, .36, .36, 1, -60, -10, 150, 26)
		btn.fill.anchorX = 0
		_G.util.addFill(btn, 'bar', 240/255, 90/255, 41/255, 1, -60, -10, 150, 26)
		btn.bar.anchorX = 0
		btn.bar.xScale = .0001
		
		_G.util.addImage('graphics/gui/map/xp.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText('XP', btn, 't', 'bangers', -74, -15, 26, 1, 218/255, 0)	
		_G.util.addText('000000/000000', btn, 'txt', 'bangers', 12, -12, 20, 1, 1, 1)
		_G.util.addText('000', btn, 'level', 'bangers', 98, 7, 20, 0, 0, 0)
		btn.x = 290
		btn.y = -331
		btn.endY = btn.y
		
		-- adjust
		local xMod = 20
		gui.exit.x = gui.exit.x + xMod
		gui.money.x = gui.money.x + xMod
		gui.gems.x = gui.gems.x + xMod
		gui.xp.x = gui.xp.x + xMod
		
	end
	
	if(mode == 'title')then
	
		-- add gui
		local gui = util.addGroup(grp_main, 'gui', 0, 0, 1)
		
		------------------------
		-- GRAPHICS ---
		------------------------
		
		-- header
		local header = util.addGroup(gui, 'header', 0, 0, 1)
		for i=1, 2 do
			local h = _G.util.addImage('graphics/map/gui/header_0' .. i .. '.png', header, 'h', 0, 0, 1, 1, 0, 1)
			h.anchorX = 0
			h.anchorY = 0
			h.x = 683 * (i-1)
		end
		header.x = header.width * -.5
		header.y = -384
		header.endY = header.y
		header.y = header.y - 300

		-- footer
		local footer = util.addGroup(gui, 'footer', 0, 0, 1)
		for i=1, 2 do
			local h = _G.util.addImage('graphics/map/gui/footer_0' .. i .. '.png', footer, 'h', 0, 0, 1, 1, 0, 1)
			h.anchorX = 0
			h.anchorY = 1
			h.x = 683 * (i-1)
		end
		footer.x = footer.width * -.5
		footer.y = 384
		footer.endY = footer.y
		footer.y = footer.y + 300
		
		------------------------
		-- FOOTER ELEMENTS ---
		------------------------
		
		-- FB button
		local btn = _G.util.addGroup(gui, 'tags', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/fb.png', btn, 'bg', 0, 0, 1, 1, 0, 1)	
		btn.x = -436-6
		btn.y = 338
		btn:addEventListener('touch', onFooterTouch)
		btn.endY = btn.y
		btn.y = btn.y + 300
		btn.id = 'facebook'
		
		-- networth
		local grp = _G.util.addGroup(gui, 'networth', 0, 0, 1)

		_G.util.addImage('graphics/gui/map/networth.png', grp, 'bg', 0, -24, 1, 1, 0, 1)
		_G.util.addText('NET WORTH', grp, 'txt', 'bangers',  -70, -3, 24, 1, 218/255, 0)	
		grp.txt.anchorX = 0		
		
		_G.util.addText('$000,000,000', grp, 'cash', 'bangers',   100, -3, 20, 1, 1, 1)
			
		grp.x = -180-8
		grp.y = 340
		grp_main.networth = grp
		
		grp.endY = grp.y
		grp.y = grp.y + 300
		
		_G.gui.displayNetworth()
		
		-- standings button
		local btn = _G.util.addGroup(gui, 'standings', 0, 0, 1)
		_G.util.addImage('graphics/map/gui/standings.png', btn, 'bg', 0, 0, 1, 1, 0, 1)	
		_G.util.addImage('graphics/map/gui/over.png', btn, 'over', 0, 0, 1, 1, 0, 0)	
		btn.x = 110-6
		btn.y = 336
		btn:addEventListener('touch', onFooterTouch)
		btn.endY = btn.y
		btn.y = btn.y + 300
		
		local btn = _G.util.addGroup(gui, 'achievements', 0, 0, 1)
		_G.util.addImage('graphics/map/gui/achievements.png', btn, 'bg', 0, 0, 1, 1, 0, 1)	
		_G.util.addImage('graphics/map/gui/over.png', btn, 'over', 0, 0, 1, 1, 0, 0)	
		btn.x = 150+116-6
		btn.y = 336
		btn:addEventListener('touch', onFooterTouch)
		btn.endY = btn.y
		btn.y = btn.y + 300
		
		_G.achievements.addCounter( btn )
		
		local btn = _G.util.addGroup(gui, 'settings', 0, 0, 1)
		_G.util.addImage('graphics/map/gui/settings.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/map/gui/over.png', btn, 'over', 0, 0, 1, 1, 0, 0)		
		btn.x = 300+120-6
		btn.y = 336
		btn:addEventListener('touch', onFooterTouch)
		btn.endY = btn.y
		btn.y = btn.y + 300
		
		------------------------
		-- OVERLAY ---
		------------------------
		
		-- add overlay
		_G.util.addFill(gui, 'black', 0, 0, 0, .7,  0, 0, 1400, 768)
		gui.black:addEventListener('touch', onBlockTouch)
		gui.black:addEventListener('tap', onBlockTap)
		gui.black.alpha = 0
	
		------------------------
		-- HEADER ELEMETNS ---
		------------------------
		
		-- exit button
		local btn = _G.util.addGroup(gui, 'exit', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/menu.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText('SHOP', btn, 'txt', 'bangers', 10, -5, 26, 1, 218/255, 0)		
		btn.x = -390
		btn.y = -340
		btn.endY = btn.y
		btn.y = btn.y - 300
		btn:addEventListener('touch', onShopTouch)
	
		-- money button
		local btn = _G.util.addGroup(gui, 'money', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/cash.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 218/255, 0)	
		btn.txt.anchorX = 0	
		btn.x = -210
		btn.y = -340
		btn.endY = btn.y
		btn.y = btn.y - 300
		btn:addEventListener('touch', onShopTouch)
	
		-- gems button
		local btn = _G.util.addGroup(gui, 'gems', 0, 0, 1)
		_G.util.addImage('graphics/gui/map/money.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/gui/map/gems.png', btn, 'icon', -30, 0, 1, 1, 0, 1)
		_G.util.addText('0', btn, 'txt', 'bangers', -2, -2, 22, 1, 1, 1)	
		btn.txt.anchorX = 0	
		btn.x = 36
		btn.y = -340
		btn.endY = btn.y
		btn.y = btn.y - 300
		btn:addEventListener('touch', onShopTouch)
	
		-- xp meter
		local btn = _G.util.addGroup(gui, 'xp', 0, 0, 1)
		
		_G.util.addFill(btn, 'fill', .36, .36, .36, 1, -60, -10, 150, 26)
		btn.fill.anchorX = 0
		_G.util.addFill(btn, 'bar', 240/255, 90/255, 41/255, 1, -60, -10, 150, 26)
		btn.bar.anchorX = 0
		btn.bar.xScale = .0001
		
		_G.util.addImage('graphics/gui/map/xp.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText('XP', btn, 'txt_t', 'bangers', -74, -15, 26, 1, 218/255, 0)	
		_G.util.addText('000000/000000', btn, 'txt', 'bangers', 12, -12, 20, 1, 1, 1)
		_G.util.addText(_G.userdata.level, btn, 'level', 'bangers', 98, 7, 20, 0, 0, 0)
		btn.x = 290
		btn.y = -331
		btn.endY = btn.y
		btn.y = btn.y - 300
	
		-- add fader
		_G.util.addFill(grp_main, 'black', 0, 0, 0, 1, 0, 0, 2732, 768)
		
	end
	
	-- init
	setCash(0)
	setGems(0)
	setXP(0)
	
	CUST_TIME_MOD = 20
	
end

function buildGoal()

	local goal = _G.util.addGroup(main, 'goal', 0, 0, 1)
	goal.y = 1000
	goal.rotation = -180
	
	local grp = _G.util.addGroup(goal, 'grp', 0, -1000, 1)
	_G.util.addImage('graphics/gui/goal.png', grp, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' LEVEL ' .. _G.curStageNum .. ' ', grp, 'txt', 'bangers', 0, -150, 60, 1, .8, 0)	
	_G.util.addText('  YOUR GOAL: ', grp, 'txt', 'bangers', 0, -32, 22, 1, 1, 1)
	_G.util.addText(' $' .. _G.util.formatEndScoring(stars[1]) .. ' ', grp, 'txt', 'bangers', 0, 0, 42, 1, .8, 0)
	
end

--------------------------- GET/SET:

function setLevelData(levelData)

	-- set stars
	stars = levelData.stars
	for i=1, 3 do
	
		local s = main.gui.revenue['star'..i]
		local sx = -102 + ( (stars[i]/stars[3]) * 260 )
		s.alpha = 1
		s.x = sx
		
	end
	
	-- set customer count
	main.gui.custCount.txt.text = #levelData.orders
	
	-- set level timer
	main.gui.custCount.maxTime = (#levelData.orders) * (CUST_TIME_MOD) * 60
	main.gui.custCount.curTime = main.gui.custCount.maxTime
	
end

function getStarCount()

	local sCount = 0
	if( main.revenue.star1.isOn )then sCount = 1 end
	if( main.revenue.star2.isOn )then sCount = 2 end
	if( main.revenue.star3.isOn )then sCount = 3 end
	return sCount

end
 
function setGui(mode)

	if(mode=='engine')then
	
		main.gui.revenue.alpha = 1
		main.gui.custCount.alpha = 1
		main.gui.money.alpha = 0
		main.gui.gems.alpha = 0
		
	end
	
end

function setCash(amt)
	
	-- update value
	local oldval = _G.userdata.cash + 0
	_G.userdata.cash = oldval + amt
	
	-- update networth
	if( amt>0 )then
	
		_G.gui.setNetworth( amt )
		
	end
	
	-- update achievements
	if( amt>0 )then
	
		_G.achievements.updateAchievement('cashOnHand', _G.userdata.cash)
		
	else
	
		_G.achievements.updateAchievement('cashSpent', amt*-1)
		
	end
	
	-- save data
	_G.profile.saveUserData()
	
	-- set to roll
	local newval = _G.userdata.cash + 0
	local diff = newval - oldval
	local step = math.floor(diff/ROLL_SPAN)
	if(step==0)then step=1 end
	local myclosure = nil
	local delayer = 0
	
	-- start rollers
	for i=1, ROLL_SPAN do
	
		local upval = 0
		upval = oldval + (i*step)
		
		if( step < 0 )then
			
			if(upval < newval)then upval=newval end
			
		else
		
			if(upval > newval)then upval=newval end
			
		end
		
		if(i==ROLL_SPAN)then upval=newval end
		
		myclosure = function() return onFieldUpdate( main.gui.money.txt, upval ) end
		timer.performWithDelay(delayer, myclosure, 1)
		
		delayer = delayer + ROLL_DELAY
		
	end
	
end

function setGems(amt)

	local oldval = _G.userdata.gems + 0
	_G.userdata.gems = _G.userdata.gems + amt
	_G.profile.saveUserData()
	
	-- update achievements
	if( amt>0 )then
	
		
		
	else
	
		_G.achievements.updateAchievement('gemsSpent', amt*-1)
		
	end
	
	-- set to roll
	local newval = _G.userdata.gems + 0
	local diff = newval - oldval
	local step = math.floor(diff/ROLL_SPAN)
	if(step==0)then step=1 end
	local myclosure = nil
	local delayer = 0
	
	-- start rollers
	for i=1, ROLL_SPAN do
	
		local upval = 0
		upval = oldval + (i*step)
		
		if( step < 0 )then
			
			if(upval < newval)then upval=newval end
			
		else
		
			if(upval > newval)then upval=newval end
			
		end
		
		if(i==ROLL_SPAN)then upval=newval end
		
		myclosure = function() return onFieldUpdate( main.gui.gems.txt, upval ) end
		timer.performWithDelay(delayer, myclosure, 1)
		
		delayer = delayer + ROLL_DELAY
		
	end
	
end

function setXP(amt)

	local oldval = _G.userdata.xp + 0
	_G.userdata.xp = _G.userdata.xp + amt
	_G.profile.saveUserData()
	
	-- set to roll
	local newval = _G.userdata.xp + 0
	local diff = newval - oldval
	local step = math.floor(diff/ROLL_SPAN)
	if(step==0)then step=1 end
	local myclosure = nil
	local delayer = 0
	
	-- start rollers
	for i=1, ROLL_SPAN do
	
		local upval = 0
		upval = oldval + (i*step)
		
		if( step < 0 )then
			
			if(upval < newval)then upval=newval end
			
		else
		
			if(upval > newval)then upval=newval end
			
		end
		
		if(i==ROLL_SPAN)then upval=newval end
		
		myclosure = function() return onFieldUpdate( main.gui.xp.txt, upval ) end
		timer.performWithDelay(delayer, myclosure, 1)
		
		delayer = delayer + ROLL_DELAY
		
	end
	
end

function setNetworth(amt)

	local oldval = _G.userdata.networth + 0
	_G.userdata.networth = oldval + amt

end

function displayNetworth()

	if( main.gui.networth )then
		
		local val = _G.userdata.networth
		local valc = _G.util.formatEndScoring( val )
		
		if( val < 1000000000 )then
		
			local maxc = '000,000,000'
			local len = string.len( valc )
			local maxlen = string.len( maxc )
			local submax = string.sub( maxc, 1, maxlen-len )
			local finalc = submax .. valc
			main.gui.networth.cash.text = ' $' .. finalc .. ' '
			
		end
		
	end
	
end

function setTimer()

	if(_G.TutorialData.displaying)then return end

	if(main.gui.custCount.curTime==0)then
		
		main.gui.custCount.curTime = -1
		_G.engine.stopAllCustomers()
		return
		
	end

	main.gui.custCount.curTime = main.gui.custCount.curTime-1
	local per = main.gui.custCount.curTime/main.gui.custCount.maxTime
	if(per <= 0)then
		per=.0001
	end
	
	main.gui.custCount.bar.xScale = per
		
end

function getTimer()
	
	return main.gui.custCount.curTime
	
end

function setUpgradableVars(vars)

	CUST_TIME_MOD = CUST_TIME_MOD+vars[2]
	
end

--------------------------- SHOW/HIDE:

function showOverlay()

	transition.to( main.black, {time=400, alpha=1, transition=easing.inQuad})
	
end

function hideOverlay()

	transition.to( main.black, {time=400, alpha=0, transition=easing.outQuad})
	
end

function showGoal()

	local myclosure = function() return _G.mixer.playSFX('goal') end
	timer.performWithDelay(0500, myclosure, 1)

	_G.gui.setGui('engine')
	_G.gui.buildGoal()
	
	transition.to( main.goal, {delay=0500, time=500, rotation=0, transition=easing.outBack})
	transition.to( main.goal, {delay=3500, time=500, rotation=180, transition=easing.inBack})
	
	local myclosure = function() return _G.engine.startLevel()end
	timer.performWithDelay(3700, myclosure, 1)
	
end

function showTransOverlay()

	transition.to( main.gui.black, {time=400, alpha=1, transition=easing.inQuad})
	
end

function hideTransOverlay()

	transition.to( main.gui.black, {time=400, alpha=0, transition=easing.outQuad})
	
end

--------------------------- ROLLERS:

function onFieldUpdate(txt, amt)
	
	if(not txt)then return end
	if(not txt.parent)then return end

	--print('update field to: ' .. amt)
	txt.text = _G.util.formatEndScoring(amt)
	
	if( txt.parent.id == 'xp' )then
	
		-- get next level value
		local max
		if( (_G.userdata.level+1) > #levelSteps )then
			max = levelSteps[ #levelSteps ] + ( 10000 * ( #levelSteps-_G.userdata.level+1 ) )
		else
			max = levelSteps[ _G.userdata.level+1]
		end
		
		-- get previous level value
		local min = 0
		if( _G.userdata.level>1 )then
		
			min = levelSteps[ _G.userdata.level ]
			
		end

		-- set text
		txt.text = amt .. '/' .. max
		
		-- set bar
		local newS = (amt-min)/(max-min)
		if(newS>1)then newS = 1 end
		if(newS<=0) then newS = .0001 end
		txt.parent.bar.xScale = newS
		
		-- check for level up
		if( amt >= max )then
			
			_G.userdata.level = _G.userdata.level + 1
			txt.parent.level.text = _G.userdata.level
			
			-- show level up
			print('level up!!!')
			if(not _G.layer_modal.levelup )then
			
				if( _G.curModule==_G.upgrades )then
					
					_G.levelup.buildModule()
					
				elseif( _G.curModule==_G.achievements )then
					
					_G.levelup.buildModule()
					
				else
				
					print('save level up for later')
					_G.levelUpEarned = true
					
				end
				
				
			else
			
				print('level up modal exists already')
					
			end

		end
		
	end
	
end

--------------------------- INFO PANEL:
function buildInfoPanelWithImage(infoTextp, grp_pass, id1, id2, id3,id4, id5, id6)

    local grp_pass = grp_pass or main
	
	local grp = _G.util.addGroup(grp_pass, 'info', 0, 0, 1)
	
	_G.util.addImage('graphics/gui/info/bot.png', grp, 'bot', -10, 0, 1, 1, 0, 1)
	grp.bot.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/mid.png', grp, 'mid', -10, 0, 1, 1, 0, 1)
	grp.mid.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/top.png', grp, 'top', 6, 0, 1, 1, 0, 1)
	grp.top.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/hand02.png', grp, 'hand2', 10, 0, 1, 1, 0, 1)
	grp.hand2.anchorY = 1

	if id1 then
		_G.util.addImage('graphics/ceelo/dice/die'..id1..'.png', grp, 'die1', 10, 0, 1, 1, 0, 1)
		grp['die1'].anchorY = 1
		grp['die1'].anchorX = .5
	end

	if id2 then
		_G.util.addImage('graphics/ceelo/dice/die'..id2..'.png', grp, 'die2', 10, 0, 1, 1, 0, 1)
		grp['die2'].anchorY = 1
		grp['die2'].anchorX = .5
	end

	if id3 then
		_G.util.addImage('graphics/ceelo/dice/die'..id3..'.png', grp, 'die3', 10, 0, 1, 1, 0, 1)
		grp['die3'].anchorY = 1
		grp['die3'].anchorX = .5
	end

	if id4 then
		_G.util.addImage('graphics/ceelo/dice/die'..id4..'.png', grp, 'die4', 10, 0, 1, 1, 0, 1)
		grp['die4'].anchorY = 1
		grp['die4'].anchorX = .5
	end

	if id5 then
		_G.util.addImage('graphics/ceelo/dice/die'..id5..'.png', grp, 'die5', 10, 0, 1, 1, 0, 1)
		grp['die5'].anchorY = 1
		grp['die5'].anchorX = .5
	end

	if id6 then
		_G.util.addImage('graphics/ceelo/dice/die'..id6..'.png', grp, 'die6', 10, 0, 1, 1, 0, 1)
		grp['die6'].anchorY = 1
		grp['die6'].anchorX = .5
	end
	
	-- text
	local infoText = infoTextp or 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere tortor non ligula ve blah leh'
        
    _G.util.addTextMulti(infoText, grp, 'txt', 'native', -10, 0, 18, 240, 'center', 1, 1, 1)
	grp.txt.anchorX = .5
	grp.txt.anchorY = 1
	
	-- position
	grp.mid.y = grp.bot.y - grp.bot.height + 1
	grp.mid.height = grp.txt.height+6
	local tHeight = grp.txt.height+6
	local yPos = grp.mid.y

	if grp['die4'] and grp['die5'] and grp['die6'] then
		grp['die4'].x = -90
		grp['die4'].y = yPos +8

		grp['die5'].x = -10
		grp['die5'].y = grp['die4'].y

		grp['die6'].x = 70
		grp['die6'].y = grp['die4'].y

		yPos = grp['die6'].y - grp['die6'].height - 12
		tHeight = tHeight + grp['die4'].height+12
	end

	if grp['die1'] and grp['die2'] and grp['die3'] then
		grp['die1'].y = yPos+8
		grp['die2'].y = grp['die1'].y
		grp['die3'].y = grp['die1'].y
		grp['die1'].x = -90
		grp['die2'].x = -10
		grp['die3'].x = 70
		grp.txt.y = grp['die1'].y - grp['die1'].height - 8
		tHeight = tHeight + grp['die1'].height + 8
	end

	grp.mid.height = tHeight
	
	grp.top.y = grp.mid.y - grp.mid.height + 80
	grp.hand2.y = grp.top.y - 72
	
	grp.top.alpha = 1

	-- init
	grp.alpha = 0
	
	-- return 
	return grp
end

function buildInfoPanel(mode, infoTextp, grp_pass)
    local grp_pass = grp_pass or main
	
	local grp = _G.util.addGroup(grp_pass, 'info', 0, 0, 1)

	-- _G.util.addFill(grp, 'b', .5, .5, .5, .1, 0, 0, 1479, 768)

	-- pieces
	_G.util.addImage('graphics/gui/info/arrow.png', grp, 'arrow', -4, 0, 1, 1, 0, 1)
	grp.arrow.anchorY = 1

	-- pieces
	_G.util.addImage('graphics/gui/info/arrow.png', grp, 'arrow2', -4, 0, 1, 1, 0, 1)
	grp.arrow.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/bot.png', grp, 'bot', -10, 0, 1, 1, 0, 1)
	grp.bot.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/mid.png', grp, 'mid', -10, 0, 1, 1, 0, 1)
	grp.mid.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/hand01.png', grp, 'hand1', 0, 0, 1, 1, 0, 1)
	grp.hand1.anchorY = 1
	grp.hand1.alpha = 0
	
	_G.util.addImage('graphics/gui/info/top.png', grp, 'top', 6, 0, 1, 1, 0, 1)
	grp.top.anchorY = 1
	
	_G.util.addImage('graphics/gui/info/hand02.png', grp, 'hand2', 10, 0, 1, 1, 0, 1)
	grp.hand2.anchorY = 1
	
	-- text
	local infoText = infoTextp or 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere tortor non ligula ve blah leh'
        
    _G.util.addTextMulti(infoText, grp, 'txt', 'native', -10, 0, 18, 240, 'center', 1, 1, 1)
	grp.txt.anchorX = .5
	grp.txt.anchorY = 1
	
	-- position
	grp.bot.y = grp.arrow.y - 50
	grp.mid.y = grp.bot.y - grp.bot.height + 1
	grp.txt.y = grp.mid.y + 2
	grp.mid.height = grp.txt.height+6
	
	grp.top.y = grp.mid.y - grp.mid.height + 80
	grp.hand1.y = grp.top.y - 80
	grp.hand2.y = grp.top.y - 72
	
	grp.top.alpha = 1
	
	-- check mode
	if( mode == 'none' )then
	
		grp.hand1.alpha = 1
		grp.hand2.alpha = 0
		grp.arrow.alpha = 0
		
	end
        -- check mode
	if( mode == 'none2' )then
	
		grp.arrow.alpha = 0
		
	end
	if( mode == 'left' )then
	
		grp.arrow.rotation = 90
		grp.arrow.x = -210
		grp.arrow.y = -100
		
	end
	
	if( mode == 'right' )then
	
		grp.arrow.rotation = -90
		grp.arrow.x = 220
		grp.arrow.y = -100
		
	end
        
    if( mode == 'below' )then
		-- grp.arrow.x = -210
		grp.arrow.y = grp.bot.y + grp.arrow.height + 10
	end
        
   	if( mode == 'up' )then
	
		grp.arrow.rotation = 180
		grp.arrow.y = grp.top.y - grp.arrow.height - grp.arrow.height*2 - 40
		
	end
        
	-- init
	grp.alpha = 0
	
	-- return 
	return grp
end

local function onTutorialTouch(e)
	if not _G.TutorialData.noTutTap then
		if(e.phase~='ended' )then return true end
		if(e.target.alpha ~= 1)then return true end
	    if info then
		    -- hide window
		    local endClosure = function() hideTutorial( ) return true end
		    transition.to( info, {delay=0, time=100, y=info.y+40, alpha=0, transition=easing.inBack,onComplete=endClosure})
		end
	end
    return true
end

-- hide Tutorial window
function hideTutorial( firstTimeSet )
	if info.timmer then
		timer.cancel(info.timmer)
		info.timmer = nil
	end
    if tutTrans then
        transition.cancel(tutTrans)
        tutTrans = nil
    end
    if tutTimer then
        timer.cancel(tutTimer)
        tutTimer = nil
    end
    if info then
        unSetAtionPerform()
        _G.util.dropImage(info)

        _G.TutorialData.displaying = false
        info = nil
        if firstTimeSet == nil then
            if callBack ~= nil then
                callBack()
            end
        end
    end
    _G.TutorialData.getTotalDisplayTutorail()
end

function validTutorial( name )
    if _G.TutorialData.totalDisplay < _G.TutorialData.totalTutorial then
	    if( _G.TutorialData.data[name] ~= nil )then
	    	print_r(_G.TutorialData.data[name])
	        if _G.TutorialData.data[name].display then
	        	if _G.TutorialData.data[name].stage ~= nil then
	        		if _G.TutorialData.data[name].stage == _G.curLevelNum then
		            	if _G.TutorialData.data[name].level ~= nil then
		            		if _G.TutorialData.data[name].level == _G.curStageNum then
		                    	return _G.TutorialData.data[name];
		                    end
		                else
		                    return _G.TutorialData.data[name];
		                end
		            end
	            else
	                return _G.TutorialData.data[name];
	            end
	        end
	    end
	end
    return nil
end

function changeTutorialData( name, value )
    if value then
        _G.TutorialData.data[name].display = value
    else
        _G.TutorialData.data[name].display = false
    end
    _G.loadsave.saveTable(_G.TutorialData.data,"tutorials.json")
end

function unSetAtionPerform(  )
	_G.TutorialData.noActionDrag = false
	_G.TutorialData.noActiontap = false
	_G.TutorialData.noActionTimer = false
	_G.TutorialData.targetAction = ""
	_G.TutorialData.noTutTap = false
	_G.TutorialData.displaying = false
	_G.TutorialData.tutorialRunning = false
	_G.TutorialData.noActiontapColor = false
	_G.TutorialData.noActiontapMeat = false
	
end
function setAtionPerform2(type)
	_G.TutorialData.noActionDrag = true
	_G.TutorialData.noActiontap = true
	_G.TutorialData.noActionTimer = true
	_G.TutorialData.noTutTap = true
	_G.TutorialData.noActiontapColor = true
	_G.TutorialData.noActiontapMeat = true
	
	if type == 1 then
    	_G.TutorialData.noTutTap = false
    elseif type == 2 then
    	_G.TutorialData.noActionDrag = false
    elseif type == 3 then
    	_G.TutorialData.noActiontap = false
    elseif type == 33 then
    	_G.TutorialData.noActiontapColor = false
    	elseif type == 34 then
    	_G.TutorialData.noActiontapMeat = false
    elseif type == 4 then
    	_G.TutorialData.noActionTimer = false
    elseif type == 9 then
    	_G.TutorialData.noActionDrag = false
		_G.TutorialData.noActiontap = false
		_G.TutorialData.noActionTimer = false
		_G.TutorialData.noTutTap = false
		_G.TutorialData.noActiontapColor = false
		_G.TutorialData.noActiontapMeat = false
    else
    	_G.TutorialData.noTutTap = false
    end
end
function setAtionPerform( type )
	_G.TutorialData.displaying = true
	setAtionPerform2(type)
end
function setTutorial(name,option,twoArraw)    
    local grpPass = option.group
    local toX = option.x
    local toY = option.y
    local fy = option.fy
    local fx = option.fx

    callBack = option.callback
    hideTutorial( true )
    local tutorialData = validTutorial( name )
    if tutorialData ~= nil then
    	unSetAtionPerform(  )
        _G.TutorialData.displaying = true
        if option.isImage then
        	info = buildInfoPanelWithImage(tutorialData.message,grpPass,option.id1, option.id2, option.id3, option.id4, option.id5, option.id6)
        else
        	info = buildInfoPanel(tutorialData.type,tutorialData.message,grpPass,twoArraw)
        end
        info:toFront()

        if fy then
            info.y = fY
        end
        
        if fx then
            info.x = fx
        end
        if twoArraw then
			info.arrow2.isVisible = true
			info.arrow.rotation = 80
			info.arrow.x = -210
			info.arrow.y = -50

			info.arrow2.rotation = 100
			info.arrow2.x = -210
			info.arrow2.y = -150

        else
        	if option.isImage then
        	else
				info.arrow2.isVisible = false
			end
        end

        if toX~=nil or toY~= nil then
            tutTrans = transition.to( info, {delay=100, time=100, x= toX, y=toY, alpha=1, transition=easing.outBack})
        else
            tutTrans = transition.to( info, {delay=100, time=100, x= nil, y = nil, alpha=1, transition=easing.outBack})
        end

        -- info.b:addEventListener('touch', onBlockTouch)
		-- info.b:addEventListener('tap', onBlockTap)

        info.step = name
        
        
		setAtionPerform( tutorialData.tutType )
		_G.TutorialData.targetAction = option.target or ""
		info.tutName = name
		changeTutorialData(name)
		info:addEventListener('tap', onBlockTap)

		if not _G.TutorialData.noTutTap then
			info.timmer = timer.performWithDelay(5000,function()
				info.timmer = nil
				hideTutorial()
			end)
	        info:addEventListener('touch', onTutorialTouch)
	    end
        print_r(info)
        return info
    end
    return nil
end

-- function setInfoPanel(grp, info)
	
-- 	-- set info
-- 	grp.txt.text = info
	
-- 	-- position
-- 	grp.bot.y = grp.arrow.y - 50
-- 	grp.mid.y = grp.bot.y - grp.bot.height + 1
-- 	grp.txt.y = grp.mid.y + 2
-- 	grp.mid.height = grp.txt.height+6
	
-- 	grp.top.y = grp.mid.y - grp.mid.height + 80
-- 	grp.hand1.y = grp.top.y - 80
-- 	grp.hand2.y = grp.top.y - 72
	
-- 	grp.top.alpha = 1
	
-- end

--------------------------- EVENTS:

function onBlockTouch(e)

	--print('block touch')
	return true
	
end

function onBlockTap(e)

	--print('block tap')
	return true
	
end

function updateRevenue(value)

	local oldval = main.revenue.total + 0
	main.revenue.total = main.revenue.total + value
	
	if( main.revenue.total<0 )then main.revenue.total = 0 end
	
	-- set to roll
	local newval = main.revenue.total + 0
	local diff = newval - oldval
	local step = math.floor(diff/ROLL_SPAN)
	local myclosure = nil
	local delayer = 0
	
	-- set step
	if(step==0)then step=1 end
	
	-- start rollers
	for i=1, ROLL_SPAN do
	
		local upval = 0
		upval = oldval + (i*step)
		
		if( step < 0 )then
			
			if(upval < newval)then upval=newval end
			
		else
		
			if(upval > newval)then upval=newval end
			
		end
		
		if(i==ROLL_SPAN)then upval=newval end
		
		myclosure = function() return onFieldUpdate( main.revenue.txt, upval ) end
		timer.performWithDelay(delayer, myclosure, 1)
		
		myclosure = function() return onFieldUpdate( main.revenue.txtb, upval ) end
		timer.performWithDelay(delayer, myclosure, 1)
		
		delayer = delayer + ROLL_DELAY
		
	end
	
	-- shift bar
	local pS = main.revenue.total / stars[3]
	if(pS > 1)then pS = 1 end
	if(pS <= 0)then pS = .0001 end
	
	main.revenue.bar.xScale = pS
	
	-- highlight stars
	for i=1, 3 do
		
		if( (main.revenue.total >= stars[i]) and (main.revenue['star'..i].isOn~=true) )then
	
			main.revenue['star'..i].isOn = true
			main.revenue['star'..i]:setFillColor(1,1,0)
			
			local myclosure = function() return _G.mixer.playSFX('star'..i) end
			timer.performWithDelay(250, myclosure, 1)
		
		end
		
	end
	
end

function onShopTouch(e)

	if( main.gui.black.alpha ~= 0 )then return end
	if( e.phase ~= 'began' )then return end
	
	transition.to( main.gui.black, {time=400, alpha=1, transition=easing.inQuad})
	
	-- open shop
	local mode = ''
	if(e.target.id == 'money')then
		mode = 'cash'
	end
	if(e.target.id == 'gems')then
		mode = 'gems'
	end
	if(e.target.id == 'exit')then
		mode = 'cash'
	end
	_G.shop.buildModule(mode)
	
	_G.mixer.playNavSFX('select')
	
	
end

function onShopClose()

	--print('what what?')
	transition.to( main.gui.black, {time=400, alpha=0, transition=easing.outQuad})
	
end

function onFooterTouch(e)

	if( main.gui.black.alpha ~= 0 )then return end
	if( e.phase ~= 'began' )then return end
	
	-- flash over
	if( e.target.over )then
	
		print('has over')
		if(e.target.trans)then transition.cancel(e.target.trans) end
		e.target.over.alpha = .5
		e.target.trans = transition.to( e.target.over, {delay=100, time=200, alpha=0, transition=easing.outQuad})
		
	end
	
	-- execute
	if( e.target.id == 'settings' )then
		
		_G.options.buildModule()
		
		local myclosure = function() return _G.gui.onShopClose() end
		_G.options.setBackClosure( myclosure )
		
		transition.to( main.gui.black, {time=400, alpha=1, transition=easing.inQuad})
		
	end
	
	if( e.target.id == 'achievements' )then
		
		local myclosure = function() return _G.achievements.buildModule( e.target ) end
		timer.performWithDelay( 310, myclosure )
		
		local myclosure = function() return _G.gui.onShopClose() end
		_G.achievements.setBackClosure( myclosure )
		
		transition.to( main.gui.black, {delay=00, time=300, alpha=1, transition=easing.inQuad})
		
	end
	
	if( e.target.id == 'facebook' )then
		
		_G.fbconnect.buildModule()
		
		local myclosure = function() return _G.gui.onShopClose() end
		_G.fbconnect.setBackClosure( myclosure )
		
		transition.to( main.gui.black, {time=400, alpha=1, transition=easing.inQuad})
		
	end
	
	if( e.target.id == 'standings' )then
		
		if( _G.loggedIntoGC )then
		
			print('already connected to GC')
			sendHighScore()
			showLeaderboards()
			
		else
		
			print('not logged into GC, init...')
			_G.gameNetwork.init( "gamecenter", onGameCenterInit )
			
		end
		
	end
	
	_G.mixer.playNavSFX('select')
	
end

function onIngameShopTouch(e)
		
	if( e.phase ~= 'began' )then return end
	if( _G.inputPause )then
		print('input paused')
		return
	end

	local mode = ''
	if(e.target.id == 'money')then
		mode = 'cash'
	end
	if(e.target.id == 'gems')then
		mode = 'gems'
	end
	
	_G.mixer.playNavSFX('select')
		
	-- from level select
	if(_G.curModule==_G.levelselect)then
	
		_G.inputPause = true
		local myclosure = function() return _G.levelselect.buildModule() end
		_G.shop.setBackClosure(myclosure)
		_G.levelselect.gotoShop(mode)
		
	end
	
	-- from upgrades
	if(_G.curModule==_G.upgrades)then
	
		_G.inputPause = true
		local myclosure = function() return _G.upgrades.buildModule() end
		_G.shop.setBackClosure(myclosure)
		_G.upgrades.gotoShop(mode)
		
	end
	
	-- from ceelo
	if(_G.curModule==_G.ceelo)then
	
		_G.inputPause = true
		local myclosure = function() return _G.ceelo.onShopClose() end
		_G.shop.setBackClosure(myclosure)
		_G.ceelo.gotoShop(mode)
		
	end
	
end

--------------------------- LEADERBOARD EVENTS:

function onGameCenterInit(e)

    if ( e == "showSignIn" ) then
        
		print('show sign in')
		
    elseif ( e.data ) then
		
		print('game center login success')
		
        _G.loggedIntoGC = true
		
		-- show scores
		sendHighScore()
		showLeaderboards()		
				
    end

end

function onGameNetworkPopupDismissed(e)
	
    print('Game Center popup was closed');
    for k,v in pairs( e ) do
        print( k,v )
    end
	
end

function onGameNetworkSubmit(e)
	
    if ( e.type == "setHighScore" ) then
    
		print('high score received by game network')
	      
    end
	
end

function sendHighScore()

	gameNetwork.request( "setHighScore",
	    {
	        localPlayerScore = { category="Leaderboard001", value=10000 },
	        listener = onGameNetworkSubmit
	    }
	)
	
end

function showLeaderboards()

	-- show boards
	_G.gameNetwork.show( "leaderboards",
	    {
	        leaderboard = {
	            category = "Leaderboard001"
	        },
	        listener = onGameNetworkPopupDismissed
	    }
	)
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	print('stop gui')
	
end

function killModule()
	
	print('kill gui')
	
	if(not grp_main.parent)then return end
	
	_G.mixer.killSFX()
	grp_main:removeSelf()
	grp_main = nil
	
end
