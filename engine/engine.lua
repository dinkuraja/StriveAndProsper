
module(..., package.seeall)

-------------------------- CONSTANTS

local RETURN_THRESH = 16
local AUTO_COUNTDOWN = 360
local SIDE_COUNTDOWN = 360
local COOK_COUNTDOWN = 270
local DECAY_COUNTDOWN = 600
local WAIT_REWARD = 600
local OBJECT_THRESH = 30
local CUSTOMER_START_DELAY = 8000
local CUSTOMER_THRESH = 100
local CUSTOMER_OFFSET = 1400
local STENCIL_COUNTDOWN = 300
local TOTAL_CUSTOMERS = 16
local TIP_MAX = 5
local call = true
local decayItemTut = false
local decItemCall = false
local drinkReady = false
local customerEnter = false
local fCallPatty = false
local checkTutFlagVal = true

local drinkFirstCall = true

-------------------------- UPGRADABLE VALUES

local CUSTOMER_RETURN_TIME = 7000
local WAIT_COUNTDOWN = 2400
local TIP_PERCENT = .50
local HIDDEN_CUSTOMERS = 0

-------------------------- VARIABLES

local grp_main


local dragObject = nil
local returnObjects = {}
local countdownObjects = {}

local curCustomer = 0
local curServed = 0
local custDisabled = 0
local curTips = 0
local curCash = 0
local curEarnings = 0
local curSuccess = 0
local curLost = 0

local level = nil
local levelData = nil
local activeRequestMatch = nil
local levelData = nil

local isPaused = false
local allObjects = {}
local upgradeJump = false

local curTrack = 1
local itemsTrashed = 0

local tutObject
local firstTutorial = false
--------------------------- INIT

function buildModule(num, replay)
	
	-- _G.gui.unSetAtionPerform()

	-- init vars
	dragObject = nil
	returnObjects = {}
	countdownObjects = {}
	allObjects = {}
	
	-- get level info:
	local snum = '' .. num
	if( num < 10 )then snum = '0' .. num end
	local path = "info.levelData.level" .. snum .. ".levelInfo"
	local levelClass = require( path )
	_G.levelInfo = levelClass.getData()
	package.loaded[ path ] = nil
    _G[ path ] = nil

	-- build main:
	if( grp_main )then
		
		grp_main:removeSelf()
		grp_main = nil
		
	end
	grp_main = util.addGroup(_G.layer_stage, 'grp_main', 0, 0, 1)

	-- buildLevelLayout:
	_G.mixer.loadSFX('level'..num)

	_G.curLevelNum = num
	allObjects = {}
	buildLevel(num)
	print( "New Lelvel Data :::: ",_G.curLevelNum )

	print(":::: number :::: ",num )


	-- buildCustomers:
	level.buildCustomers(grp_main)
	
	-- add drag layer:
	if( _G.layer_stage.drag )then
		
		_G.layer_stage.drag:removeSelf()
		_G.layer_stage.drag = nil
		
	end
	util.addGroup(_G.layer_stage, 'drag', 0, 0, 1)

	-- enable dragging:
	Runtime:addEventListener('touch', onScreenTouch)
	
	-- enable renderer:
	Runtime:addEventListener('enterFrame', onEnterFrame)
	
	-- add gui:
	_G.gui.buildModule(grp_main, "engine")
	curCustomer = 0
	curServed = 0
	curSuccess = 0
	curTips = 0
	curEarnings = 0
	curCash = 0
	curLost = 0
	
	-- set module:
	setEnginePause(true)
	_G.curModule = _G.engine

	-- show level select
	if(replay)then
	
		setLevelInfo(_G.curStageNum)
		buildLevelItems()
		startLevel()
		
	else
		if( upgradeJump )then
			
			local myclosure = function() return _G.upgrades.buildModule() end
			timer.performWithDelay(0, myclosure, 1)
			upgradeJump = false
			
		else
		
			local myclosure = function() return _G.levelselect.buildModule(true) end
			timer.performWithDelay(0, myclosure, 1)
			
			--local myclosure = function() return _G.levelselect.forceOpen() end
			--timer.performWithDelay(610, myclosure, 1)
			
		end
		
	end

	-- hide loader
	_G.loader.hideLoader()
	
end

--------------------------- GET/SET:

function getWaitCountdown()

	return WAIT_COUNTDOWN
	
end

function setEnginePause(mode)

	isPaused = mode
	
end

function getResultsValues()

	local values = {}
	values.totalCustomers = TOTAL_CUSTOMERS
	values.curCustomer = curCustomer
	values.curServed = curServed
	values.curTips = curTips
	values.curEarnings = curEarnings
	values.curCash = curCash
	values.curLost = curLost
	
	return values
	
end

function setLevelInfo(num)
	
	-- store num
	_G.curStageNum = num
	
	-- testing
	if( (_G.curLevelNum == 4) and (_G.curStageNum >= 10 ) )then
	
		--num = 10
		
	end
	
	-- set string values
	local snum = '' .. num
	if( num < 10 )then snum = '0' .. num end
	local cnum = '' .. _G.curLevelNum
	if( _G.curLevelNum < 10 )then cnum = '0' .. _G.curLevelNum end
	
	-- load module, get data, unload module
	local path = "info.levelData.level" .. cnum .. ".level" .. snum	
	local levelClass = require( path )
	levelData = levelClass.getData()
	package.loaded[ path ] = nil
        _G[ path ] = nil
	
	-- reset upgradable variables
	WAIT_COUNTDOWN = 2400
	CUSTOMER_RETURN_TIME = 6000
	TIP_PERCENT = .50
	HIDDEN_CUSTOMERS = 0
	
	-- inject values
	level.setLevelData( levelData )
	
	-- set gui
	gui.setLevelData( levelData )
	
	-- update vars
	TOTAL_CUSTOMERS = #levelData.orders - HIDDEN_CUSTOMERS
	
end

function setUpgradableVars(vars)

	local tiptime = vars[1]*60
	local waittime = vars[2]*60
	local tipamt = vars[3]*.01
	local extras = vars[4]
	
	WAIT_COUNTDOWN = WAIT_COUNTDOWN+tiptime
	CUSTOMER_RETURN_TIME = CUSTOMER_RETURN_TIME+waittime
	TIP_PERCENT = TIP_PERCENT+tipamt
	--HIDDEN_CUSTOMERS = HIDDEN_CUSTOMERS+extras
	
	print('adjusted interiors')
	print('tiptime: ' .. WAIT_COUNTDOWN )
	print('waittime: ' .. CUSTOMER_RETURN_TIME )
	print('tipamt: ' .. TIP_PERCENT )
	print('extras: ' .. HIDDEN_CUSTOMERS )
	
end

function updateCountdownItems()

	print('update countdowns')

	local newList = {}
	for i=1, #countdownObjects do
		
		local obj = countdownObjects[i]
		if(obj.food)then
		
			newList[#newList+1] = obj
			
		end
		
	end
	countdownObjects = newList
	
end

--------------------------- LEVELS:

function buildLevel(num)

	_G.TutorialData.checkTutorialLevelData()

	print( "Lavel NUmber is :::: ", num )
	level = require("engine.levels.level"..num)
	level.buildLevel(grp_main)
	
	-- load audio
	_G.mixer.loadMusic('loc' .. num .. '_01')
	curTrack = curTrack + 1
	if( curTrack>2 )then
		curTrack = 1
	end
		
end
function startLevel()
	isLevelView = false
	drinkFirstCall = true
	call = true
	decayItemTut = false
	decItemCall = false
	drinkReady = false
	customerEnter = false
	fCallPatty = false
	checkTutFlagVal = true

	_G.TutorialData.checkTutorialLevelData()

	-- reset all objects
	for i=1, #allObjects do
	
		resetObject( allObjects[i] )
		
	end

	-- toggle gui
	_G.gui.setGui('engine')

	-- unpause engine
	_G.gui.hideOverlay()
	setEnginePause(false)

	-- show customers
	local cList = grp_main.customers.cList
	local delayer = 1000

	-- type = 1,2,3,4
	-- type 1 = create
	-- type 2 = pause
	-- type 3 = resume
	-- type 4 = reGenerate ( If id is expire )
	local function customerTimerSettings( type )
		type = type or 1
		if cList then
			if type == 1 then
				for i=1, #cList do
					local myclosure = function() 
						cList[i].timerFlag = "finish"
						cList[i].value = 0
						return _G.engine.resetCustomer(cList[i])
					end
					cList[i].curTimer = timer.performWithDelay(delayer, myclosure, 1)
					cList[i].timerFlag = "play"
					cList[i].value = delayer
					delayer = delayer + CUSTOMER_START_DELAY
				end
			elseif type == 2 then
				for i=1, #cList do
					if cList[i].timerFlag == "play" then
						cList[i].timerFlag = "pause"
			            -- print( "For loop:: Come here...." )
			            cList[i].value = timer.pause( cList[i].curTimer )
			            print( i,"--------- Timer Pause Time ::: ",cList[i].value," -----" )
			        end
		        end
		    elseif type == 3 then
				for i=1, #cList do
					-- timer.cancel(cList[i].curTimer)
					if cList[i].timerFlag == "pause" then
	                    -- print( "For loop:: Come here...." )
	                    cList[i].timerFlag = "play"
	                    local timerResume = timer.resume( cList[i].curTimer )
	                    if timerResume == 0 then
	                    	local myclosure = function()
								cList[i].timerFlag = "finish"
								cList[i].value = 0
								return _G.engine.resetCustomer(cList[i])
							end
							-- print( "Not Receive",i )
							cList[i].curTimer = timer.performWithDelay(cList[i].value, myclosure, 1)
							cList[i].timerFlag = "play"
	                    end
	                    print( i,"--------- Timer Resume Time ::: ",timerResume," -----" )
	                end
                end
		    elseif type == 4 then

			end
		end
	end

	customerTimerSettings( 1 )
	
	-- reset drinks (loc3 exception)
	if( _G.curLevelNum==3 )then
		
		if(_G.curStageNum<8)then
		
			print('no water')
		
		else
		
			print('play water')
	
			_G.mixer.playLoop('pour')
			_G.mixer.playSFX('pour_start')
			_G.mixer.playSFX('start')
		
		end
		
	end
	
	-- reset drinks (loc4 exception)
	if( _G.curLevelNum==4 )then
		
		if(_G.curStageNum<4)then
		
			print('no water')
		
		else
		
			print('play water')
	
			_G.mixer.playLoop('pour')
			_G.mixer.playSFX('pour_start')
			_G.mixer.playSFX('start')
		
		end
		
	end

	-- audio
	_G.mixer.playMusic()
        
        customerTimerSettings( 2 )

        local curTutI = 3
        print("Stage and level of game",_G.curLevelNum,_G.curStageNum)
        if _G.curStageNum == 10 and _G.curLevelNum == 2 then
        	curTutI = 11
        elseif _G.curStageNum == 15 and _G.curLevelNum == 2 then
        	curTutI = 13
        elseif _G.curStageNum == 18 and _G.curLevelNum == 2 then
        	curTutI = 15
        elseif _G.curStageNum == 1 and _G.curLevelNum == 3 then
        	curTutI = 1
        elseif _G.curStageNum == 4 and _G.curLevelNum == 3 then
        	curTutI = 7
        elseif _G.curStageNum == 6 and _G.curLevelNum == 3 then
        	curTutI = 8
        elseif _G.curStageNum == 8 and _G.curLevelNum == 3 then
        	curTutI = 9
       	elseif _G.curStageNum == 11 and _G.curLevelNum == 3 then
        	curTutI = 10
        elseif _G.curStageNum == 1 and _G.curLevelNum == 5 then
        	curTutI = 1
        elseif _G.curStageNum == 4 and _G.curLevelNum == 5 then
        	curTutI = 9
        elseif _G.curStageNum == 10 and _G.curLevelNum == 5 then
        	curTutI = 11
       	elseif _G.curStageNum == 12 and _G.curLevelNum == 5 then
        	curTutI = 13
        end

		local function callLevel5Tutorial(option)
        	local function finishTut5()
            	print( "Finish Tutorial 1.... " )
            	_G.loadsave.print_r(option)
            	tutObject = nil
                if option.nextCall then
                	print( "----:4 Finish Tutorial 2 :----- " )
		            print_r( option )
                	if option.lastCall >= option.nextCall then
                		option.id = option.nextCall
                		option.nextCall = option.nextCall + 1
                		_G.loadsave.print_r(option)
                		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                	else
                		if  option.otehrCall then
		            		option.id = option.otehrCall
		            		-- option.nextCall = nil
		            		-- option.lastCall = nil
		            		option.otehrCall = nil
							print( "----:4 Finish Tutorial 5 :----- " )
		            		print_r( option )
		            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                		else
                			print( "----:4 Finish Tutorial 6 :----- " )
			                customerTimerSettings( 3 )
			            end
				    end
                else
                	print( "----:4 Finish Tutorial 7 :----- " )
                	if option.otehrCall then
                		print( "----:4 Finish Tutorial 8 :----- " )
	            		option.id = option.otehrCall
	            		option.nextCall = nil
	            		option.lastCall = nil
	            		option.otehrCall = nil
	            		_G.loadsave.print_r(option)
	            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option) end)
            		else
            			print( "----:4 Finish Tutorial 9 :----- " )
	                	customerTimerSettings( 3 )
		            end
                end
            end
        	local info = level.setTutorial(option.id,finishTut5)
        	-- print( "Check Info..."  )
        	-- print_r(info)
        	if info ~= nil then
        		print( "Set Info...." )
        		print_r(info.passData)
        		tutObject = info.passData
        	else
        		print( "info nillllll...." )
        		if option.nilCall then
        			tutObject = nil
        			option.id = option.nilCall
        			option.nilCall = nil
        			timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
        		else
        			print( "----:4 Finish Tutorial 6 :----- " )
            		customerTimerSettings( 3 )
        			tutObject = nil
        		end
        	end
        	print( "------Show tutObj------" )
        	print_r(tutObject)
        	if info then
        		return true
        	else
				return false
        	end
        end

        local function callLevel4Tutorial(option)
        	local function finishTut4()
            	print( "Finish Tutorial 1.... " )
            	_G.loadsave.print_r(option)
            	tutObject = nil
                if option.nextCall then
                	print( "----:4 Finish Tutorial 2 :----- " )
		            print_r( option )
                	if option.lastCall >= option.nextCall then
                		option.id = option.nextCall
                		option.nextCall = option.nextCall + 1
                		_G.loadsave.print_r(option)
                		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                	else
                		if  option.otehrCall then
		            		option.id = option.otehrCall
		            		-- option.nextCall = nil
		            		-- option.lastCall = nil
		            		option.otehrCall = nil
							print( "----:4 Finish Tutorial 5 :----- " )
		            		print_r( option )
		            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                		else
                			print( "----:4 Finish Tutorial 6 :----- " )
			                customerTimerSettings( 3 )
			            end
				    end
                else
                	print( "----:4 Finish Tutorial 7 :----- " )
                	if option.otehrCall then
                		print( "----:4 Finish Tutorial 8 :----- " )
	            		option.id = option.otehrCall
	            		option.nextCall = nil
	            		option.lastCall = nil
	            		option.otehrCall = nil
	            		_G.loadsave.print_r(option)
	            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option) end)
            		else
            			print( "----:4 Finish Tutorial 9 :----- " )
	                	customerTimerSettings( 3 )
		            end
                end
            end
        	local info = level.setTutorial(option.id,finishTut4)
        	-- print( "Check Info..."  )
        	-- print_r(info)
        	if info ~= nil then
        		print( "Set Info...." )
        		print_r(info.passData)
        		tutObject = info.passData
        	else
        		print( "info nillllll...." )
        		if option.nilCall then
        			tutObject = nil
        			option.id = option.nilCall
        			option.nilCall = nil
        			timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
        		else
        			print( "----:4 Finish Tutorial 6 :----- " )
            		customerTimerSettings( 3 )
        			tutObject = nil
        		end
        	end
        	print( "------Show tutObj------" )
        	print_r(tutObject)
        	if info then
        		return true
        	else
				return false
        	end
        end

        local function callLevel3Tutorial(option)
        	local function finishTut3()
            	print( "3Finish Tutorial 1.... ",option.id )
            	_G.loadsave.print_r(option)
            	tutObject = nil
                if option.nextCall then
                	print( "----:3 Finish Tutorial 2 :----- " )
		            print_r( option )
                	if option.lastCall >= option.nextCall then
                		option.id = option.nextCall
                		option.nextCall = option.nextCall + 1
                		_G.loadsave.print_r(option)
                		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                	else
                		if  option.otehrCall then
		            		option.id = option.otehrCall
		            		-- option.nextCall = nil
		            		-- option.lastCall = nil
		            		option.otehrCall = nil
							print( "----:3 Finish Tutorial 5 :----- " )
		            		print_r( option )
		            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                		else
                			print( "----:3 Finish Tutorial 6 :----- " )
			                customerTimerSettings( 3 )
			            end
				    end
                else
                	print( "----:3 Finish Tutorial 7 :----- " )
                	if option.otehrCall then
                		print( "----:3 Finish Tutorial 8 :----- " )
	            		option.id = option.otehrCall
	            		option.nextCall = nil
	            		option.lastCall = nil
	            		option.otehrCall = nil
	            		_G.loadsave.print_r(option)
	            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option) end)
            		else
            			print( "----:3 Finish Tutorial 9 :----- " )
	                	customerTimerSettings( 3 )
		            end
                end
            end
        	local info = level.setTutorial(option.id,finishTut3)
        	-- print( "Check Info..."  )
        	-- print_r(info)
        	if info ~= nil then
        		print( "Set Info...." )
        		print_r(info.passData)
        		tutObject = info.passData
        	else
        		print( "info nillllll...." )
        		if option.nilCall then
        			tutObject = nil
        			option.id = option.nilCall
        			option.nilCall = nil
        			timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
        		else
        			print( "----:3 Finish Tutorial 6 :----- " )
            		customerTimerSettings( 3 )
        			tutObject = nil
        		end
        	end
        	print( "------Show tutObj------" )
        	print_r(tutObject)
        	if info then
        		return true
        	else
				return false
        	end
        end

        local function callLevel2Tutorial(option)
        	local function finishTut2()
            	print( "Finish Tutorial 1.... " )
            	_G.loadsave.print_r(option)
            	tutObject = nil
                if option.nextCall then
                	print( "----:2 Finish Tutorial 2 :----- " )
		            print_r( option )
                	if option.lastCall >= option.nextCall then
                		option.id = option.nextCall
                		option.nextCall = option.nextCall + 1
                		_G.loadsave.print_r(option)
                		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                	else
                		if  option.otehrCall then
		            		option.id = option.otehrCall
		            		-- option.nextCall = nil
		            		-- option.lastCall = nil
		            		option.otehrCall = nil

		            		if option.id == 6 then
		            			option.nextCall = 24
		            			option.lastCall = 24
		            		end

							print( "----:2 Finish Tutorial 5 :----- " )
		            		print_r( option )
		            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                		else
                			print( "----:2 Finish Tutorial 6 :----- " )
	                		customerTimerSettings( 3 )
			            end
				    end
                else
                	print( "----:2 Finish Tutorial 7 :----- " )
                	if option.otehrCall then
                		print( "----:2 Finish Tutorial 8 :----- " )
	            		option.id = option.otehrCall
	            		option.nextCall = nil
	            		option.lastCall = nil
	            		option.otehrCall = nil
	            		_G.loadsave.print_r(option)
	            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option) end)
            		else
            			print( "----:2 Finish Tutorial 9 :----- " )
	                	customerTimerSettings( 3 )
		            end
                end
            end
        	local info = level.setTutorial(option.id,finishTut2)
        	-- print( "Check Info..."  )
        	-- print_r(info)
        	if info ~= nil then
        		print( "Set Info...." )
        		print_r(info.passData)
        		tutObject = info.passData
        	else
        		print( "info nillllll...." )
        		if option.nilCall then
        			tutObject = nil
        			option.id = option.nilCall
        			option.nilCall = nil
        			timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
        		else
        			tutObject = nil
        			print( "----:2 Finish Tutorial 6 :----- " )
            		customerTimerSettings( 3 )
        		end
        	end
        	print( "------Show tutObj------" )
        	print_r(tutObject)
        	if info then
        		return true
        	else
				return false
        	end
        end

        local function callLevel1Tutorial(option)
        	local function finishTut1()
            	print( "Finish Tutorial 1.... " )
            	_G.loadsave.print_r(option)
            	tutObject = nil
                if option.nextCall then
                	print( "----:1 Finish Tutorial 2 :----- " )
		            print_r( option )
                	if option.lastCall >= option.nextCall then
                		option.id = option.nextCall
                		option.nextCall = option.nextCall + 1
                		_G.loadsave.print_r(option)
                		print( "Drink Is Ready1 ::::: ",drinkReady )
                		if drinkReady and option.id == 32 then
                			option = {
					    		id = 1,
					    		nextCall = 13,
					    		lastCall = 13,
					    	}
                		end
                		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                	else
                		if  option.otehrCall then
		            		option.id = option.otehrCall
		            		-- option.nextCall = nil
		            		-- option.lastCall = nil
		            		option.otehrCall = nil
							print( "----:1 Finish Tutorial 5 :----- " )
		            		print_r( option )
		            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
                		else
                			print( "----:1 Finish Tutorial 6 :----- " )
	                		customerTimerSettings( 3 )
			            end
				    end
                else
                	print( "----:1 Finish Tutorial 7 :----- " )
                	if option.otehrCall then
                		print( "----:1 Finish Tutorial 8 :----- " )
	            		option.id = option.otehrCall
	            		option.nextCall = nil
	            		option.lastCall = nil
	            		option.otehrCall = nil
	            		_G.loadsave.print_r(option)
	            		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
            		else
            			print( "----:1 Finish Tutorial 9 :----- " )
	                	customerTimerSettings( 3 )
		            end
                end
            end
            if option.id == 28 then
            	decayItemTut = true
            end
        	local info = level.setTutorial(option.id,finishTut1)
        	-- print( "Check Info..."  )
        	-- print_r(info)
        	if info ~= nil then
        		print( "Set Info...." )
        		print_r(info.passData)
        		tutObject = info.passData
        	else
        		print( "info nillllll...." )
        		if option.nilCall then
        			tutObject = nil
        			option.id = option.nilCall
        			option.nilCall = nil
        			print(option.id == 25,option.id)
        			if option.id == 25 then
        				decItemCall = true
        				option.id = 25
        				option.nextCall = 27
        				option.lastCall=28
        			end
        			timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
        		else
        			print( "----:1 Finish Tutorial 6 :----- " )
            		customerTimerSettings( 3 )
        			tutObject = nil
        		end
        	end
        	print( "------Show tutObj------" )
        	print_r(tutObject)
        	if info then
        		return true
        	else
				return false
        	end
        end

        customerTimerSettings( 2 )

        function checkDataFunction( outterCall, xPass, yPass, parentPass, option )
        	print( "----- Current Level ::::: ",_G.curLevelNum, "Outter Call :::: ", outterCall, "-----" )
        	print_r(option)
        	if option then
	        	if _G.curLevelNum == 1 then
        			customerTimerSettings( 2 )
        			if callLevel1Tutorial( option ) then
        				return
        			end
	        	elseif _G.curLevelNum == 2 then
        			customerTimerSettings( 2 )
        			if callLevel2Tutorial( option ) then
        				return
        			end
	        	elseif _G.curLevelNum == 4 then
        			customerTimerSettings( 2 )
        			if callLevel4Tutorial( option ) then
        				return
        			end
        		elseif _G.curLevelNum == 5 then
        			customerTimerSettings( 2 )
        			if callLevel5Tutorial( option ) then
        				return
        			end
        		elseif _G.curLevelNum == 3 then
        			customerTimerSettings( 2 )
        			if callLevel3Tutorial( option ) then
        				return
        			end
        		end
        	else
	        	print( outterCall,xPass,yPass,parentPass )
	        	print_r(option)
	        	if outterCall == nil then
	        		customerTimerSettings( 3 )
			    else
			    	if  _G.curStageNum == 1 and _G.curLevelNum == 4 and outterCall ~= 0 then
		            	--print( "Come Here....." )
		            	--print( "_____-13 Number2-______" )
		            	local function finishTut()
		                	--print( "Come to finish Tutorial  function.... ",curTutI )
		                    curTutI = curTutI + 1
		                    checkDataFunction( 0 )
		                end
		                customerTimerSettings( 2 )
		                level.setTutorial(outterCall,finishTut)
		            elseif  _G.curStageNum == 15 and _G.curLevelNum == 4 and outterCall ~= 0 then
		            	--print( "Come Here....." )
		            	--print( "_____-13 Number2-______" )
		            	local function finishTut()
		                	--print( "Come to finish Tutorial  function.... ",curTutI )
		                    curTutI = curTutI + 1
		                    checkDataFunction( 0 )
		                end
		                customerTimerSettings( 2 )
		                level.setTutorial(outterCall,finishTut)
				    else
				    	customerTimerSettings( 3 )
				    end
			    end
			end
		    if info ~= nil then
        		tutObject = info.passData
        	else
        		tutObject = nil
        		customerTimerSettings( 3 )
        	end
        end
        print( _G.curStageNum, _G.curLevelNum)

        --local info = level.setTutorial(3)
        if _G.curStageNum == 1 and _G.curLevelNum == 1 then
        	checkDataFunction(nil,nil,nil,nil,{id = 16})
        elseif _G.curStageNum == 11 and _G.curLevelNum == 1 then
        	checkDataFunction(nil,nil,nil,nil,{id = 10})
       	elseif _G.curStageNum == 12 and _G.curLevelNum == 1 then
        	checkDataFunction(nil,nil,nil,nil,{id = 11})
        elseif _G.curStageNum == 5 and _G.curLevelNum == 1 then
        	checkDataFunction(nil,nil,nil,nil,{id = 23,nextCall = 9,lastCall = 9})
        elseif _G.curStageNum == 1 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 17})
        elseif _G.curStageNum == 18 and _G.curLevelNum == 1 then
        	checkDataFunction(nil,nil,nil,nil,{id = 24})
        elseif _G.curStageNum == 4 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 25,nextCall=7,lastCall=7})
        elseif _G.curStageNum == 7 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 26,nextCall=9,lastCall=9})
        elseif _G.curStageNum == 11 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 27,nextCall=11,lastCall=11,otehrCall=28})
        elseif _G.curStageNum == 15 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 13})
        elseif _G.curStageNum == 18 and _G.curLevelNum == 2 then
        	checkDataFunction(nil,nil,nil,nil,{id = 15})
        elseif _G.curStageNum == 1 and _G.curLevelNum == 4 then
        	checkDataFunction(nil,nil,nil,nil,{id = 20,nextCall = 42, lastCall = 42})
        elseif _G.curStageNum == 4 and _G.curLevelNum == 4 then
        	checkDataFunction(nil,nil,nil,nil,{id = 1})
        elseif _G.curStageNum == 6 and _G.curLevelNum == 4 then
        	checkDataFunction(nil,nil,nil,nil,{id = 6})
        elseif _G.curStageNum == 10 and _G.curLevelNum == 4 then
        	checkDataFunction(nil,nil,nil,nil,{id = 13})
      	elseif _G.curLevelNum == 4 and _G.curStageNum == 11 then
      		checkDataFunction(nil,nil,nil,nil,{id = 16})
      	elseif _G.curLevelNum == 4 and _G.curStageNum == 12 then
      		checkDataFunction(nil,nil,nil,nil,{id = 17})
      	elseif _G.curLevelNum == 4 and _G.curStageNum == 15 then
      		checkDataFunction(nil,nil,nil,nil,{id = 18})
      	elseif _G.curLevelNum == 5 and _G.curStageNum == 1 then
      		checkDataFunction(nil,nil,nil,nil,{id = 15,nextCall = 26,lastCall = 26})
      	-- elseif _G.curLevelNum == 5 and _G.curStageNum == 3 then
      	-- 	checkDataFunction(nil,nil,nil,nil,{id = 2})
      	elseif _G.curLevelNum == 5 and _G.curStageNum == 7 then
      		local option = {
      			id = 22,
      			nextCall = 12,
      			lastCall = 12,
      		}
      		checkDataFunction(nil,nil,nil,nil,option)
      	elseif _G.curLevelNum == 5 and _G.curStageNum == 9 then
      		local option = {
      			id = 11
      		}
      		checkDataFunction(nil,nil,nil,nil,option)
      	elseif _G.curLevelNum == 5 and _G.curStageNum == 4 then
      		local option = {
      			id = 9
      		}
      		checkDataFunction(nil,nil,nil,nil,option)
      	elseif _G.curLevelNum == 3 and _G.curStageNum == 1 then
      		checkDataFunction(nil,nil,nil,nil,{id = 12})
      	elseif _G.curLevelNum == 3 and _G.curStageNum == 4 then
      		checkDataFunction(nil,nil,nil,nil,{id = 17})
      	elseif _G.curLevelNum == 3 and _G.curStageNum == 6 then
      		checkDataFunction(nil,nil,nil,nil,{id = 16})
      	elseif _G.curLevelNum == 3 and _G.curStageNum == 8 then
      		checkDataFunction(nil,nil,nil,nil,{id = 9})
        else
        	checkDataFunction()
        end
        -- customerTimerSettings( 3 )
	-- set module
	_G.curModule = _G.engine
	
end

function endLevel()
	
	audio.stop()
	stopModule()
	killModule()
	_G.map.buildModule()
	
end

function resetLevel(jumpToUpgrades)

	if(jumpToUpgrades)then
	
		upgradeJump = true
		
	end
	audio.stop()
	stopModule()
	killModule()
	buildModule(_G.curLevelNum)
	
end

function replayLevel()

	audio.stop()
	stopModule()
	killModule()
	buildModule(_G.curLevelNum, true)
	
end

function buildLevelItems()

	level.buildItems()
	
end

--------------------------- CUSTOMERS:

function buildCustomer()

	local c = display.newGroup()
	
	_G.util.addFill(c, 'hit', 1, 1, 0, .01, 0, 0, 250, 250)
	
	local body = _G.util.addGroup(c, 'body', -64, 20, 1)
	
	-- over
	_G.util.addFill(body, 'over', 1, 1, 1, .5, 	0, 0, 124, 230)
	body.over.alpha = 0
	c.over = body.over
	c.over.isVisible = false
	
	-- request window
	local request = _G.util.addGroup(c, 'request', 44, -50, 1)
	_G.util.addImage('graphics/customers/request.png', request, 'bg', 0, 0, 1, 1, 0, 1)
	request.xScale = .001
	request.yScale = request.xScale
	
	local bars = _G.util.addGroup(request, 'bars', -33, -2, 1)
	 _G.util.addFill(bars, 'blue', 40/255, 46/255, 104/255, 1, 0, 0, 20, 200-12)
	local masker = graphics.newMask('graphics/customers/masker.png')
	bars:setMask(masker)
	
	local bar = _G.util.addFill(bars, 'bar', 0, 1, 0, 1, 0, 0, 20, 200-12)
	request.bar = bar
	
	request.bar.anchorY = 1
	request.bar.x = 0
	request.bar.y = 94
	
	-- requests holder
	local request = _G.util.addGroup(c, 'requests', 0, 0, 1)
	c.mode = 'customer'
	c.countDown = WAIT_COUNTDOWN
	c.countDelay = WAIT_COUNTDOWN

	return c
	
end

function evaluateOrder(obj, targ)
	
	local f
	local isValid = false
	
	for i=1, targ.requests.numChildren do
	
		f = targ.requests[i]
		--print(f.food, obj.food)
		
		if( obj.food == f.food )then
		
			if( obj.food == 'meal' )then
				
				if( (obj.meat) and ( obj.color == f.color ) and ( obj.topping1 == f.topping1 ) and ( obj.topping2 == f.topping2 ) and ( obj.topping3 == f.topping3 )  and ( obj.cooker == f.cooker ) )then
				
					isValid = true
					activeRequestMatch = f
					
				end
				
				if( obj.order )then
				
					print(obj.order, f.order)
				
					if(f.order == obj.order )then
						
						isValid = true
						activeRequestMatch = f
						
					end
					
				end
				
			elseif( obj.food == 'clothes' )then
				
				-- check color, icon color, letter
				if( ( obj.color == f.color ) and ( obj.icon.color == f.icon.color ) and ( obj.letter == f.letter ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end				
			
			elseif( obj.food == 'side' )then
				
				--print(obj.color, f.color)
				
				-- check color
				if( ( obj.color == f.color ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end				
			
			elseif( obj.food == 'shoes' )then
				
				--print(obj.color, f.color)
				
				-- check color
				if( ( obj.color == f.color ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end
							
			elseif( obj.food == 'topping' )then
				
				--print(obj.color, f.color)
				
				-- check color
				if( ( obj.color == f.color ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end	
				
			elseif( obj.food == 'volume' )then
				
				print(obj.color, f.color)
				
				-- check color
				if( ( obj.color == f.color ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end	
			
			elseif( obj.food == 'instrument' )then
				
				-- check letter
				if( ( obj.letter == f.letter ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end				
			
			elseif( obj.food == 'cd' )then
				
				-- check letter
				if( ( obj.icon.color == f.icon.color ) )then
					
					isValid = true
					activeRequestMatch = f
					
				end				
			
			elseif( obj.food == 'drink' )then
				
				--print('drink...')
				
				-- check letter
				if( obj.drinktype )then
					
					if( obj.drinktype == f.drinktype )then
						
						isValid = true
						activeRequestMatch = f
						
					end

				else
					
					isValid = true
					activeRequestMatch = f
					
				end				
			
			else
				
				isValid = true
				activeRequestMatch = f
				
			end
			
		end
		
	end
	
	return isValid
	
end

function removeRequest(obj, targ)

	local f
	local didHit = false
	
	-- turn off highlight
	_G.customers.highlight(targ.body.art, false)
	
	-- evaluate cost
	targ.requests.value = targ.requests.value + activeRequestMatch.value
	
	-- remove request
	activeRequestMatch:removeSelf()
	activeRequestMatch = nil
	
	-- check for completion
	if( targ.requests.numChildren == 0 )then
	
		if( (targ.totalRequests) )then
		
			targ.curRequest = targ.curRequest + 1
			if(targ.totalRequests>=targ.curRequest)then
				
				level.handleRequestWait(targ)
				_G.mixer.playSFX('serve')
				
			else
				
				targ.curRequest = 1
				addPayment(targ)
				exitCustomer(targ)
				curSuccess = curSuccess + 1
				_G.mixer.playSFX('serve')
				
				print('customer served')
				_G.achievements.updateAchievement('customersServed', 1)
				if( targ.body.art.num==1 or targ.body.art.num==0 )then
					_G.achievements.updateAchievement('celebsServed', 1)
				end
				
			end

		else
			
			addPayment(targ)
			exitCustomer(targ)
			curSuccess = curSuccess + 1
			_G.mixer.playSFX('serve')
			
			print('customer served')
			_G.achievements.updateAchievement('customersServed', 1)
			if( targ.body.art.num==1 or targ.body.art.num==0 )then
				_G.achievements.updateAchievement('celebsServed', 1)
			end
			
			-- play audio	
			local rA = math.floor( math.random() * 13 ) + 1
			local aN = targ.body.art.gender .. '_' .. 'happy' .. '_' .. rA
			_G.mixer.playSFX(aN)
			
		end
		
	else
	
		targ.countDown = targ.countDown + WAIT_REWARD
		if( targ.countDown > targ.countDelay )then
			targ.countDown = targ.countDelay
		end
		
		_G.mixer.playSFX('serve')
		
	end
	
end

function addPayment(targ)
        
	-- check for zero value
	if( targ.requests.value == 0 )then return end
	
	-- build group
	local pay = util.addGroup(grp_main.counter, 'money', targ.endX-20, -20, 1)
	targ.pay = pay
	pay.targ = targ
	pay:addEventListener('touch', onPaymentTouch)
	
	-- payment
	for i=1, 3 do
		
		local p = _G.util.addImage('graphics/customers/payment/cash0'..i..'.png', pay, 'c', 0, 0, 1, 1, 0, 1)
		p.anchorY = 1
		p.y = ((i-1) * -11)
		p.x = -20

	end
	
	-- tip
	local tipCount = math.floor(TIP_MAX * (targ.request.bar.yScale))
	for i=1, tipCount do
		
		local p = _G.util.addImage('graphics/customers/payment/coin.png', pay, 'c', 0, 0, 1, 1, 0, 1)
		p.anchorY = 1
		p.y = ((i-1) * -4) - 4
		p.x = 16
		
	end
	
	-- hit
	_G.util.addFill(pay, 'fill', 1, 1, 0, .5, 0, 0, 80, 64)
	pay.fill.anchorY = 1
	pay.fill.x = -8
	pay.fill.alpha = .01
	
	-- pre-tip values
	curCash = curCash + targ.requests.value
	
	-- update value w/ tip
	local tipTotal = ( (tipCount/TIP_MAX) * TIP_PERCENT ) * targ.requests.value
	tipTotal = math.floor(tipTotal)
	targ.requests.value = targ.requests.value + tipTotal
	
	curTips = curTips + tipTotal
	curEarnings = curEarnings + targ.requests.value
	
	-- check for masked
	if( targ.masked )then
	
		--print('embedded')
		pay.x = targ.parent.x
		pay.y = targ.parent.y+67
		pay.xScale = targ.parent.xScale
		pay.yScale = pay.xScale
		
	end
	
	-- add 3 XP
	_G.gui.setXP(3)
        _G.gui.hideTutorial()
        print( "-----Add Payment------" )
        print(_G.curStageNum , _G.curLevelNum)
        print( "-----------" )
        if _G.curStageNum == 1 and _G.curLevelNum == 1 then
	        --Tutorial Set here collect money... 
	        local option = {}
	        option.id = 2
	        option.nilCall = 25
			_G.loadsave.print_r(option)
	        checkDataFunction( nil,nil,nil,nil,option )
	    elseif _G.curStageNum == 1 and _G.curLevelNum == 2 then
	        --Tutorial Set here collect money... 
	        local option = {}
	        option.id = 20
	        option.nextCall = 5
	        option.lastCall = 5
	        option.otehrCall = 1
			_G.loadsave.print_r(option)
	        checkDataFunction( nil,nil,nil,nil,option )
	    elseif _G.curStageNum == 1 and _G.curLevelNum == 4 then
	        --Tutorial Set here collect money... 
	        local option = {}
	        option.id = 22
	        option.nextCall=23
	        option.lastCall=23
	        option.otehrCall = 5
			_G.loadsave.print_r(option)
	        checkDataFunction( nil,nil,nil,nil,option )
	     elseif _G.curStageNum == 1 and _G.curLevelNum == 5 then
	        --Tutorial Set here collect money... 
	        local option = {}
	        option.id = 20
	        option.nextCall = 6
	        option.lastCall = 6
			_G.loadsave.print_r(option)
	        checkDataFunction( nil,nil,nil,nil,option )
	    end
end

function exitCustomer(targ)
	
	if _G.curStageNum == 4 and _G.curLevelNum == 1 and curCustomer == 1 then
		local option = {
    		id = 29,
    		nextCall = 30,
    		lastCall = 30,
    	}
    	checkDataFunction( nil,nil,nil,nil,option )
	end

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
							transition=easing.linear,
							onComplete=myclosure})
							
	-- bounce step
	transition.to( targ, {delay=0300, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=0612, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=0925, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=1237, time=0312, y=targ.endY, transition=easing.inOutQuad})

	transition.to( targ, {delay=1550, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=1862, time=0312, y=targ.endY, transition=easing.inOutQuad})
	transition.to( targ, {delay=2175, time=0312, y=targ.endY-20, transition=easing.inOutQuad})
	transition.to( targ, {delay=2487, time=0312, y=targ.endY, transition=easing.inOutQuad})
							
	-- check for final
	curServed = curServed + 1
	if(curServed == TOTAL_CUSTOMERS)then
	
		--print('that was the last one')
		timer.performWithDelay(1500, showResults)
		
	end
	
	-- update customer number
	if( targ.rnum )then
	
		targ.rnum = targ.rnum + 6
		
	end

end

function resetCustomer(targ)
	
	--print('reset')
	
	if(not targ.parent)then return end
	
	-- check gui timer
	if( _G.gui.getTimer() <= 0 )then return end
	
	-- if money waiting, return
	if( targ.pay )then
		
		targ.isHiding = false
		return
		
	end
	
	-- if artwork, remove
	if( targ.body.art )then
		targ.body.art:removeSelf()
		targ.body.art = nil
	end
	-- add artwork
	local art = _G.customers.buildArtwork()
	art.y = 140	
	targ.body:insert(art)
	targ.body.art = art
	
	-- shift layers
	if(not targ.masked)then
		targ:toBack()
	end
	
	-- reset patience
	targ.countDown = WAIT_COUNTDOWN
	targ.request.bar.yScale = 1
	targ.request.bar:setFillColor(0,1,0)

	-- move to position
	local myclosure = function() return enterCustomer(targ) end	
	targ.curTimer = timer.performWithDelay( CUSTOMER_RETURN_TIME, myclosure)
	
end

function enterCustomer(targ)
	print("Entering Customer ",not _G.TutorialData.displaying)
	if not _G.TutorialData.displaying then
		if( not targ.parent )then return end
		if( curCustomer == TOTAL_CUSTOMERS )then return end
	    
	    runningCust = targ

		-- increment
		curCustomer = curCustomer + 1
		grp_main.custCount.txt.text = (TOTAL_CUSTOMERS-curCustomer)
		targ.num = curCustomer
		
		--print('art num: ')
		--print(targ.body.art.num)
		
		-- special: celebrity
		if( (targ.body.art.num == 1) or (targ.body.art.num == 0) )then
			
			_G.mixer.playSFX('celebrity')
			
		else
		
			-- special: last customer
			if( (TOTAL_CUSTOMERS-curCustomer) == 0 )then
		
				_G.mixer.playSFX('final')
			
			end
		
		end 
		
		print("Target End X ::::: ", targ.parent.x)
		print("Target End y ::::: ", targ.parent.y)
		
		
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
		local myclosure = function() return level.setCustomerRequest(targ) end	
		transition.to( targ.request, {delay=2500, time=100, 
									  xScale=1, yScale=1, 
									  transition=easing.outQuad,
								  	  onComplete=myclosure})
									  
		-- start pupils	
		local myclosure = function() return _G.customers.startPupils(targ.body.art) end
		timer.performWithDelay(2500, myclosure)
		
		-- audio
		local myclosure = function()
            --Tutorial Set here Enter Customer...
            local option = getTutorialDataAfterCustomer(curCustomer)
            print( curCustomer, option )
            if option then
	            timer.performWithDelay(100, function()
	            	
	                checkDataFunction( nil,nil,nil,nil,option )
	            end, 1)
	        end
            return _G.mixer.playSFX('order')
	    end
		targ.curTimer = timer.performWithDelay(2500, myclosure)
	end
end

function getTutorialDataAfterCustomer( curCustomer )
	local option
	customerEnter = false
	if _G.curLevelNum == 1 then
		if _G.curStageNum == 1 then
		  	if curCustomer == 1 then
				customerEnter = true
				print( "Drink Is Ready2 ::::: ",drinkReady )
		    	if drinkReady then
		    		option = {
			    		id = 1,
			    		nextCall = 13,
			    		lastCall = 13,
			    	}
			    	_G.TutorialData.data.waitDrinkReady.display = false
		    	else
		    		option = {
			    		id = 1,
			    		nextCall = 32,
			    		lastCall = 32,
			    	}
		    	end
	    	elseif curCustomer == 2 then
				option = {
		    		id = 17,
		    		nextCall = 3,
		    		lastCall = 4,
		    		otehrCall = 18,
		    	}
		    end
	    elseif _G.curStageNum == 4 then
	    	if curCustomer == 1 then
		    	option = {
		    		id = 21,
		    		nextCall = 6,
		    		lastCall = 7,
		    		otehrCall =26
		    	}
		    end
	    elseif _G.curStageNum == 5 then
	    	if curCustomer == 1 then
				option = {
		    		id = 3,
		    	}
		    end
		elseif _G.curStageNum == 18 then
	    	if curCustomer == 1 then
				option = {
		    		id = 14,
		    		nextCall=34,
		    		lastCall=34
		    	}
		    end
		end
	elseif _G.curLevelNum == 2 then
		if _G.curStageNum == 1 then
		  	if curCustomer == 1 then
				customerEnter = true
				option = {
		    		id = 2,
		    		nextCall = 3,
		    		lastCall = 4,
		    	}
		    end
		elseif _G.curStageNum == 2 then
				customerEnter = true
				option = {
		    		id = 19,
		    		nextCall = 21,
		    		lastCall = 21,
		    		otehrCall=6
		    	}
		end
	elseif _G.curLevelNum == 4 then
		if _G.curStageNum == 1 then
		  	if curCustomer == 1 then
				customerEnter = true
				option = {
		    		id = 2,
		    		nextCall = 4,
		    		lastCall = 4,
		    		otehrCall = 21
		    	}
		    end
		elseif _G.curStageNum == 8 then
		  	if curCustomer == 1 then
		  		customerEnter = true
				option = {
		    		id = 24,
		    		nextCall = 7,
		    		lastCall = 7,
		    	}
		  	end
		end
	elseif _G.curLevelNum == 5 then
		if _G.curStageNum == 1 then
		  	if curCustomer == 1 then
				customerEnter = true
				option = {
		    		id = 16,
		    		nextCall = 1,
		    		lastCall = 1,
		    		otehrCall = 17
		    	}
		    end
		elseif _G.curStageNum == 11 then
		  	if curCustomer == 1 then
				customerEnter = true
				option = {
		    		id = 13,
		    		nextCall = 29,
		    		lastCall = 29
		    	}
		    end
		end
	elseif _G.curLevelNum == 3 then
		if _G.curStageNum == 1 then
		  	if curCustomer == 1 then
				customerEnter = true
				decItemCall = true
				option = {
		    		id = 13,
		    		nextCall = 1,
		    		lastCall = 8,
		    	}
		    end
		elseif _G.curStageNum == 11 then
		  	if curCustomer == 1 then
				customerEnter = true
				option = {
		    		id = 10,
		    		nextCall = 20,
		    		lastCall = 21,
		    		otehrCall = 11
		    	}
		    end
		 
		end
	end
	
	return option
end

function showResults()

	-- pause engine
	isPaused = true
	
	-- drag object?
	if( dragObject )then
	
		dragObject:removeSelf()
		dragObject = nil
		
	end
	
	-- collect money
	for i=grp_main.counter.numChildren, 1, -1 do
	
		local p = grp_main.counter[i]
		if(p.id=='money')then
			collectPayment( p )
		end
		
	end
	
	-- show results
	_G.gui.showOverlay()
	_G.results.buildModule()
	
	-- check achievements
	if( itemsTrashed==0 )then
	
		_G.achievements.updateAchievement('trashStreak', 1)
		
	end
	
	_G.achievements.updateAchievement('tips', curTips)
	_G.achievements.updateAchievement('cashEarned', curEarnings)
	
end

function stopAllCustomers()
	
	-- stop transitions
	transition.cancel()
	
	-- set cur lost
	curLost = TOTAL_CUSTOMERS - curSuccess
	
	print('customer lost - stop all')
	_G.achievements.updateAchievement('customersLost', curLost)
	
	-- pause & exit: customers
	local customers = grp_main.customers
	for i=1, customers.numChildren do

		local c = customers[i]
		if(c.cust)then
	
			c = c.cust
		
		end
	
		if( c.curTimer )then

			timer.cancel( c.curTimer )
		
		end
	
		exitCustomer(c)
	
	end
	
	-- show results
	timer.performWithDelay(1000, showResults)
	
end

--------------------------- OBJECTS:

function buildHitArea(color, w, h, mode, targets)

	local hit = display.newGroup()
	
	_G.util.addFill(hit, 'hit', 0, 0, 0, 1, 0, 0, w, h)
	_G.util.addFill(hit, 'bg', 0, 0, 0, 1, 0, 0, w, h)
	_G.util.addFill(hit, 'over', 1, 1, 1, .5, 0, 0, w, h)
	_G.util.addFill(hit, 'off', 0, 0, 0, .5, 0, 0, w, h)
	_G.util.addFill(hit, 'burnt', 0, 0, 0, 1, 0, 0, w, h)
	_G.util.addFill(hit, 'empty', .7, .7, .7, 1, 0, 0, w, h)
	
	hit.hit.alpha = .01
	hit.bg:setFillColor( _G.util.convertHexToRGB(color) )
	hit.over.alpha = 0
	hit.off.alpha = 0
	hit.empty.alpha = 0
	hit.burnt.alpha = 0
	
	hit.color = color
	hit.mode = mode
	hit.targets = targets
	hit.startTargets = targets
	
	local meter = _G.util.addGroup(hit, 'meter', 0, 0, 1)
	_G.util.addFill(meter, 'bg', 0, 0, 0, 1, 0, 0, w-20, 12)
	_G.util.addFill(meter, 'bar', 1, 1, 1, 1, 0, 0, w-20-4, 12-4)
	meter.bar.xScale = .0001
	meter.alpha = 0
	
	local decay = _G.util.addGroup(hit, 'decay', 0, 0, 1)
	_G.util.addFill(decay, 'bg', 0, 0, 0, 1, 0, 0, w-20, 12)
	_G.util.addFill(decay, 'bar', 1, 0, 0, 1, 0, 0, w-20-4, 12-4)
	decay.bar.xScale = .0001
	decay.alpha = 0
	
	-- add grp for contents
	_G.util.addGroup(hit, 'contents', 0, 0, 1)
	
	-- add trash display
	_G.util.addGroup(hit, 'trash', -10, -10, 0)
	_G.util.addText(' X ', hit.trash, 'xer', 'bangers', 0, 0, 140,  1, 0, 0)
	_G.util.addText(' -20 ', hit.trash, 'txtb', 'bangers', 2, 6, 30,  0, 0, 0)
	_G.util.addText(' -20 ', hit.trash, 'txt', 'bangers', 0, 4, 30,  1, 1, 1)
	hit.trash.xer.yScale = .5
		
	-- special cases
	if( (mode == 'instant-fill') or (mode == 'auto-fill') or (mode == 'cooker') or (mode == 'meat') )then

		countdownObjects[#countdownObjects+1] = hit

	end
	
	if( (mode=='clothes') or (mode=='cd') )then
	
		local icon = util.addFill(hit, 'icon', 0, 0, 0, 1, 0, 0, 44, 44)
		icon:setFillColor(_G.util.convertHexToRGB('#ffffff') )
		hit.color = '#ffffff'
		
		hit.off:toFront()
		hit.empty:toFront()
		hit.meter:toFront()
		
		countdownObjects[#countdownObjects+1] = hit
			
	end
	
	--- store
	allObjects[#allObjects+1] = hit
	
	--- init object
	resetObject( hit )
	
	-- return object	
	return hit
	
end

function checkTargets(obj)
	
	local activeTarget = nil
	local dx, dy, dt, holder, targ, tX, tY, oX, oY, thresh

	for i=1, #obj.targets do
	
		holder = grp_main.foreground.cart[ obj.targets[i] ]
		for j=1, holder.numChildren do
			
			targ = holder[j]
			if(targ.cust)then
			
				targ = targ.cust
				
			end
				
			local isInBounds = checkDragBounds(obj, targ)
			
			if( targ.mode == 'customer' )then
				
				thresh = CUSTOMER_THRESH
				if( isInBounds )then

					if( evaluateOrder(obj, targ) )then
						
						targ.over.alpha = 1
						activeTarget = targ
						_G.customers.highlight(targ.body.art, true)
						
					end
					
				else
				
					targ.over.alpha = 0
					_G.customers.highlight(targ.body.art, false)
				
				end
				
			elseif( targ.mode == 'sandwich' )then
				
				thresh = OBJECT_THRESH
								
				if( isInBounds  and (targ.empty.alpha~=1) and (targ[obj.mode]==nil) )then
			
					if( obj.food )then
					
						if( (targ[obj.food]==nil) )then
							
							targ.over.alpha = 1
							activeTarget = targ
							
						else
							
							targ.over.alpha = 0
							
						end
						
					else
					
						targ.over.alpha = 1
						activeTarget = targ
						
					end
				
				else
				
					targ.over.alpha = 0
				
				end
			
			elseif( targ.mode == 'warmer' )then
				
				thresh = OBJECT_THRESH
				if( isInBounds  and (targ.full~=true) )then
			
					if( obj.mode == 'warmer' )then
					
						print('adding warmer to warmer')
						
					else
					
						targ.over.alpha = 1
						activeTarget = targ
						
					end
				
				else
				
					targ.over.alpha = 0
				
				end
				
			else
				
				thresh = OBJECT_THRESH
				if( isInBounds and (targ.empty.alpha~=1) )then
			
					targ.over.alpha = 1
					activeTarget = targ
				
				else
				
					targ.over.alpha = 0
				
				end
				
			end
			
		end
		
	end
	
	-- check trash
	if(activeTarget)then
	
		if(activeTarget.mode == 'garbage')then
		
			obj.trashValue = level.evaluateTrash(obj)
			obj.trash.txtb.text = ' -' .. obj.trashValue .. ' '
			obj.trash.txt.text = ' -' .. obj.trashValue .. ' '
			obj.trash:toFront()
			obj.trash.alpha = 1
			
		else
		
			obj.trash.alpha = 0
			
		end

	else
		
		obj.trash.alpha = 0
		
	end
	
	-- return
	return activeTarget
	
end

function checkDragBounds(obj, targ)
	-- print("::::::: Target is :::::::")
	-- _G.loadsave.print_r(targ)
	-- print("::::::: Object is :::::::")
	-- _G.loadsave.print_r(obj)
	local isInBounds = false
	local bounds = targ.contentBounds 
	local objX, objY = obj:localToContent( 0, 0 ) 
	
	if( (objX>=bounds.xMin) and (objX<=bounds.xMax) and (objY>=bounds.yMin) and (objY<=bounds.yMax) and (targ.isVisible) )then
	
		isInBounds = true
		
	end
	
	return isInBounds
	
end

function resetObject(obj)

	obj.empty.alpha = 0
	obj.trashValue = 0
	obj.trash.alpha = 0
	
	--print('reset: ' ..obj.mode )
	if( obj.mode == 'auto-fill')then
	
		obj.off.alpha = 1
		obj.meter.alpha = 1
		
		obj.countDown = AUTO_COUNTDOWN
		obj.countDelay = AUTO_COUNTDOWN

		if(obj.cooktime)then
		
			obj.countDown = obj.cooktime
			obj.countDelay = obj.cooktime
			
		end
		-- obj.countDown = obj.countDown + 300
		-- obj.countDelay = obj.countDelay + 300
		-- set art
		if(obj.art)then
		
			obj.art.full.alpha = 0
			
		end
		
		-- exception: no water cooler
		if( (_G.curLevelNum==3) and (_G.curStageNum<8) )then 
			
			obj.countDown = -1
			return 
		
		end
		
		if( (_G.curLevelNum==4) and (_G.curStageNum<4) )then 
			
			obj.countDown = -1
			return 
		
		end
		
		-- start loop
		if( obj.audioStart )then
		
			_G.mixer.playSFX(obj.audioStart)
			
		end
		if( obj.loop )then
		
			_G.mixer.playLoop(obj.loop)
			
		end
		
	end
	
	if( obj.mode == 'instant-fill')then
	
		obj.off.alpha = 1
		obj.meter.alpha = 1
		
		obj.countDown = 1
		obj.countDelay = 0
		
	end
	
	if( obj.mode == 'cooker')then
	
		obj.off.alpha = 1
		obj.meter.alpha = 0
		obj.empty.alpha = 1
		
		obj.countDown = SIDE_COUNTDOWN
		obj.countDelay = SIDE_COUNTDOWN
		
		if(obj.cooktime)then
		
			obj.countDown = obj.cooktime
			obj.countDelay = obj.cooktime
			
		end
		
		-- set art
		if(obj.art)then
		
			obj.art.alpha = 0
			if( obj.art.full )then obj.art.full.alpha = 1 end
			if( obj.art.shadow )then obj.art.shadow.alpha = 1 end
			
		end
		
	end
	
	if( obj.mode == 'meat')then
		
		obj.bg.alpha = 1
		obj.off.alpha = 1
		obj.meter.alpha = 0
		obj.decay.alpha = 0
		obj.empty.alpha = 1
		obj.burnt.alpha = 0
		
		obj.countDown = COOK_COUNTDOWN
		obj.countDelay = COOK_COUNTDOWN
		
		obj.decayDown = DECAY_COUNTDOWN
		obj.decayDelay = DECAY_COUNTDOWN
		
		if(obj.cooktime)then
		
			obj.countDown = obj.cooktime
			obj.countDelay = obj.cooktime
			
		end
		obj.targets = obj.startTargets
		
		-- set art
		if(obj.art)then
		
			for i=1, obj.art.numChildren do
			
				obj.art[i].alpha = 0
				
			end
			
			if( obj.art.shadow )then obj.art.shadow.alpha=1 end
			obj.art.empty.alpha = 1
			obj.art.full.alpha = 0
			obj.art.burnt.alpha = 0
			obj.art.alpha = 0
						
		end
		
	end
	
	if( obj.mode == 'warmer')then
		
		obj.targets = obj.startTargets
		obj.full = false
		
		for i=obj.contents.numChildren, 1, -1 do
			
			obj.contents[i]:removeSelf()
			obj.contents[i] = nil
			
		end
		
		if(obj.art)then
		
			for i=1, obj.art.numChildren do
			
				obj.art[i].alpha = 0
				
			end
			--obj.art.warmer.alpha = 1
			
		end
		
	end
	
	if( obj.mode == 'sandwich')then
		
		obj.empty.alpha = 1
		
		obj.meat = nil
		obj.topping1 = nil
		obj.topping2 = nil
		obj.topping3 = nil
		obj.cooker = nil
		
		obj.sMeat = ''
		obj.sWaffle = ''
		obj.sGreens = ''
		obj.sMac = ''
		
		for i=obj.contents.numChildren, 1, -1 do
			
			obj.contents[i]:removeSelf()
			obj.contents[i] = nil
			
		end
		
		-- set art
		if(obj.art)then
		
			for i=1, obj.art.numChildren do
			
				obj.art[i].alpha = 0
				
			end
			
			if(obj.art.shadow)then obj.art.shadow.alpha = 1 end
			
			obj.art.empty.alpha = 1
			obj.art.alpha = 0
			
			if( obj.art.plantains )then obj.art.plantains.alpha=1 end
			if(obj.art.top)then 
				
				obj.art.top.alpha = 1 
				obj.art.top.y = obj.art.top.baseY
				obj.art.lettuce.y = obj.art.lettuce.baseY
				obj.art.tomato.y = obj.art.tomato.baseY
			
			end
			
			-- loc 5
			if(obj.art.food)then
		
				for i=obj.art.food.numChildren, 1, -1 do
			
					obj.art.food[i]:removeSelf()
					obj.art.food[i] = nil
			
				end
			
				obj.waffle = nil
				obj.greens = nil
				obj.mac = nil
			
			end
			
		end
			
	end
	
	if( obj.mode == 'clothes')then
		
		obj.empty.alpha = 1
		obj.icon.alpha = 0
		obj.meter.bar.xScale = .0001
		
		if( obj.stencil )then
		
			obj.stencilbg:removeSelf()
			obj.stencil:removeSelf()
			
			obj.stencilbg = nil
			obj.stencil = nil
			obj.letter = nil
			
		end
		
		obj.countDown = 0
		obj.countDelay = 0
		
		-- set art
		if(obj.art)then
		
			for i=1, obj.art.numChildren do
			
				obj.art[i].alpha = 0
				
			end
			obj.art.shadow.alpha = 1
			obj.art.fill.alpha = 1
			obj.art.outline.alpha = 1
			obj.art.alpha = 0
						
		end
		
	end
	
	if( obj.mode == 'cd')then
		
		obj.bg.alpha = 1
		obj.off.alpha = 1
		obj.meter.alpha = 0
		obj.decay.alpha = 0
		obj.empty.alpha = 1
		obj.burnt.alpha = 0
		
		obj.countDown = COOK_COUNTDOWN
		obj.countDelay = COOK_COUNTDOWN
		
		-- set art
		if(obj.art)then
		
			obj.art.alpha = 0
						
		end
		
	end
		
	if( obj.mode == 'topping' )then
	
		if(obj.art)then obj.art.alpha = 0 end
		
	end
	
	if( obj.mode == 'volume' )then
	
		if(obj.art)then obj.art.alpha = 0 end
		
	end
	
	if( obj.mode == 'stencil' )then
	
		if(obj.art)then obj.art.alpha = 0 end
		
	end
	
end
local function checkFunciton(  )
	local val = false
	local val4 = false
	local val2 = false
	local val3 = false
	print_r(tutObject)
	if (tutObject.select == nil) then val3 = true end
	if (tutObject.mode == nil) then val4 = true end
	if (tutObject.mode == nil or tutObject.select == nil) then val = true end
	if tutObject.mode == nil  or tutObject.targ == nil  or tutObject.type == nil then val2 = true end
	print( "v4,v3,v2,v",val4,val3,val2,val )
	if val and val2 and val3 and val4 then
		return true
	end
	return false
end
function evaluateDrop(obj, targ)
	print( "--------------" )
	print_r(tutObject)
	
	-- local checkDataDrop = true
	-- if _G.TutorialData.checkTargetTouch(2) then return end
	-- if _G.TutorialData.displaying and tutObject == nil then return end
	-- if _G.TutorialData.displaying and tutObject ~= nil then
	-- 	if checkFunciton() then
	-- 		return
	-- 	end
	-- 	print(_G.TutorialData.displaying,obj.select,obj.mode)

	-- 	print( "Check If condition1 :::: ",obj.mode,tutObject.mode, obj.mode ~= tutObject.mode)
	-- 	print( "Check If condition2 :::: ",tutObject.select,obj.select,tutObject.select ~= obj.select)
	-- 	print( "Check If condition3 :::: ",_G.curStageNum,tutObject.level,_G.curStageNum ~= tutObject.level)
	-- 	print( "Check If condition4 :::: ",_G.curLevelNum,tutObject.stage,_G.curLevelNum ~= tutObject.stage)
	-- 	if _G.TutorialData.displaying and (obj.mode ~= tutObject.mode or tutObject.select ~= obj.select or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then
	-- 		checkDataDrop = false
	-- 	end

	-- 	if checkDataDrop then
	-- 		if tutObject.targDelet == nil and targ.mode == "garbage" then
	-- 			checkDataDrop = false
	-- 		end
	-- 	end
	-- end
	-- if checkDataDrop then
		-- trash eval
		if( targ.mode == 'garbage' )then
			
			_G.gui.updateRevenue( obj.trashValue*-1 )
			itemsTrashed = itemsTrashed + 1
			
		end

		_G.gui.hideTutorial()

	-- end
	
	-- reset position
	resetObject(obj)

	-- force return 
	obj.x = obj.returnX
	obj.y = obj.returnY
	obj.isReturning = true
	returnObjects[#returnObjects+1] = obj
	
	-- if checkDataDrop then
		-- remove drag object
		dragObject = nil
		
		-- reset customer
		targ.over.alpha = 0
		
		-- check for result
		if( targ.mode == 'customer' )then
			
			removeRequest(obj, targ)
			
		end
		
		if( targ.mode == 'sandwich' )then
			
			level.addToSandwich(obj, targ)
			
		end
		
		if( targ.mode == 'warmer' )then
			
			level.addToWarmer(obj, targ)
			
		end
		
		if( targ.mode == 'clothes' )then
			
			addToClothes(obj, targ)
			
		end
		
		if( targ.mode == 'garbage' )then
			
			_G.mixer.playSFX('garbage')
			
		end
	-- end
		
end

function addToClothes(obj, targ)
					
	if( obj.mode == 'stencil' )then
		
		if( targ['stencil'] == nil )then
			
			local icon = util.addFill(targ, 'stencilbg', 0, 0, 0, 1, 0, 0, 26, 26)
			_G.util.addText(obj.letter, targ, 'stencil', 'native', 1, 0, 20, 1, 1, 1)
			targ.letter = obj.letter
			icon.alpha = 0
			targ.stencil.alpha = 0
			
			targ.off:toFront()
			targ.empty:toFront()
			targ.meter:toFront()
			
			targ.off.alpha = 1
			targ.meter.bar.xScale = .0001
			targ.meter.alpha = 1
			
			targ.countDown = targ.cooktime
			targ.countDelay = targ.cooktime
			
			-- show spraycan
			targ.art.spraycan.alpha = 1
			_G.mixer.playSFX('stencil_start')
			_G.mixer.playLoop('stencil_loop')
			
		end
					
	end
	
end

function resortGroup(grp)

	if( not grp.itemList )then return end
	
	-- check for empty sorting
	if( grp.sortByEmpty )then
	
		local emptyList = {}
		for i=1, #grp.itemList do
	
			if(grp.itemList[i].empty.alpha == 1)then
				
				grp.itemList[i]:toBack()
				
			end
		
		end
		
		return
		
	end
	
	-- z sort by list order
	for i=1, #grp.itemList do
	
		grp.itemList[i]:toFront()
		
	end
	
end

function hideObjects(hit)
	-- _G.gui.unSetAtionPerform()
	-- for testing
	if(1==2)then return end
	
	hit.bg.isVisible = false
	hit.over.isVisible = false
	hit.empty.isVisible = false
	hit.burnt.isVisible = false
	hit.off.isVisible = false
	hit.meter.isVisible = false
	hit.decay.isVisible = false
	
	if(hit.icon)then hit.icon.isVisible = false end
	
end

--------------------------- EVENTS:
function onHitTouch(e)
	if( e.phase ~= 'began' )then return end
	if( e.target.isReturning )then return end
	if checkTutFlagVal then return end

	if( string.find( e.target.parent.id, "tap" ) )then
		print( "On Hit tap",_G.TutorialData.checkTargetTouch(3) )
		if _G.TutorialData.checkTargetTouch(3) then return end
		if _G.TutorialData.displaying and tutObject == nil then return end
		
		local grp = e.target.parent
		local targ = string.gsub( grp.id, "-tap", "" )

		local hitGrp = grp_main.foreground.cart[targ]
		
		if _G.TutorialData.displaying and tutObject ~= nil then
			if checkFunciton() then
				return
			end

			print( "Mode :: ",hitGrp[1].mode )
			print( "Pass Mode :: ",tutObject.mode )

			print( "Check other tut data ",hitGrp[1].mode, hitGrp[1].mode ~= tutObject.mode)
			print( tutObject.targ , targ ,tutObject.targ ~= targ )
			print(tutObject.type, e.target.type, tutObject.type ~= e.target.type)
			print(_G.curStageNum, tutObject.level,_G.curStageNum ~= tutObject.level)
			print(tutObject.stage,_G.curLevelNum,_G.curLevelNum ~= tutObject.stage )

			if _G.TutorialData.displaying and (hitGrp[1].mode ~= tutObject.mode or tutObject.targ ~= targ or tutObject.type ~= e.target.type  or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then return end
		end
		-- check for valid cds --
		local canBurnCd = false
		local nextCdColor = ''
		local lowestPer = 1
		
		print( "Touch on data ::::::::::::; ",hitGrp[1].mode, targ, e.target.type,_G.curStageNum, _G.curLevelNum )
		print(_G.curStageNum, _G.curLevelNum)

		if(hitGrp[1].mode == "sandwich" and targ == "plate" and e.target.type == "single" and _G.curStageNum == 1 and _G.curLevelNum==5) then
			print( "Coeme TO Call tutorials Sandwich::: ",call )
			if call then
				_G.gui.hideTutorial()
				call = false
				timer.performWithDelay(10,function()
					call = true
				end)
				
				print( "isTutDisplay ::: ",level.isTutDisplay )
				if level.isTutDisplay then
					option = {
			    		id = 7,
			    		nextCall=19,
			    		lastCall=19
			    	}
                   	print_r(option)
			    	checkDataFunction(nil,nil,nil,nil,option)
			    else
			    	option = {
			    		id = 18,
			    	}
                    print_r(option)
			    	checkDataFunction(nil,nil,nil,nil,option)
			    end
			end
			level.isTutDisplay = true
		elseif(hitGrp[1].mode == "sandwich" and targ == "plate" and e.target.type == "single" and _G.curStageNum == 11 and _G.curLevelNum==5) then
			print( "Coeme TO Call tutorials Sandwich::: ",call )
			if call then
				_G.gui.hideTutorial()
				call = false
				timer.performWithDelay(10,function()
					call = true
				end)
				
				print( "isTutDisplay ::: ",level.isTutDisplay )
				if level.isTutDisplay then
					option = {
			    		id = 14
			    	}
                   	print_r(option)
			    	checkDataFunction(nil,nil,nil,nil,option)
			    else
			    	option = {
			    		id = 24,
			    	}
                    print_r(option)
			    	checkDataFunction(nil,nil,nil,nil,option)
			    end
			end
			level.isTutDisplay = true
		elseif(hitGrp[1].mode == "clothes" and targ == "jeans" and e.target.type == "single" and _G.curStageNum == 1 and _G.curLevelNum==2) then
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction()
			end
		elseif(hitGrp[1].mode == "clothes" and targ == "shirts" and e.target.type == "single" and _G.curStageNum == 5 and _G.curLevelNum==2) then
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				checkDataFunction()
			end
		elseif(hitGrp[1].mode == "clothes" and targ == "hats" and e.target.type == "single" and _G.curStageNum == 8 and _G.curLevelNum==2) then
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction()
			end
		elseif(hitGrp[1].mode == "clothes" and targ == "pants" and e.target.type == "single" and _G.curStageNum == 1 and _G.curLevelNum==4) then
			print( "_____-nil Number-______" )
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction(nil,nil,nil,nil,{id=10})
			end
		elseif(hitGrp[1].mode == "clothes" and targ == "hat" and e.target.type == "single" and _G.curStageNum == 1 and _G.curLevelNum==4) then
			--print( "_____-13 Number-______" )
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction( 13 )
			end
			-- plain t-shirts
		elseif(hitGrp[1].mode == "clothes" and targ == "tee" and e.target.type == "single" and _G.curStageNum == 1 and _G.curLevelNum==4) then
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction( 11)
			end
			--Black Shoes
		elseif(hitGrp[1].mode == "cooker" and targ == "shoes02" and e.target.type == "all" and _G.curStageNum == 8 and _G.curLevelNum==4) then
			--_G.gui.hideTutorial()
			-- timer.performWithDelay(5000,function()
			-- 	checkDataFunction( 14 )
			-- end,1)
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				checkDataFunction(nil,nil,nil,nil,{id=40})
			end
			--White Shoes
		elseif(hitGrp[1].mode == "cooker" and targ == "shoes01" and e.target.type == "all" and _G.curStageNum == 1 and _G.curLevelNum==4) then
			--_G.gui.hideTutorial()
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				timer.performWithDelay(5000,function()
					checkDataFunction( 15 )
				end,1)
			end
		elseif(hitGrp[1].mode == "cooker" and targ == "cases" and e.target.type == "all" and _G.curStageNum == 15 and _G.curLevelNum==4) then
			--_G.gui.hideTutorial()
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
				timer.performWithDelay(5500,function()
					--print("Call Function .........")
					checkDataFunction( 19 )
				end,1)
			end
		else
			if call then
				call = false
				timer.performWithDelay(10,function( )
					call = true
				end)
				_G.gui.hideTutorial()
			end
		end
		if( hitGrp[1].mode == 'cd' )then
		
			-- get customers
			local cGroup = grp_main.customers
			for i=1, cGroup.numChildren do
				
				print('checking cust: ' .. i)
				
				-- get requests
				local reqs = cGroup[i].cust.requests
				for j=1, reqs.numChildren do
				
					if( reqs[j].food == 'cd' )then
					
						print('customer needs cd: ' .. i)
						
						-- check if already burning
						local isBurning = false
						for k=1, hitGrp.numChildren do
		
							if(hitGrp[k].empty.alpha == 0)then
								
								print('slot full: ' .. k)
								print(hitGrp[k].icon.color)
								
								if(hitGrp[k].icon.color == cGroup[i].cust.color)then
								
									print('color already present: ' .. hitGrp[k].icon.color )
									isBurning = true
									
								end
								
							end
			
						end
						
						-- if not burning, add color
						if(isBurning == false)then
							-- _G.TutorialData.hideTutorial()
							print('is not burning: ' .. cGroup[i].cust.color )
							canBurnCd = true
							nextCdColor = cGroup[i].cust.color
							
							-- check for lowest patience
							local per = cGroup[i].cust.request.bar.yScale
							if( per <= lowestPer )then
							
								lowestPer = per
								nextCdColor = cGroup[i].cust.color
								
							end
							
						end
						
					end
					
				end

			end
			
			-- check if valid
			if( canBurnCd == false )then 
				
				print('cant burn cd')
				return 
			
			end
						
		end
		
		------------------------------
		
		local isOpen = false
		
		if( e.target.type == 'all' )then
			
			local allLocked = true
					
			for i=hitGrp.numChildren, 1, -1 do
				
				if( (hitGrp[i].empty.alpha == 1) )then
				
					allLocked = false
				
					hitGrp[i].empty.alpha = 0
					hitGrp[i].meter.alpha = 1
					
					-- sandwich
					if( hitGrp[i].mode == 'sandwich' )then
						hitGrp[i].meter.alpha = 0
					end
					
					-- mugs, cases, shoes 
					if( (hitGrp[i].name) )then
			
						if(hitGrp[i].name == 'case')then
			
							hitGrp[i].art.alpha = .5
				
						end
						if(hitGrp[i].name == 'mug')then
			
							hitGrp[i].art.alpha = .5
				
						end
						if(hitGrp[i].name == 'shoes')then
			
							hitGrp[i].art.alpha = .5
				
						end
				
					end
					
					isOpen = true
					
				end
			
			end
			
			-- check for fryer
			if( e.target.parent.id == 'knish-tap' )then
			
				-- check if all fries
				if(allLocked)then
					
					print('all fries locked')
					return
					
				end
			
				e.target.art.empty.alpha = 0
				e.target.art.cooking.alpha = 1
								
			end
			
			-- check for waffle-iron
			if( e.target.parent.id == 'waffle-tap' )then
						
				-- check if all fries
				if(allLocked)then
					
					print('all waffles locked')
					return
					
				end
			
				e.target.art.empty.alpha = 0
				e.target.art.cooking.alpha = 1
								
			end
			
			-- check for phone
			if( e.target.parent.id == 'pizza-tap' )then
			
				-- check if all fries
				if(allLocked)then
					
					print('all pizza locked')
					return
					
				end
			
				e.target.art.on.alpha = 0
				e.target.art.off.alpha = 1
								
			end
			
		end
		
		if( e.target.type == 'single' )then
			
			local didFind = false
			for i=hitGrp.numChildren, 1, -1 do
				
				--print(i)
				
				if( (hitGrp[i].isVisible ) and (hitGrp[i].empty.alpha == 1) and (didFind==false) )then
				
					didFind = true
					hitGrp[i].empty.alpha = 0
					hitGrp[i].meter.alpha = 1
					
					if( hitGrp[i].mode == 'sandwich' )then
						print("Ssandwhich...")
						hitGrp[i].meter.alpha = 0
						
					end
					
					if( hitGrp[i].mode == 'clothes' )then
						print("clothes...")
						hitGrp[i].color = e.target.color
						hitGrp[i].meter.alpha = 0
						
						local grp = e.target.parent
						
						hitGrp[i].icon.alpha = 1
						hitGrp[i].icon:setFillColor(_G.util.convertHexToRGB(grp.icon.color) )
						hitGrp[i].icon.color = grp.icon.color
						
						-- set shirt/jean/hats color
						hitGrp[i].art.fill:setFillColor(_G.util.convertHexToRGB(grp.icon.color) )
						
					end
					
					if( hitGrp[i].mode == 'cd' )then
						print("cd...")
						hitGrp[i].color = e.target.color
						hitGrp[i].meter.alpha = 1
						
						local grp = e.target.parent
						
						hitGrp[i].icon.alpha = 1
						hitGrp[i].icon:setFillColor(_G.util.convertHexToRGB( nextCdColor ) )
						hitGrp[i].icon.color = nextCdColor
						
						hitGrp[i].art.fill:setFillColor(_G.util.convertHexToRGB( nextCdColor ) )
						
					end
					
					-- show art
					if( hitGrp[i].art )then
					
						hitGrp[i].art.alpha = 1
						
						-- UPDATE
						if(hitGrp[i].mode == 'cd')then
							print("CD...")
							hitGrp[i].art.alpha = .5
							
						end
						if(hitGrp[i].food == 'sketch')then
							print("Sketch...")
							hitGrp[i].art.alpha = .5
							
						end						
						
					end
					
					isOpen = true
					
				end
			
			end
			
		end
		
		-- check audio (if visible)		
		if( isOpen )then
		
			if( e.target.audio )then
		
				_G.mixer.playSFX(e.target.audio)
			
			end
		
			if( e.target.loop )then
		
				_G.mixer.playLoop(e.target.loop)
			
			end
			
		end
	else
		print( "On Hit Touch",_G.TutorialData.checkTargetTouch(2) )
		print( "--------------" )
		print_r(tutObject)
		print(e.target.select,e.target.mode,e.target.targ)
		if _G.TutorialData.checkTargetTouch(2) then return end
		if _G.TutorialData.displaying and tutObject == nil then return end
		if _G.TutorialData.displaying and tutObject ~= nil then
			if checkFunciton() then
				return
			end
			print("If1 ::: ",e.target.mode ~= tutObject.mode )
			print("If2 ::: ",tutObject.select ~= e.target.select )
			print("If3 ::: ",_G.curStageNum ~= tutObject.level )
			print("If4 ::: ",_G.curLevelNum ~= tutObject.stage )
			print("Latter To select ::: ",e.target.letter )
			print("IfAll ::: ",e.target.mode ~= tutObject.mode or tutObject.select ~= e.target.select or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage )
			if _G.TutorialData.displaying and (e.target.mode ~= tutObject.mode or tutObject.select ~= e.target.select or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then return end
			if _G.TutorialData.displaying and tutObject.select == "stencil" and e.target.mode == "stencil" and _G.curStageNum == 2 and _G.curLevelNum == 2 and e.target.letter ~= "b" then return end
		end

		if( (e.target.mode == 'warmer') and (e.target.full~=true) )then return end
		
		if( e.target.off.alpha == 1)then return end
		if( e.target.empty.alpha == 1)then return end

		e.target.home = e.target.parent
		e.target.homeX = e.target.x
		e.target.homeY = e.target.y
		dragObject = e.target

		local holder = e.target.parent
		local cart = holder.parent
		local fg = cart.parent
		
		local newX = e.target.x + holder.x + cart.x + fg.x
		local newY = e.target.y + holder.y + cart.y + fg.y

		e.target.x = newX
		e.target.y = newY
		e.target.returnX = e.target.x
		e.target.returnY = e.target.y
		
		_G.layer_stage.drag:insert(e.target)
		e.target.isDragging = true
		
		-- hide shadow in art
		if( e.target.art )then
		
			if(e.target.art.shadow)then e.target.art.shadow.alpha = 0 end
			
			if( e.target.mode == 'topping' )then
			
				if(e.target.art)then e.target.art.alpha = 1 end
				
			end
			
			if( e.target.mode == 'stencil' )then
			
				if(e.target.art)then e.target.art.alpha = 1 end
				
			end
			
			if( e.target.mode == 'volume' )then
			
				if(e.target.art)then e.target.art.alpha = 1 end
				
			end
				
		end
		
		-- check for select
		if( e.target.select )then
		
			_G.mixer.playSFX(e.target.select)
			
		end
		
	end
	
	return true
	
end

function onScreenTouch(e)
	if _G.TutorialData.checkTargetTouch(2) then return end
	local function returnObjectToItsPlace()
		if dragObject then
			dragObject.isReturning = true
			returnObjects[#returnObjects+1] = dragObject
			dragObject = nil
		end
	end
	if _G.TutorialData.displaying and tutObject == nil then
		returnObjectToItsPlace()
		return
	end
	if _G.TutorialData.displaying and tutObject ~= nil and dragObject then	
		if tutObject.mode == nil and tutObject.select == nil then return end

		if _G.TutorialData.displaying and (dragObject.mode ~= tutObject.mode or tutObject.select ~= dragObject.select or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then 
			returnObjectToItsPlace()
			return
		end
	end
	if( e.phase == 'moved' )then		
		-- _G.loadsave.print_r(dragObject )
		
		if( dragObject )then
			
			local newX = (e.x - _G.layer_stage.x) * (1/_G.deviceScale)
			local newY = (e.y - _G.layer_stage.y) * (1/_G.deviceScale)
			
			dragObject.x = newX
			dragObject.y = newY - 32
			
			checkTargets(dragObject)
		
		end
		
	end
	
	if( e.phase == 'ended' )then
		
		if( dragObject )then
		
			local activeTarget = checkTargets(dragObject)
			if( activeTarget ~= nil )then
				
				evaluateDrop(dragObject, activeTarget)
				
			else
			
				dragObject.isReturning = true
				returnObjects[#returnObjects+1] = dragObject
				dragObject = nil
				
			end
			
		end
	end
end
local function checkTutorialData()
	checkTutFlagVal = false
	if not _G.TutorialData.displaying and _G.curLevelNum <= 5 then
		for k, v in pairs(_G.TutorialData.data) do
			if v.display and _G.curStageNum == v.level and _G.curLevelNum == v.stage then
				-- print( "K::::",k )
				checkTutFlagVal = true
			end
		end
	end
end
function onEnterFrame(e)
	if( isPaused )then return end
	local dx, dy, dt, obj, per, cust

	checkTutorialData()	
	-- print("Enter Fram If :: ",not _G.TutorialData.checkTargetTouch(4))
	if not _G.TutorialData.checkTargetTouch(4) then
		-- countdown objects
		for i=1, #countdownObjects do
			obj = countdownObjects[i]
			-- print( "Drawing ::::: ",obj.mode )
			-- print("Selected data :::: ",obj.name,obj.select)

			if drinkFirstCall then
				
				if obj.mode == "auto-fill" then
					obj.countDown = 1
					obj.countDelay = 0
				end
				timer.performWithDelay(10,function()
					drinkFirstCall = false
				end)
			end

			-- check cooking
			if( (obj.countDown > 0) and (obj.empty.alpha ~= 1) )then

				obj.countDown = obj.countDown-1
				per = 1-(obj.countDown/obj.countDelay)
				obj.meter.bar.xScale = per
				
				-- emit particle
				
				-- print( "Drawing ::::: ",obj.mode )
				-- print("Selected data :::: ",obj.name,obj.select)

				if( (obj.cookParticle) and (obj.countDown%3==0) )then
				
					emitParticle( obj, obj.cookParticle )
					
				end
				-- on cooking done...
				
				if( obj.countDown==0 )then
					
					-- print( "Check Feel Data ::::: ",obj.mode, obj.select, _G.curStageNum, _G.curLevelNum, curCustomer,obj.letter )

					if( obj.mode == 'cd' )then
						if call then
							call = false
							timer.performWithDelay(10,function( )
								call = true
							end)
							_G.gui.hideTutorial()
						end
					end

					obj.meter.alpha = 0
					obj.off.alpha = 0
					if( obj.mode == 'meat' )then
					
						obj.decay.alpha = 1
						
					end
					
					if( obj.mode == 'clothes' )then
						
						--print('clothes')
						obj.art.spraycan.alpha = 0
						obj.art['stencil-' .. obj.letter ].alpha = 1
						
					end
					
					-- switch art
					if( obj.art )then
				
						obj.art.alpha = 1
						if(obj.art.full)then
							obj.art.full.alpha = 1
						end
					
					end
					if _G.curLevelNum== 1 then
						if obj.mode == "meat" then
							if obj.select == 'grill' then
								if _G.curStageNum == 1 then
									if not decayItemTut then
										if call then
											call = false
											timer.performWithDelay(10,function()
												call = true
											end)
											local option = {}
											option.id = 5
					                		option.nextCall = 19
					                		option.lastCall = 19
											checkDataFunction(nil,nil,nil,nil,option)
										end
									end
								elseif _G.curStageNum == 4 then
									if call then
										call = false
										timer.performWithDelay(10,function()
											call = true
										end)
										if not fCallPatty then
											fCallPatty = true
											print( "Call **** 8 with nill" )
											checkDataFunction(nil,nil,nil,nil,{id = 8,nextCall=33,lastCall=33})
										else
											print( "Call **** 30 with nill" )
											checkDataFunction(nil,nil,nil,nil,{id = 31})
										end
									end
								end
							end
						elseif obj.mode == "cooker" then
							if obj.select == 'fries' then
								if call then
									call = false
									timer.performWithDelay(10,function()
										call = true
									end)
									if _G.curStageNum == 18 then
										print( obj.select,"15" )
										checkDataFunction(nil,nil,nil,nil,{id = 15})
									end
								end
							end
						elseif obj.mode == "auto-fill" and obj.select == "cola" and _G.curStageNum == 1 and _G.curLevelNum==1 then
							-- print( "Call flag ::: ",call )
							-- print( "check drink ::::: ",drinkReady )
							if drinkReady and customerEnter then
								if call then
									call = false
									timer.performWithDelay(10,function() call=true end)
									checkDataFunction(nil,nil,nil,nil,{id = 13})
								end
							else
								drinkReady = true
							end
						end
					elseif _G.curLevelNum== 2 then
						
						print( obj.mode == "clothes" and obj.select == "jeans" and _G.curStageNum == 2 and _G.curLevelNum== 2 and obj.letter == 1 )
						print( obj.mode == "clothes" )
						print( "if 1 ",obj.select == "jeans" )
						print( "if 2 ", _G.curStageNum == 2 )
						print( "if 3 ", _G.curLevelNum== 2 )
						print( "if 4 ",obj.letter,obj.letter == 1 )

						if obj.mode == "clothes" and obj.select == "jeans" and _G.curStageNum == 2 and _G.curLevelNum== 2 and obj.letter == "b" then
							if call then
								call = false
								timer.performWithDelay(10,function()
									call = true
								end)
								local option = {}
								option.id = 22
		                		option.nextCall = 23
		                		option.lastCall = 23
		                		print( "--=--=--=--=--=--" )
		                		print_r( option )
								print( "--=--=--=--=--=--" )
								checkDataFunction(nil,nil,nil,nil,option)
							end
						end						
					end
					
					-- print("Type ::::: ",obj.mode,obj.name,obj.select)

					-- check for cooker
					if( obj.mode == 'cooker' )then
						--_G.loadsave.print_r(obj)
						if obj.select == "sketch" and _G.curStageNum == 11 and _G.curLevelNum==2 then
							local option = {}
							option.id = 12
							timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
						elseif obj.select == "mug" and _G.curStageNum == 15 and _G.curLevelNum==2 then
							checkDataFunction()
						elseif obj.select == "case" and _G.curStageNum == 18 and _G.curLevelNum==2 then
							checkDataFunction()
						elseif obj.select == "select_pizza" and _G.curStageNum == 11 and _G.curLevelNum==3 then

							if call then
								call = false
								timer.performWithDelay(10,function()
									call = true
								end)
								_G.gui.hideTutorial()
							end
						elseif obj.select == "waffle" and _G.curStageNum == 1 and _G.curLevelNum==5 then

							if call then
								call = false
								timer.performWithDelay(10,function()
									call = true
								end)
								checkDataFunction( 8 )
							end
							-- cooker	shoes	sneakers
						elseif obj.select == "sneakers" and _G.curStageNum == 8 and _G.curLevelNum==4 then
							if call then
								call = false
								timer.performWithDelay(10,function()
									call = true
								end)
								--checkDataFunction()
								checkDataFunction(nil,nil,nil,nil,{id=14})
							end
						end
						level.resetCooker()
						
					end

					-- audio
					_G.mixer.playSFX('ready')
					
					-- check done, loop stop
					if(obj.audio)then 
					
						_G.mixer.playSFX(obj.audio)
						
					end
					if(obj.loop)then 
						
						--print('has loop')
						
						local stillCooking = false
						for i=1, obj.parent.numChildren do
						
							local item = obj.parent[i]
							
							-- check for full (cooking)
							if( item.art.full )then
							
								if( (item.art.alpha==1) and (item.art.full.alpha==0) )then
								
									stillCooking = true
								
								end
								
							end
							
							-- check for spraying
							if( item.art.spraycan )then
								
								if( (item.art.spraycan.alpha==1) )then
								
									stillCooking = true
								
								end
								
							end
							
						end

						if( stillCooking == false )then
						
							_G.mixer.stopSFX(obj.loop)
							
						end
						
					end

				end
			end
			-- print( "decay ",obj.decay.alpha )
			
			-- check decay
			if( obj.decay.alpha == 1 )then
				print( "Checek ",obj.decayDown, not obj.isDragging,_G.TutorialData.checkTargetTouch(4))
				if( (obj.decayDown > 0) and (not obj.isDragging) )then
	                -- print( "Displaying2 ::: ",_G.TutorialData.displaying )
					if( _G.TutorialData.displaying and not decayItemTut )then obj.decayDown=obj.decayDown+1 end
	                -- print( " obj.decayDown === ", obj.decayDown)
					obj.decayDown = obj.decayDown-1
					per = 1-(obj.decayDown/obj.decayDelay)
					obj.decay.bar.xScale = per
				
					if( obj.decayDown==0 )then
						decayItemTut = false
						-- print( "----------------------------------------------" )
						-- print(obj.id, obj.type, obj.name, obj.x , obj.y, obj.parent)
						-- print( "----------------------------------------------" )
						-- checkDataFunction( 12, obj.x, obj.y - obj.height/2,obj.parent )
						checkDataFunction(nil,nil,nil,nil,{id = 12})
						obj.decay.alpha = 0
						obj.burnt.alpha = 1
						
						obj.targets = {'garbage'}
						
						-- show art
						if( obj.art )then
					
							obj.art.empty.alpha = 0
							obj.art.full.alpha = 0
							obj.art.burnt.alpha = 1
						
						end
						
						-- audio
						local myclosure = function() return _G.mixer.playSFX('burnt') end
						timer.performWithDelay(0, myclosure)
						
						-- update achievement
						_G.achievements.updateAchievement('burned', 1)
				
					end
				
				end
			end
			
		end
	end
	-- return open drag objects
	for i=1, #returnObjects do
		obj = returnObjects[i]
		dx = obj.x - obj.returnX
		dy = obj.y - obj.returnY
				
		obj.x = obj.x - (dx * .2)
		obj.y = obj.y - (dy * .2)
		
		dt = math.sqrt((dx*dx)+(dy*dy))
		if( dt < RETURN_THRESH )then
			
			obj.setHome = true
			
		end
		
	end
	
	-- remove returned object
	local newList = {}
	for i=1, #returnObjects do
	
		if( obj.setHome )then
			
			obj.home:insert(obj)
			obj.x = obj.homeX
			obj.y = obj.homeY
			obj.isReturning = false
			obj.isDragging = false
			obj.setHome = false
			
			resortGroup(obj.home)
			
			-- hide shadow in art
			if( obj.art )then
		
				if(obj.art.shadow)then obj.art.shadow.alpha = 1 end
				
			end
			
			-- if stencil, hide
			if( obj.mode == 'stencil' )then
			
				if(obj.art)then obj.art.alpha = 0 end
				
			end
			
			-- if topping hide
			if( obj.mode == 'topping' )then
			
				if(obj.art)then obj.art.alpha = 0 end
				
			end
			
			-- if volume hide
			if( obj.mode == 'volume' )then
			
				if(obj.art)then obj.art.alpha = 0 end
				
			end
			
		else
		
			newList[#newList+1] = returnObjects[i] 
			
		end
		
	end
	returnObjects = newList
	
	-- print( "Customer Stop :::: ",_G.TutorialData.displaying )

	if not _G.TutorialData.displaying then
		-- countdown customers
		for i=1, grp_main.customers.numChildren do
		
			cust = grp_main.customers[i]
			if( cust.cust )then
			
				cust = cust.cust
				
			end

			if( (cust.countDown > 0) and ( cust.request.xScale >= .9 ) )then
				
				runningCust = cust

				cust.countDown = cust.countDown-1
				-- print( "Displaying ::: ",_G.TutorialData.displaying )
				if( _G.TutorialData.displaying )then cust.countDown=cust.countDown+1 end
				
				-- set bar
				per = (cust.countDown/cust.countDelay)
	                        -- print( "Per ::: ",per )
				if(per==0)then per=.0001 end
				cust.request.bar.yScale = per
				
				-- check mood
				if( (per <= .66) and (cust.body.art.mood == 'happy') )then
				
					_G.customers.changeMood( cust.body.art, 'annoyed' )
					
				end
				if( (per > .66) and (cust.body.art.mood == 'annoyed') )then
				
					_G.customers.changeMood( cust.body.art, 'happy' )
					
				end
				
				if( (per <= .33) and (cust.body.art.mood == 'annoyed') )then
				
					_G.customers.changeMood( cust.body.art, 'angry' )
					cust.request.bar:setFillColor(1,0,0)
					
				end
				if( (per > .33) and (cust.body.art.mood == 'angry') )then
				
					_G.customers.changeMood( cust.body.art, 'annoyed' )
					cust.request.bar:setFillColor(0,1,0)
					
				end
				
				-- check countdown end
				if( cust.countDown==0 )then
				
					-- remove requests
					for i=cust.requests.numChildren, 1, -1 do
		
						f = cust.requests[i]
						f:removeSelf()
						f = nil
			
					end
					addPayment(cust)
					exitCustomer(cust)
					
					print('customer lost')
					_G.achievements.updateAchievement('customersLost', 1)
					
					-- increment lost
					curLost = curLost + 1
					
					-- audio
					local myclosure = function() return _G.mixer.playSFX('leave') end
					timer.performWithDelay(0, myclosure)
				
				end
				
			end
		end
		-- update gui timer
		_G.gui.setTimer()
	end
	
end

function onPaymentTouch(e)

	if(e.phase ~= 'began')then return end
	-- Remove Case tutorial here...
    -- print( "Tutorial Running :: ", _G.TutorialData.displaying)
    print( ":::: Collect Money :::" )
    print_r( tutObject )
    print(_G.curStageNum,_G.curLevelNum)

	collectPayment(e.target)

	-- if _G.curStageNum ~= 1 and _G.curLevelNum ~= 1  then
	-- 	-- secondChikanFrier
	-- 	timer.performWithDelay(100, function()
	-- 	checkDataFunction( nil, nil, nil, nil,  )
	-- 	end)
	-- end

	if _G.TutorialData.checkTargetTouch(3) then return end
	if tutObject == nil or tutObject.mode == nil or tutObject.select == nil then return end
	if tutObject and (tutObject.mode ~= "collect" or tutObject.select ~= "money" or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then return end
    
    _G.gui.hideTutorial()

    if decItemCall and _G.curStageNum == 1 and _G.curLevelNum == 1 then
    	decItemCall = false

		local option = {}
		option.id = 27
		option.nextCall = 28
		option.lastCall=28

		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)
	elseif decItemCall and _G.curStageNum == 1 and _G.curLevelNum == 3 then
    	decItemCall = false

		local option = {}
		option.id = 14
		option.nextCall = 15
		option.lastCall=15

		timer.performWithDelay(100,function()checkDataFunction(nil,nil,nil,nil,option)end)

    end
	
end

function collectPayment(payment)

    -- Add Cash Tutorial Here...
        
	-- update gui
	_G.gui.updateRevenue( payment.targ.requests.value )
	
	-- emit particle
	emitCashParticles( payment )
	
	-- set target to open
	payment.targ.pay = nil
	if( payment.targ.isHiding==false )then 
		
		resetCustomer(payment.targ) 
	
	end
	
	-- audio
	local myclosure = function() return _G.mixer.playSFX('collect') end
	timer.performWithDelay(0, myclosure)
	
	-- remove
	payment:removeSelf()
	payment = nil
        
    --Remove Tutorial Here after collect money....
end

function onColorTouch(e)
	if checkTutFlagVal then return end
	if( e.phase ~= 'began' )then return end
	if( e.target.isReturning )then return end
	if _G.TutorialData.checkTargetTouch(33) then return end
	if _G.TutorialData.displaying and (e.target.num ~= tutObject.selNumber or _G.curStageNum ~= tutObject.level or _G.curLevelNum ~= tutObject.stage ) then return end
	_G.gui.hideTutorial()
	print(e.target.num)
	for i=1, #e.target.targets do
	
		local targ = e.target.targets[i]
		local tap = grp_main.foreground.cart[ targ .. '-tap'  ]
		tap.icon:setFillColor( _G.util.convertHexToRGB( e.target.color ) )
		tap.icon.color = e.target.color
		
		tap.art.fill:setFillColor( _G.util.convertHexToRGB( e.target.color ) )
		
	end
	
	_G.mixer.playSFX('color')
	
end

--------------------------- EFFECTS:

function emitParticle( obj, particle )
	
	--print('cook')
	
	local art = obj.art
	local p = _G.util.addImage(particle, _G.layer_stage, 'p', 0, 0, 1, 1, 0, 1)
	
	local holder = obj.parent
	local nx = obj.x + holder.x
	local ny = obj.y + holder.y
	
	p.xScale = 2
	p.yScale = 2
	p.rotation = math.random()*360
	p.x = (math.random()*40) + -20
	p.y = -16
		
	p.x = p.x + nx -- (512)
	p.y = p.y + ny -- (384)
	
	p.alpha = .5
	
	local myclosure = function() return _G.util.dropImage(p) end
	transition.to( p, {time=2000, y=p.y-60, alpha=0, transition=easing.outQuad, rotation=(math.random()*180), onComplete=myclosure})
	
end

function emitCashParticles( obj )
	
	local delayer = 0
	for i=1, 20 do
		
		local p = _G.util.addImage('graphics/effects/star.png', _G.layer_stage, 'p', 0, 0, 1, 1, 0, 1)
		p.x = obj.x 
		p.y = obj.y
		p.xScale = (math.random()*.7)+1
		p.yScale = p.xScale
		p.rotation = math.random()*360
		p.alpha = 0
		
		local myclosure = function() return _G.util.dropImage(p) end
		transition.to( p, {delay=delayer, time=0, alpha=1, })
		transition.to( p, {delay=delayer, time=500, y=-332, rotation=(math.random()*180), transition=easing.outQuad, onComplete=myclosure})
		transition.to( p, {delay=delayer, time=400, x=-130, transition=easing.outQuad})
		delayer = delayer + 25
		
	end
	
end

--------------------------- UI:

function onExitTouch(e)

	if(e.phase ~= 'began')then return end
	if(grp_main.black.alpha > 0)then
		if isLevelView then
			_G.loader.showLoader()
		
			local myclosure = function() return _G.levelselect.killModule() end
			timer.performWithDelay(550, myclosure, 1)

			local myclosure = function() return _G.upgrades.killModule() end
			timer.performWithDelay(550, myclosure, 1)
			
			local myclosure = function() return _G.map.buildModule() end
			timer.performWithDelay(700, myclosure, 1)
		
			-- _G.levelselect.hideMenu()
		
			-- local myclosure = function() return _G.loader.showLoader() end
			-- timer.performWithDelay(200, myclosure, 1)
			
			-- local myclosure = function() return _G.engine.endLevel() end
			-- timer.performWithDelay(800, myclosure, 1)
		end
		return
	end
	
	togglePause()
	
	local myclosure = function() return _G.pause.buildModule() end
	timer.performWithDelay(300, myclosure, 1)
	
end

function togglePause()
	
	if( isPaused == false )then

		-- pause transiitons, audio
		transition.pause()
		audio.pause()
	
		-- pause customers
		local customers = grp_main.customers
		for i=1, customers.numChildren do
	
			local c = customers[i]
			if(c.cust)then
		
				c = c.cust
			
			end
		
			if( c.curTimer )then

				timer.pause( c.curTimer )
			
			end
		
		end
	
		-- set pause
		isPaused = true
		
		-- set gui
		_G.gui.showOverlay()
		
	else
		isLevelView = false
		-- pause transiitons, audio
		transition.resume()
		audio.resume()
	
		-- pause customers
		local customers = grp_main.customers
		for i=1, customers.numChildren do
	
			local c = customers[i]
			if(c.cust)then
		
				c = c.cust
			
			end
		
			if( c.curTimer )then

				timer.resume( c.curTimer )
			
			end
		
		end
	
		-- set pause
		isPaused = false
		
		-- set gui
		_G.gui.hideOverlay()
				
	end
	
end

function onBlockTouch(e)

	return true
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	if(not grp_main.parent)then return end
	
	print('stop engine')
	
	Runtime:removeEventListener('touch', onScreenTouch)
	Runtime:removeEventListener('enterFrame', onEnterFrame)
	
	_G.gui.stopModule()
	
	dragObject = nil
	returnObjects = {}
	countdownObjects = {}
	itemsTrashed = 0
	
	transition.cancel()
	
end

function killModule()
	
	if(not grp_main.parent)then return end
	
	--_G.gui.killModule()
	
	_G.layer_stage.drag:removeSelf()
	_G.layer_stage.drag = nil
	
	_G.mixer.killSFX()
	grp_main:removeSelf()
	grp_main = nil
	
end
