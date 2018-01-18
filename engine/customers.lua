
module(..., package.seeall)

-------------------------- CONSTANTS

local debugMode = false

-------------------------- VARIABLES

local seq = {2,3,4,5,6,7,8,9,1,0,2,3,4,5,6,7,8,9}
local gen = {'m','m','m','m','m','m','f','f','f','f'}
local curNum = 0

-- celebs: 0,1

--------------------------- INIT

function buildArtwork(num)
	
	local anum = nil

	if(num)then
	
		anum = num
		
	else
	
		-- increment
		curNum = curNum + 1
		if( curNum > #seq)then curNum = 1 end
		anum = seq[curNum]
		
	end
	
	print( "Art Work ::::::",curNum )
	print_r(seq)

	-- build character
	local art = buildCharacter( anum )
	art.num = anum
	
	if(debugMode)then
		
		_G.util.addFill(_G.layer_bg, 'bg', .5, .5, .5, 1, 0, 0, 2000, 768)
		_G.util.addFill(_G.layer_bg, 'bg', 1, 1, 0, 1, 0, 0, 4, 768)
		testAnimations(art)
		startPupils(art)
		grp.x = 512
		grp.y = 384
			
	end
	
	-- return 
	return art
	
end

function buildCharacter(num)

	local artwork = display.newGroup()
	
	-- set path number
	local cNum = '' .. num
	if(num < 10)then cNum = '0' .. num end
	
	-- add hair: 
	if( (cNum=='00') or (cNum=='06') or (cNum=='07') )then
		_G.util.addImage('graphics/customers/hair/c' .. cNum .. '.png', artwork, 'hair', 0, -210, 1, 1, 0, 1)
	end
	
	-- add body
	_G.util.addImage('graphics/customers/body/c' .. cNum .. '.png', artwork, 'body', 0, 0, 1, 1, 0, 1)
	artwork.body.anchorY = 1
		
	-- eye whites
	_G.util.addFill(artwork, 'white', 1, 1, 1, 1, 0, -210, 60, 20)
	
	-- add pupils
	_G.util.addGroup(artwork, 'pupils', 0, -210, 1)
	_G.util.addImage('graphics/customers/pupils/c' .. cNum .. '.png', artwork.pupils, 'eyes', 0, 0, 1, 1, 0, 1)
	
	-- add heads
	_G.util.addImage('graphics/customers/head-happy/c' .. cNum .. '.png', artwork, 'happy', 0, -210, 1, 1, 0, 1)
	_G.util.addImage('graphics/customers/head-annoyed/c' .. cNum .. '.png', artwork, 'annoyed', 0, -210, 1, 1, 0, 0)
	_G.util.addImage('graphics/customers/head-angry/c' .. cNum .. '.png', artwork, 'angry', 0, -210, 1, 1, 0, 0)
	
	-- add glasses
	if( cNum=='03' )then
		_G.util.addImage('graphics/customers/other/glasses.png', artwork, 'glasses', -4, -209, 1, 1, 0, 1)
	end
	
	-- adjust by num:
	if( cNum == '00' )then
	
		artwork.white.x = -4
		artwork.white.y = -212
		artwork.happy.x = -8
		artwork.happy.y = -210
		artwork.pupils.x = -5
		artwork.pupils.y = -212
		artwork.hair.x = 2
		artwork.hair.y = -142
		
	end
	if( cNum == '01' )then
	
		artwork.white.x = -4
		artwork.white.y = -212
		artwork.happy.x = -5
		artwork.happy.y = -208
		artwork.pupils.x = -4
		artwork.pupils.y = -213
		
	end
	if( cNum == '02' )then
	
		artwork.white.x = -4
		artwork.white.y = -212
		artwork.happy.x = -5
		artwork.happy.y = -208
		artwork.pupils.x = -4
		artwork.pupils.y = -212
		
	end
	if( cNum == '03' )then
	
		artwork.white.x = -4
		artwork.white.y = -210
		artwork.happy.x = 0
		artwork.happy.y = -209
		artwork.pupils.x = -4
		artwork.pupils.y = -209
		
	end
	if( cNum == '04' )then
	
		artwork.white.x = -3
		artwork.white.y = -210
		artwork.happy.x = -4
		artwork.happy.y = -207
		artwork.pupils.x = -3
		artwork.pupils.y = -211
		
	end
	if( cNum == '05' )then
	
		artwork.white.x = -4
		artwork.white.y = -210
		artwork.happy.x = -4
		artwork.happy.y = -211
		artwork.pupils.x = -5
		artwork.pupils.y = -211
		
	end
	if( cNum == '06' )then
	
		artwork.white.x = -5
		artwork.white.y = -209
		artwork.happy.x = -18
		artwork.happy.y = -208
		artwork.pupils.x = -4
		artwork.pupils.y = -207
		artwork.hair.x = -7
		artwork.hair.y = -145
		
	end
	if( cNum == '07' )then
	
		artwork.white.x = -6
		artwork.white.y = -212
		artwork.happy.x = -6
		artwork.happy.y = -204
		artwork.pupils.x = -6
		artwork.pupils.y = -212
		artwork.hair.x = 0
		artwork.hair.y = -195
		
	end
	if( cNum == '08' )then
	
		artwork.white.x = -6
		artwork.white.y = -210
		artwork.happy.x = -7
		artwork.happy.y = -207
		artwork.pupils.x = -5
		artwork.pupils.y = -207
		
	end
	if( cNum == '09' )then
	
		artwork.white.x = -5
		artwork.white.y = -209
		artwork.happy.x = -5
		artwork.happy.y = -218
		artwork.pupils.x = -3
		artwork.pupils.y = -207
		
	end
	
	-- adjust heads
	artwork.annoyed.x = artwork.happy.x
	artwork.annoyed.y = artwork.happy.y
	artwork.angry.x = artwork.happy.x
	artwork.angry.y = artwork.happy.y
	
	-- save locations
	artwork.happy.baseY = artwork.happy.y
	artwork.white.baseY = artwork.white.y
	artwork.pupils.baseX = artwork.pupils.x
	artwork.pupils.baseY = artwork.pupils.y
	if( artwork.hair )then
		artwork.hair.baseY = artwork.hair.y
	end
	if( artwork.glasses )then
		artwork.glasses.baseY = artwork.glasses.y
	end
	
	-- set mood
	artwork.mood = 'happy'
	
	-- save number
	artwork.num = num
	
	-- set gender
	artwork.gender = gen[num+1]
	
	-- return artwork	
	return artwork
	
end

--------------------------- GET/SET:

function getWaitCountdown()

	return WAIT_COUNTDOWN
	
end

--------------------------- OBJECTS:


--------------------------- EVENTS:

function testAnimations(art)

	local myclosure = function() return changeMood(art, 'annoyed') end
	timer.performWithDelay(1000, myclosure, 1)
	
	local myclosure = function() return changeMood(art, 'angry') end
	timer.performWithDelay(2000, myclosure, 1)
	
	local myclosure = function() return changeMood(art, 'annoyed') end
	timer.performWithDelay(3000, myclosure, 1)
	
	local myclosure = function() return changeMood(art, 'happy') end
	timer.performWithDelay(4000, myclosure, 1)
	
	local myclosure = function() return testAnimations(art) end
	timer.performWithDelay(5000, myclosure, 1)
	
end

function startPupils(art)
	
	local myclosure = function() return movePupils(art) end
	timer.performWithDelay(0000, myclosure, 1)
	
	local rt = math.floor(math.random()*2000) + 2000
	local myclosure = function() return startPupils(art) end
	
	art.pupilTimer = timer.performWithDelay(rt, myclosure, 1)
		
end

function changeMood(art, mood)
	
	-- check for repeat
	if( art.mood == mood )then return end

	-- stop current transitions
	transition.cancel(art.happy)
	transition.cancel(art.annoyed)
	transition.cancel(art.angry)
	transition.cancel(art.pupils)
	if(art.hair)then transition.cancel(art.hair) end
	if(art.glasses)then transition.cancel(art.glasses) end

	-- determine mood
	local tTime = 500
	local yMod
	local aMax = 0
		
	if( mood == 'happy' )then
	
		art.happy.alpha = 1
		art.annoyed.alpha = 0
		art.angry.alpha = 0
		yMod = 0
		aMax = 8
		
	end

	if( mood == 'annoyed' )then
	
		art.happy.alpha = 0
		art.annoyed.alpha = 1
		art.angry.alpha = 0
		yMod = 3
		aMax = 5
		
	end
	
	if( mood == 'angry' )then
	
		art.happy.alpha = 0
		art.annoyed.alpha = 0
		art.angry.alpha = 1
		yMod = 6
		aMax = 5
		
	end
	
	-- play audio
	local rA = math.floor( math.random() * aMax ) + 1
	local aN = art.gender .. '_' .. mood .. '_' .. rA
	if(mood ~='happy')then _G.mixer.playSFX(aN) end
	
	-- animate
	transition.to(art.white, 	{delay=000, time=tTime, y=art.white.baseY + yMod, transition=easing.inOutQuad})
	transition.to(art.happy, 	{delay=000, time=tTime, y=art.happy.baseY + yMod, transition=easing.inOutQuad})
	transition.to(art.annoyed, 	{delay=000, time=tTime, y=art.happy.baseY + yMod, transition=easing.inOutQuad})
	transition.to(art.angry, 	{delay=000, time=tTime, y=art.happy.baseY + yMod, transition=easing.inOutQuad})
	transition.to(art.pupils, 	{delay=000, time=tTime, y=art.pupils.baseY + yMod, x=art.pupils.baseX, transition=easing.inOutQuad})
	
	if( art.hair )then
		
		transition.to(art.hair, 	{delay=000, time=500, y=art.hair.baseY + yMod, transition=easing.inOutQuad})
		
	end
	if( art.glasses )then
		
		transition.to(art.glasses, 	{delay=000, time=500, y=art.glasses.baseY + yMod, transition=easing.inOutQuad})
		
	end
	
	-- save mood
	art.mood = mood
	
end

function movePupils(art)

	local tTime = 500
	local newX, newY
	
	transition.cancel(art.pupils.eyes)

	local rd = math.floor(math.random()*4) + 1
	if( rd==1 )then
		
		newX = 0
		newY = 0
		
	end
	if( rd==2 )then
		
		newX = 1
		newY = 1
		
	end
	if( rd==3 )then
		
		newX = -1
		newY = 1
		
	end
	if( rd==4 )then
		
		newX = -1
		newY = -1
		
	end
	if( rd==5 )then
		
		newX = 1
		newY = -1
		
	end
	
	transition.to(art.pupils.eyes, {delay=000, time=tTime, x=newX, y=newY, transition=easing.inOutQuad})
	
end

function prepForExit(art)

	if( art.pupilTimer )then
	
		timer.cancel(art.pupilTimer)
		
	end

	transition.cancel(art.white)
	transition.cancel(art.happy)
	transition.cancel(art.annoyed)
	transition.cancel(art.angry)
	transition.cancel(art.pupils)
	if(art.hair)then transition.cancel(art.hair) end
	if(art.glasses)then transition.cancel(art.glasses) end
	transition.cancel(art.pupils.eyes)
	
	transition.to(art.pupils.eyes, {delay=000, time=200, x=0, y=0, transition=easing.inOutQuad})
	
end

function highlight(art, mode)

	if(not art)then return end

	for i=1, art.numChildren do
	
		local img = art[i]
		if(img.id == 'pupils')then img = art[i].eyes end
		
		if(mode==true)then
			
			--img:setFillColor(1,0,0)
			
			--img.fill.effect = "filter.bloom"
			--img.fill.effect.levels.white = 1.0
			
			img.fill.effect = "filter.exposure"
			img.fill.effect.exposure = 0.5
			
			--img.fill.effect = "filter.brightness"
			--img.fill.effect.intensity = 0.15
			
		end
		
		if(mode==false)then
			
			img.fill.effect = nil
			
		end
		
		
	end
	
end
