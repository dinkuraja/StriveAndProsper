
module(..., package.seeall)

-------------------------- CONSTANTS


-------------------------- VARIABLES

local grp_main
local curPlayer
local maxPlayer
local playerNames = {'Ferg','Rocky'}
local curBet = 0
local info = nil
--------------------------- INIT

function buildModule()

	-- build main
	grp_main = util.addGroup(_G.layer_stage, 'grp_main', 0, 0, 1)
	
	buildCeelo(2)
	_G.mixer.loadSFX('ceelo')
	_G.gui.buildModule(grp_main,'ceelo')	
	curPlayer = 1
	
	-- show 
	local myclosure = function() return showDisplay(grp_main.betting) end
	timer.performWithDelay(500, myclosure)
	
	-- set module
	_G.curModule = _G.ceelo
	_G.loader.hideLoader()
	
	-- set music
	_G.mixer.loadMusic('map_dice')
	_G.mixer.playMusic()
	
end

function buildCeelo(num)

	-- save num
	maxPlayer = num

	-- background 
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	local col=0
	local row=0
	for i=1, 4 do
	
		local b = _G.util.addImage('graphics/ceelo/bg_0' .. i ..'.png', bg, 'b', 0, 0, 1, 1, 0, 1)
		b.anchorX = 0
		b.anchorY = 0
		b.x = 683 * col
		b.y = 384 * row
		
		col = col + 1
		if( col==2 )then
			col = 0
			row = row + 1
		end
		
	end
	bg.x = bg.width * -.5
	bg.y = -384
	
	-- build players
	local players = util.addGroup(grp_main, 'players', 0, 40, 1)
	for i=1, num do
		
		local p = util.addGroup(players, 'p'..i, 0, 0, 1)
		p.x = 280 * (i-1)
		_G.util.addFill(p, 'frame', .3, .3, .3, 1, 0, 0, 256, 600)
		_G.util.addFill(p, 'bg', .7, .7, .7, 1, 0, 0, 256-12, 600-12)
		_G.util.addFill(p, 'line', .3, .3, .3, 1, 0, 144, 256, 6)
		_G.util.addText('', p, 'txt', 'bold', 0, 180, 22, .3, .3, .3)
		_G.util.addText('', p, 'outcome', 'bold', 0, 0, 66, 1, 0, 0)
		p.outcome.isVisible = false
		
		-- blank score
		local score = {}
		score.type = 'none'
		score.value = 0
		p.score = score
		
		-- init
		p.bg.alpha = .5
		p.frame.alpha = .5
		
		-- dice
		local dice = util.addGroup(p, 'dice', -70, 240, 1)
		for j=1, 3 do
		
			local d = util.addGroup(dice, 'd'..j, 0, 0, 1)
			d.x = (j-1) * 70
			_G.util.addFill(d, 'bg', 1, 1, 1, 1, 0, 0, 64, 64)
			
			local row = 0
			local col = 0
			local allDots = {}
			for k=1, 9 do
			
				local circ = display.newCircle(0, 0, 6 )
				circ:setFillColor(0,0,0)
				d:insert(circ)
				
				circ.x = (col * 14) - 14
				circ.y = (row * 14) - 14
				circ.strokeWidth = 0
				circ:setStrokeColor( 0, 0, 0 )
				
				-- set to 6
				if( col==1 )then circ.alpha = 0 end
				d.num = 6
				
				-- increment
				col = col + 1
				if( col == 3 )then
					col = 0
					row = row + 1
				end
				
				allDots[k] = circ
				
			end
			d.dots = allDots
			
		end
		dice.panel = p
		
		if( i==1 )then 
		
			p.txt.text = 'TAP DICE TO ROLL'
			--dice:addEventListener('touch', onDiceTouch)
			
		end

	end
	players.x = (players.width * -.5) + 140 - 30
	players.alpha = 0
	players.y = -200
	
	-- build dice roll
	local options =
	{
	    width = 150,
	    height = 225,
	    numFrames = 32
	}
	local sheet = graphics.newImageSheet( "graphics/ceelo/diceroll.png", options )

	-- consecutive frames
	local sequenceData =
	{
	    name="roll",
	    start=1,
	    count=32,
	    time=1200,
	    loopCount = 1
	}

	local diceroll = display.newSprite( sheet, sequenceData )
	diceroll.x = -20
	diceroll.y = 80
	diceroll.xScale = 2
	diceroll.yScale = 2
	--diceroll:play()
	
	grp_main:insert(diceroll)
	grp_main.diceroll = diceroll
	
	-- betting display
	local betting = util.addGroup(grp_main, 'betting', 0, 384-130, 1)
	_G.util.addFill(betting, 'bg', 0, 0, 0, .6, 0, 0, 1400, 260)
	_G.util.addText(' SELECT YOUR BET ', betting, 'large', 'bangers', 0, -60, 70, 1, .86, 0)
	
	local names = {'low','medium','high'}
	local nums = {100,500,10000}
	for i=1, 3 do
	
		local btn = util.addGroup(betting, 'btn'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/buttons/btn.png', btn, 'br', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' '..names[i]..' ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
		_G.util.addText(' $'..nums[i]..' ', btn, 'txt', 'bangers', 12, 54, 28, 1, 1, 1)
		btn.x = ( (i-1) * 240 ) - 240
		btn.y = 40
		btn.betValue = nums[i]
		btn:addEventListener('touch', onBetTouch)
		
	end
	
	betting.endY = betting.y
	betting.y = betting.y + 384
	betting.startY = betting.y
	
	-- outcome display
	local outcome = util.addGroup(grp_main, 'outcome', 0, 384-140, 1)
	_G.util.addFill(outcome, 'bg', 0, 0, 0, .6, 0, 0, 1400, 280)
	_G.util.addText(' FERG ROLLED ', outcome, 'title', 'bangers', 0, -90, 70, 1, .86, 0)
	_G.util.addText(' REROLLING... ', outcome, 'txt', 'bangers', 0, 80, 40, 1, .86, 0)
	
	for i=1, 3 do
	
		local die = _G.util.addGroup(outcome, 'die'..i, 0, 0, 1)
		for j=1, 6 do
		
			_G.util.addImage('graphics/ceelo/dice/die0'..j..'.png', die, 'd'..j, 0, 0, 1, 1, 0, 1)
			
		end
		die.x = ( (i-1)*70 ) -70
		die.y = -4
		
	end
	
	local btn = util.addGroup(outcome, 'reroll', -6, 0, 1)
	_G.util.addImage('graphics/menus/buttons/btn.png', btn, 'br', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ROLL AGAIN ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
	btn.y = 80
	btn.alpha = 0
	btn:addEventListener('touch', onRerollTouch)
	
	outcome.endY = outcome.y
	outcome.y = outcome.y + 384
	outcome.startY = outcome.y
	
	-- results display
	local results = util.addGroup(grp_main, 'results', 0, 384-130, 1)
	_G.util.addFill(results, 'bg', 0, 0, 0, .6, 0, 0, 1400, 260)
	_G.util.addText(' FERG WINS! ', results, 'title', 'bangers', 0, -60, 70, 1, .86, 0)
	
	local names = {'map','replay'}
	for i=1, 2 do
	
		local btn = _G.util.addImage('graphics/menus/buttons/'..names[i]..'.png', results, names[i], 0, 0, 1, 1, 0, 1)
		btn.x = ( (i-1) * 160 ) - 80
		btn.y = 40
		btn:addEventListener('touch', onResultsTouch)
		
	end
	
	results.endY = results.y
	results.y = results.y + 384
	results.startY = results.y
	
	-- build bagdes (fpo)
	local names = {'ferg','rocky'}
	local nums = {1,0}
	
	for i=1, 2 do
	
		local badge = util.addGroup(grp_main, 'badge'..i, 0, 0, 1)
		_G.util.addImage('graphics/ceelo/badge.png', badge, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addText(' '..names[i]..' ', badge, 'name', 'bangers', 0, 30, 20, 1, .86, 0)
		_G.util.addText('  ', badge, 'name', 'bangers', 0, 48, 20, 237/255, 28/255, 36/255)
		
		local c = _G.customers.buildCharacter( nums[i] )
		c.xScale = .55
		c.yScale = .55
		c.alpha = 1
		_G.customers.startPupils(c)

		local char = util.addGroup(badge, 'char'..i, 0, 0, 1)
		char.x = 3
		char.y = 88
		char:insert(c)
		
		local masker = graphics.newMask('graphics/ceelo/masker.png')
		char:setMask(masker)
		char.maskY = -114
		char.maskX = -3
		
		-- dice
		local dice = util.addGroup(badge, 'dice', 0, 0, 1)
		for i=1, 3 do
	
			local die = _G.util.addGroup(dice, 'die'..i, 0, 0, 1)
			for j=1, 6 do
		
				_G.util.addImage('graphics/ceelo/dice/die0'..j..'.png', die, 'd'..j, 0, 0, 1, 1, 0, 1)
			
			end
			die.x = ( (i-1)*70 ) -70
			die.y = -4
		
		end
		dice.xScale = .3
		dice.yScale = .3
		dice.y = 56
		dice.alpha = 0
		
		-- position
		badge.x = ( (i-1) * 150 ) - 75
		badge.y = -210
		
	end
	
end
function tutorialShow(num,callback)
	info = nil
	if callback == nil then
		function callback(  )
			info = nil
		end
	end
	if(num==1) then
    	info = _G.gui.setTutorial("wellcomeCelloMessage",{ fy = 100, y=110, group=grp_main, callback = callback })
    elseif(num==2) then
    	info = _G.gui.setTutorial("lowBetCello",{ fy = 100, x= -220, y=250, group=grp_main, callback = callback })
    elseif(num==3) then
    	info = _G.gui.setTutorial("info1Message",{ fy = 100, y=110, group=grp_main, callback = callback, isImage = true, id1="04",id2="05",id3="06" })
    elseif(num==4) then
    	info = _G.gui.setTutorial("info2Message",{ fy = 100, y=110, group=grp_main, callback = callback, isImage = true, id1="01",id2="02",id3="03" })
    elseif(num==5) then
    	info = _G.gui.setTutorial("info3Message",{ fy = 100, y=110, group=grp_main, callback = callback, isImage = true, id1="04",id2="04",id3="06" })
    elseif(num==6) then
    	info = _G.gui.setTutorial("roolMessage",{ fy = 100, y=110, group=grp_main, callback = callback, isImage = true, id1="01",id2="02",id3="01", id4="05",id5="02",id6="05" })
    end
    if info ~= nil then
    	info.passData = _G.TutorialData.defaultObjectTargetType[info.tutName]
    end
    return info
end
--------------------------- INPUT:

function onScreenTouch(e)
	if _G.TutorialData.displaying then return end
	if(e.phase ~= 'began')then return end
	
	Runtime:removeEventListener('touch', onScreenTouch)
	killModule()
	buildModule()
	
end

function onExitTouch(e)
	if _G.TutorialData.displaying then return end
	if(e.phase ~= 'began')then return end
	
	Runtime:removeEventListener('touch', onScreenTouch)
	
	stopModule()
	
	_G.mixer.fadeMusic()
	_G.loader.showLoader()
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(550, myclosure, 1)
	
	local myclosure = function() return _G.map.buildModule() end
	timer.performWithDelay(700, myclosure, 1)
	
end

function onBetTouch(e)
	print( "Button Touch Number ", e.target.id )
	if _G.TutorialData.checkTargetTouch(3) then return end
	if _G.TutorialData.displaying and info ~= nil and info.passData == nil then return end
	if _G.TutorialData.displaying and e.target.id ~= info.passData.tap then return end
	if(e.phase ~= 'began')then return end
	local function finishTut()
		info = nil
		if( e.target.betValue > _G.userdata.cash )then
			_G.mixer.playNavSFX('wrong')
			return
		end

		_G.mixer.playNavSFX('select')

		curBet = e.target.betValue
		_G.gui.setCash( curBet*-1 )
		
		_G.achievements.updateAchievement('ceeloBets', curBet)

		if( grp_main.betting.y ~= grp_main.betting.endY )then return end
		hideDisplay(grp_main.betting)
		
		local myclosure = function() return rollCurDice() end
		timer.performWithDelay(400, myclosure)
	end
	local i = 3
	local function finishTutRepeat()
		print( "i == ",i )
		if i ~= 6 then
			i = i + 1
			local info = tutorialShow(i,finishTutRepeat)
			if info == nil then
				finishTutRepeat()
			end	
		else
			finishTut()
		end
	end
	local info = tutorialShow(3,finishTutRepeat)
	if info == nil then
		finishTutRepeat()
	end	
end

function onRerollTouch(e)
	if _G.TutorialData.displaying then return end
	if(e.phase ~= 'began')then return end

	print(grp_main.outcome.y, grp_main.outcome.endY)

	if( grp_main.outcome.y ~= grp_main.outcome.endY )then return end
	hideDisplay(grp_main.outcome)
	
	local myclosure = function() return rollCurDice() end
	timer.performWithDelay(400, myclosure)
	
	_G.mixer.playNavSFX('select')
	
end

function onResultsTouch(e)
	if _G.TutorialData.displaying then return end
	if(e.phase ~= 'began')then return end
	
	if(e.target.id == 'map')then
	
		stopModule()
		killModule()
		_G.map.buildModule()
		
	end
	
	if(e.target.id == 'replay')then
	
		hideDisplay(grp_main.results)
		
		local myclosure = function() return killModule() end
		timer.performWithDelay(500, myclosure)
		
		local myclosure = function() return buildModule() end
		timer.performWithDelay(500, myclosure)
		
	end
	
	_G.mixer.playNavSFX('select')
	
end

--------------------------- EVENTS:

function onDiceTouch(e)
	if _G.TutorialData.displaying then return end
	if(e.phase~='began')then return end
	if(e.target.mode=='rolling')then return end
	
	rollCurDice()
	
end

function rollCurDice()
	
	if( not grp_main )then return end
	
	local curDice = grp_main.players['p'..curPlayer].dice
	
	rollDie(curDice.d1, 10)
	rollDie(curDice.d2, 10)
	rollDie(curDice.d3, 10)
	
	curDice.mode = 'rolling'
	curDice.panel.txt.text = 'ROLLING'
	
	grp_main.diceroll:play()
	
	-- audio & eval
	--local myclosure = function() return _G.mixer.playSFX('shake') end
	--timer.performWithDelay(0, myclosure)
	
	local myclosure = function() return _G.mixer.playSFX('roll') end
	timer.performWithDelay(0050, myclosure)
	
	local myclosure = function() return evaluateDice(curDice) end
	timer.performWithDelay(2100, myclosure)
	
end

function rollDie(die, num)
	
	if(not die.parent)then return end

	local delayInc = 200
	local delay = 0
	
	for i=1, num do
	
		local myclosure = function() return changeDie(die) end
		timer.performWithDelay(delay, myclosure)
		delay = delay + delayInc	
		
	end
	
end

function changeDie(die)
	
	if(not die.parent)then return end
	
	-- pull available outcomes
	local outcomes = {}
	for i=1, 6 do
		
		if( i ~= die.num )then
			outcomes[#outcomes+1] = i
		end
		
	end
	
	-- pick outcome
	local randO = math.floor(math.random() * #outcomes) + 1
	local outcome = outcomes[randO]
	
	-- hide all circles
	for i=1, #die.dots do
	
		die.dots[i].alpha = 0
		
	end
	
	-- show dots
	if( outcome==1 )then
	
		die.dots[5].alpha = 1
		
	end
	if( outcome==2 )then
	
		die.dots[1].alpha = 1
		die.dots[9].alpha = 1
		
	end
	if( outcome==3 )then
	
		die.dots[5].alpha = 1
		die.dots[1].alpha = 1
		die.dots[9].alpha = 1
		
	end
	if( outcome==4 )then
	
		die.dots[1].alpha = 1
		die.dots[3].alpha = 1
		die.dots[7].alpha = 1
		die.dots[9].alpha = 1
		
	end
	if( outcome==5 )then
	
		die.dots[1].alpha = 1
		die.dots[3].alpha = 1
		die.dots[5].alpha = 1
		die.dots[7].alpha = 1
		die.dots[9].alpha = 1
		
	end
	if( outcome==6 )then
	
		die.dots[1].alpha = 1
		die.dots[3].alpha = 1
		die.dots[4].alpha = 1
		die.dots[6].alpha = 1
		die.dots[7].alpha = 1
		die.dots[9].alpha = 1
		
	end
	
	-- set outcome
	die.num = outcome
	
end

function evaluateDice(dice)
	
	if(not dice.parent)then return end

	-- get sequence
	local seq = {}
	for i=1, 3 do
	
		seq[i]=dice['d'..i].num
		
	end
	
	-- set score var
	local score = {}
	score.type = 'none'
	score.value = 0
	
	-- set outcome
	local badge = grp_main['badge'..curPlayer]
	badge.dice.alpha = 1
	
	for i=1, 3 do
	
		for j=1, 6 do
		
			local d = grp_main.outcome['die'..i]['d'..j]
			local bd = badge.dice['die'..i]['d'..j]
			d.alpha = 0
			bd.alpha = 0
			
			if( j==seq[i] )then
				d.alpha = 1
				bd.alpha = 1
			end
			
		end
		
	end
	
	-- sort order
	local function compare( a, b )
	    return a < b
	end
	table.sort( seq, compare )
	print( table.concat( seq, ", " ) )
	
	-------------------------------------------------
	--- OUTCOME LOGIC -------------------------------
	-------------------------------------------------
	
	-- check for auto win/lose
	local isAuto = false
	if( ( seq[1]==4 ) and ( seq[2]==5 ) and ( seq[3]==6 ) )then
		isAuto = true
		score.type = 'ceelo'
		score.val = 0
	end
	if( ( seq[1]==1 ) and ( seq[2]==2 ) and ( seq[3]==3 ) )then
		isAuto = true
		score.type = 'bust'
		score.val = 0
	end
	
	-- check for triple
	local isTriple = false
	if( ( seq[1] == seq[2] ) and ( seq[2] == seq[3] ) and (isAuto==false) )then
		isTriple = true
		score.type = 'triple'
		score.value = seq[1]
	end
	
	-- check for doubles
	local isDouble = false
	if( ( seq[1] == seq[2] ) and (isTriple==false) )then
		isDouble = true
		score.type = 'double'
		score.value = seq[3]
		score.pair = seq[1]
	end
	if( ( seq[2] == seq[3] ) and (isTriple==false) )then
		isDouble = true
		score.type = 'double'
		score.value = seq[1]
		score.pair = seq[2]
	end
	
	-- highlight outcomes
	if( (score.type =='ceelo') or (score.type=='triple'))then
	
		dice.d1.bg:setFillColor(0,1,0)
		dice.d2.bg:setFillColor(0,1,0)
		dice.d3.bg:setFillColor(0,1,0)
		
	end
	if( (score.type =='bust') )then
	
		dice.d1.bg:setFillColor(1,0,0)
		dice.d2.bg:setFillColor(1,0,0)
		dice.d3.bg:setFillColor(1,0,0)
		
	end
	if( (score.type =='double') )then
	
		for i=1, 3 do
		
			if( dice['d'..i].num == score.value )then
			
				dice['d'..i].bg:setFillColor(0,1,0)
				
			end
			
		end
		
	end
	
	-- reset outcome
	grp_main.outcome.reroll.alpha = 0
	grp_main.outcome.txt.text = ''
	grp_main.outcome.title.text = playerNames[curPlayer] .. ' ROLLED: '
	
	-- update text
	if( score.type == 'ceelo' )then
		dice.panel.txt.text = 'AUTO WIN!'
		grp_main.outcome.txt.text = ' CEELO! '
	end
	if( score.type == 'bust' )then
		dice.panel.txt.text = 'AUTO LOSE!'
		grp_main.outcome.txt.text = ' BUSTED! '
	end
	if( score.type == 'triple' )then
		dice.panel.txt.text = 'TRIPS: ' .. score.value
		grp_main.outcome.txt.text = 'TRIPS - NICE ONE! '
	end
	if( score.type == 'double' )then
		dice.panel.txt.text = 'POINT: ' .. score.value
		grp_main.outcome.txt.text = 'POINT SCORED: ' .. score.value
	end
	
	-- check for null outcome
	if( (score.type == 'none') )then
		
		if( curPlayer == 1 )then
		
			dice.mode = 'active'
			grp_main.outcome.reroll.alpha = 1
			
		end
		
		if( curPlayer == 2 )then
		
			local myclosure = function() return hideDisplay(grp_main.outcome) end
			timer.performWithDelay(3000, myclosure)
			
			local myclosure = function() return rollCurDice() end
			timer.performWithDelay(3400, myclosure)
			
			grp_main.outcome.txt.text = 'NO SCORE - REROLLING.'
				
		end
		
		dice.panel.txt.text = 'ROLL AGAIN'
		
	end
	
	if( (score.type=='triple') or (score.type=='double') )then
		
		if( curPlayer == 1 )then
		
			curPlayer = 2
			
			local myclosure = function()
				if( not grp_main )then return end
				return hideDisplay(grp_main.outcome)
			end
			timer.performWithDelay(3000, myclosure)
			
			local myclosure = function() return rollCurDice() end
			timer.performWithDelay(3400, myclosure)
			
		elseif( curPlayer == 2 )then
		
			timer.performWithDelay(1000, checkScores)
				
		end
		
	end
	
	if( (score.type=='ceelo') or (score.type=='bust') )then
		
		timer.performWithDelay(1000, checkScores)
		
	end
	
	-- save score
	dice.panel.score = score
	
	-- show outcome
	showDisplay(grp_main.outcome)
	
	-- output
	print('score: ' .. score.type .. ', ' .. score.value)
	
end

function checkScores()
	
	if(not grp_main.players.parent)then return end
	
	local winnerNum = 0
	local p1 = grp_main.players.p1
	local p2 = grp_main.players.p2
	
	-- show results, play audio
	local myclosure = function() return hideDisplay(grp_main.outcome) end
	timer.performWithDelay(2000, myclosure)
	
	local myclosure = function() return showDisplay(grp_main.results) end
	timer.performWithDelay(2400, myclosure)
	
	local myclosure = function() return checkAudio() end
	timer.performWithDelay(2400, myclosure)
	
	-- enable reset
	--Runtime:addEventListener('touch', onScreenTouch)
	
	-- check auto wins/loses
	if( p1.score.type == 'ceelo' )then
		p1.outcome.text = 'WIN'
		p2.outcome.text = 'LOSE'
		return
	end
	if( p2.score.type == 'ceelo' )then
		p2.outcome.text = 'WIN'
		p1.outcome.text = 'LOSE'
		return
	end
	if( p1.score.type == 'bust' )then
		p2.outcome.text = 'WIN'
		p1.outcome.text = 'LOSE'
		return
	end
	if( p2.score.type == 'bust' )then
		p1.outcome.text = 'WIN'
		p2.outcome.text = 'LOSE'
		return
	end
	
	-- check for trips
	if( p1.score.type == 'triple' )then
		
		if( p2.score.type ~= 'triple' )then
			p1.outcome.text = 'WIN'
			p2.outcome.text = 'LOSE'
		else
			
			if( p1.score.value > p2.score.value )then
				p1.outcome.text = 'WIN'
				p2.outcome.text = 'LOSE'
			end
			if( p1.score.value < p2.score.value )then
				p2.outcome.text = 'WIN'
				p1.outcome.text = 'LOSE'
			end
			if( p1.score.value == p2.score.value )then
				p1.outcome.text = 'TIE'
				p2.outcome.text = 'TIE'
			end
			
		end
		return
		
	end
	if( p2.score.type == 'triple' )then
		
		if( p1.score.type ~= 'triple' )then
			p2.outcome.text = 'WIN'
			p1.outcome.text = 'LOSE'
		else
			
			if( p2.score.value > p1.score.value )then
				p2.outcome.text = 'WIN'
				p1.outcome.text = 'LOSE'
			end
			if( p2.score.value < p1.score.value )then
				p1.outcome.text = 'WIN'
				p2.outcome.text = 'LOSE'
			end
			if( p1.score.value == p2.score.value )then
				p1.outcome.text = 'TIE'
				p2.outcome.text = 'TIE'
			end
			
		end
		return
		
	end
	
	-- check for doubles
	if( (p1.score.type == 'double') and (p2.score.type == 'double') )then
	
		if( p1.score.value > p2.score.value )then
			p1.outcome.text = 'WIN'
			p2.outcome.text = 'LOSE'
		end
		if( p1.score.value < p2.score.value )then
			p2.outcome.text = 'WIN'
			p1.outcome.text = 'LOSE'
		end
		
		-- if tie, check double pair
		if( p1.score.value == p2.score.value )then
			
			if(p1.score.pair > p2.score.pair)then
				p1.outcome.text = 'WIN'
				p2.outcome.text = 'LOSE'
			end
			if(p1.score.pair < p2.score.pair)then
				p2.outcome.text = 'WIN'
				p1.outcome.text = 'LOSE'
			end
			if(p1.score.pair == p2.score.pair)then
				p1.outcome.text = 'TIE'
				p2.outcome.text = 'TIE'
			end
			
		end
		
		return
		
	end
	
end

function checkAudio()

	local p1 = grp_main.players.p1
	local p2 = grp_main.players.p2
	
	if(p1.outcome.text == 'WIN')then
		
		_G.mixer.playSFX('win')
		grp_main.results.title.text = ' ' .. playerNames[1].. ' WINS!'
		_G.gui.setCash( curBet*2 )
		
		_G.achievements.updateAchievement('ceeloWins', curBet)
		
	elseif(p1.outcome.text == 'LOSE')then
		
		_G.mixer.playSFX('lose')
		grp_main.results.title.text = ' ' .. playerNames[2].. ' WINS!'
		
	elseif(p1.outcome.text == 'TIE')then
		
		_G.mixer.playSFX('lose')
		grp_main.results.title.text = ' TIE GAME - PUSH! ' 
		_G.gui.setCash( curBet )
		
	end
	
end

--------------------------- BETTING:

function showDisplay(grp)
	
	transition.to(grp, {time=400, y=grp.endY, transition=easing.outQuad})
	_G.inputPause = false
	local function finishTut()
		tutorialShow(2)
	end
	local info = tutorialShow(1,finishTut)
	if info == nil then
		tutorialShow(2)
	end
end

function hideDisplay(grp)

	transition.to(grp, {time=400, y=grp_main.betting.startY, transition=easing.inQuad})
	
end

--------------------------- SHOP:

function gotoShop(mode)

	_G.gui.showOverlay()
	local myclosure = function() return _G.shop.buildModule(mode) end
	timer.performWithDelay(000, myclosure, 1)
	
end

function onShopClose()

	_G.curModule = _G.ceelo
	_G.inputPause = false
	_G.gui.hideOverlay()
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	print('stop ceelo')
	
end

function killModule()

	_G.mixer.killSFX()
	grp_main:removeSelf()
	grp_main = nil
	
end

