--system.setIdleTimer( false )
--system.activate ("multitouch")

--[[function print()
end
]]--
-------------------------- SET DEVICE FAMILY

_G.launchType	 = 'Android'
_G.vstring 		 = '0.1.0'
_G.fbAppID 		 = '1635645203428302'
_G.vungleAppID	 = '5750ce6781f316c52900001d'
display.setStatusBar( display.HiddenStatusBar )


-------------------------- IMPORTS & SETTINGS

_G.json			 = require("json")
_G.physics 		 = require("physics")
_G.ads 			 = require("ads")
_G.facebook      = require("plugin.facebook.v4")
_G.twitter 		 = require("plugin.twitter")
_G.util 		 = require("common.utilities")
--_G.doubleclick 	 = require('plugin.doubleclick')

-------------------------- PHYSICS ENGINE INIT

physics.start()
physics.setScale( 60 )
physics.setVelocityIterations( 12 )
physics.setPositionIterations( 24 )
physics.setGravity (0, 20)
physics.setReportCollisionsInContentCoordinates( true )
audio.setVolume(1)

-------------------------- GLOBAL VARIABLES

_G.DEBUG_LEVEL = 4

_G.audioFromLaunch = true
_G.baseWidth = 1024
_G.baseHeight = 768
_G.deviceWidth = display.viewableContentWidth
_G.deviceHeight = display.viewableContentHeight
_G.deviceScale = 0
_G.deviceName = 'Other'
_G.heightOffset = 0
_G.widthOffset = 0
_G.inputPause = true

_G.TutorialData = require("TutorialHelper")

_G.curLevelNum = 0
_G.curStageNum = 1
_G.settings = nil
_G.userdata = nil
_G.levelInfo = nil

--------------------- Tutorial Globle Values
--_G.isTutorial = true -- Check Tutorial remaining for 
--_G.autoHideTutorial = 3000 -- In milliseconds
--_G.tutorialNo = 0 -- Check Tutorial is Running
--_G.tutorialRunning = false -- Check Tutorial is Running
-- 

_G.levelUpEarned = false
_G.loggedIntoGC = false

_G.isFirstLaunch = false
_G.isNewDay = false

-------------------------- DISPLAY LAYERS

_G.layer_all = display.newGroup()
_G.layer_bg = display.newGroup()
_G.layer_stage = display.newGroup()
_G.layer_menus = display.newGroup()
_G.layer_modal = display.newGroup()
_G.layer_loader = display.newGroup()

-------------------------- CONSTRUCTION

function buildLoader()

	-- build loader
	_G.loader = require("menus.loader")
	_G.loader.buildModule()
	_G.loader.showLoader()
	
	-- load classes
	loadClasses()
	
	-- init app
	initApp()
	
end

function loadClasses()
	_G.sileview 		= require("slideView")
	_G.mixer 			= require("audio.mixer")
	_G.customers        = require("engine.customers")
	_G.engine 			= require("engine.engine")
	_G.ceelo 			= require("engine.ceelo")
	_G.gui 				= require("engine.gui")

	_G.parse 			= require("info.getParse")
	_G.profile			= require("info.profile")
	_G.loadsave			= require("info.loadsave")

	_G.title			= require("menus.title")
	_G.map				= require("menus.map")
	_G.levelselect      = require("menus.levelselect")
	_G.results			= require("menus.results")
	_G.upgrades			= require("menus.upgrades")
	_G.fbconnect        = require("menus.fbconnect")
	_G.achievements     = require("menus.achievements")
	_G.shop				= require("menus.shop")
	_G.locations        = require("menus.locations")
	_G.pause			= require("menus.pause")
	_G.options			= require("menus.options")
	_G.levelup			= require("menus.levelup")
	_G.iap 				= require("menus.iap")
	_G.welcome 			= require("menus.welcome")
	
	-- game network
	_G.gameNetwork      = require( "gameNetwork" )
	
end
--- Initial Tutorial setup
function setupTutorialsPoint()	
    local tutorial = _G.loadsave.loadTable("tutorials.json")
    --tutorial = nil
    if tutorial ~= nil then
        print("Tutorial not nill part")        
        _G.TutorialData.data = tutorial
    else
        _G.loadsave.saveTable(_G.TutorialData.defaultData,"tutorials.json")
        _G.TutorialData.data = _G.TutorialData.defaultData
    end
    
    -- _G.TutorialData.data = _G.TutorialData.defaultData

    -- _G.loadsave.print_r(_G.TutorialData)
    _G.TutorialData.getTotalDisplayTutorail()
    
 	_G.TutorialData.checkTutorialLevelData()
end

function initApp()
        
        -- Setup Tutorials setting
        setupTutorialsPoint()
        
	-- detect ratio
	_G.deviceScale = _G.baseHeight/_G.deviceHeight
	_G.heightOffset = (_G.baseHeight - _G.deviceHeight) * .5
	_G.deviceScale = 1/_G.deviceScale
	
	-- get device id
	_G.deviceName = ( system.getInfo( 'name' ) )
	
	-- android back button
	Runtime:addEventListener( "key", onKeyEvent )
	
	-- print settings
	print( 'device scale: ' .. _G.deviceScale .. ', device height: ' .. _G.deviceHeight .. ', offset h: ' .. _G.heightOffset .. ', offset w: ' .. _G.widthOffset)
	
	-- center and scale layers to height
	local allLayers = {'bg','stage','menus','modal','loader'}
	for i=1, #allLayers do
	
		_G['layer_' .. allLayers[i]].x = _G.baseWidth * .5
		_G['layer_' .. allLayers[i]].y = _G.baseHeight * .5
		_G['layer_' .. allLayers[i]].xScale = _G.deviceScale
		_G['layer_' .. allLayers[i]].yScale = _G.deviceScale
		
	end
		
	-- check for simulator
	if ( system.getInfo("environment") == "simulator" ) then
		
	    print('*** Corona Simulator ***')
		
	end
	
	-- check web
	--local isActive = _G.util.checkWeb()
	--if(isActive)then else return end
	
	-- pull settings
	_G.settings = _G.profile.loadSettings()
	if( not settings )then
		
		print('no settings found')
		_G.settings = _G.profile.buildSettings()
		
	else
		print('settings loaded')
	end
		
	-- pull userdata
	 _G.userdata = _G.profile.loadUserData()
	if( not userdata )then
		
		print('no userdata found')
		_G.userdata = _G.profile.buildUserData()
		
	else
		print('userdata loaded')
		print(_G.userdata.cash)
	end
	
	-- go into app
	launchApp()
	
end

function launchApp()

	-- init vungle
	-- _G.ads.init( 'vungle', _G.vungleAppID, _G.shop.onAdEvent )
	
	-- set store
	_G.store 		 = nil
	_G.iapIDs 		 = {}

	if( _G.launchType == 'Apple' )then
	
		_G.store = require("store")
		
		_G.iapIDs[1] 	 = 'Coins001'
		_G.iapIDs[2] 	 = 'Coins002'
		_G.iapIDs[3] 	 = 'Coins003'
		_G.iapIDs[4] 	 = 'Coins004'
		_G.iapIDs[5] 	 = 'Coins005'
		_G.iapIDs[6] 	 = 'Coins006'
		_G.iapIDs[7]  	 = 'Coins007'
		
		_G.iapIDs[8] 	 = 'Gems001'
		_G.iapIDs[9] 	 = 'Gems002'
		_G.iapIDs[10] 	 = 'Gems003'
		_G.iapIDs[11] 	 = 'Gems004'
		_G.iapIDs[12] 	 = 'Gems005'
		_G.iapIDs[13] 	 = 'Gems006'
		_G.iapIDs[14] 	 = 'Gems007'
			
	end
	
	-- flush user data
	if( _G.launchType == 'Debug' )then
		
		_G.userdata = _G.profile.buildUserData()
		_G.userdata.cash = 1000000
		_G.userdata.gems = 1000000
		
	end
	
	-- load achievements
	_G.achievements.loadDataSet()
	
	-- load global sounds
	_G.mixer.loadNavSFX()
	
	_G.mixer.loadMusic('map_dice')
	_G.mixer.playMusic()

	
	
	-- init storefront
	if( _G.store )then
	
		local myclosure = function() return _G.iap.init() end
		timer.performWithDelay(4000, myclosure, 1)
		
	end
	
	-- check/set date
	local date = os.date( "*t" )
	
	
	if( _G.userdata.lastDate == 'none' )then 
		
		_G.userdata.lastDate=date
		_G.isFirstLaunch = true
		
	else

		-- exceptions: end of year and end of leap year
		local dayDiff = date.yday - _G.userdata.lastDate.yday
		if( dayDiff==1 or dayDiff==-364 or dayDiff==-365 )then
		
			_G.achievements.updateAchievement('dayStreak', 1)
			
		elseif(dayDiff~=0)then
			
			_G.achievements.updateAchievement('dayStreak', 0)
			
		end
		
		-- print day streak
		if( _G.userdata.stats.dayStreak>0 )then
		
			print('day streak: ' .. _G.userdata.stats.dayStreak )
			
		end
		
		-- if new day
		if( (dayDiff ~= 0) )then
		
			_G.isNewDay = true
			_G.userdata.lastDate=date
			
		end
		
	end
	
	
	
	print(_G.isFirstLaunch)
	--_G.isFirstLaunch = true
	
	local function loadfunction(e)
	
	local function loadFirstTimeTutorial(e)
		
		local myImages = {
	"graphics/firstTut/1.png",
	"graphics/firstTut/2.png",
	"graphics/firstTut/3.png",
	"graphics/firstTut/4.png",
	"graphics/firstTut/5.png",
	"graphics/firstTut/6.png"
}		

slideView.new( myImages )
		
		
		end
	
	
	if(_G.isFirstLaunch == true)then


loadFirstTimeTutorial()




	else

local myclosure = function() return _G.map.buildModule() end
timer.performWithDelay(3000, myclosure, 1)


end	
	end
	
	
	-- TESTING ONLY:
	-- _G.userdata.cash = 1000000
	-- _G.userdata.gems = 1000000
	
	-- map open
	--local myclosure = function() return _G.map.buildModule() end
	timer.performWithDelay(2000, loadfunction, 1)
	
	-- build game
	--_G.title.buildModule()
	--_G.engine.buildModule(_G.DEBUG_LEVEL, false)
	--_G.gui.buildGoal()
	--_G.customers.buildArtwork(1)
	--_G.ceelo.buildModule()
	--_G.mixer.loadNavSFX()
	--_G.locations.buildTag('hey')
	--_G.welcome.buildModule(0)
	
	-- menus
	--_G.achievements.buildModule()
	--_G.upgrades.buildModule()
	--_G.shop.buildModule('vip characters')
	
	-- hide loader
	--_G.loader.hideLoader()
	
	-- enable input
	_G.inputPause = false
	
end

-------------------------- GLOBAL FUNCTIONS

function toggleInputPause(type)
	
	_G.inputPause = type
	
end 

function printMemUsage()
	   
	local memUsed = (collectgarbage("count")) / 1000
	local texUsed = system.getInfo( "textureMemoryUsed" ) / 1000000

	print("\n---------MEMORY USAGE INFORMATION---------")
	print("System Memory Used: " .. string.format("%.03f", memUsed), "Mb")
	print("Texture Memory Used: " .. string.format("%.03f", texUsed), "Mb")
	print("------------------------------------------\n")

	return true
	
end

function onDebugRender()

	-- print( #_G.userdata.badges )
	
end

-------------------------- ANDROID BACK BUTTON

function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   
   --print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then
	   
	   -- on android back do something
	   -- executeBackClosure

   end
   
   if( keyName=='space' and phase=='down' )then
	   
	   printMemUsage()
	   
   end
   
   if( keyName=='s' and phase=='down' )then
	   
	   local cap = display.captureScreen( true )
	   cap:removeSelf()
	   
   end
   
   return false
   
end

------------------------ INIT

function print_r( message )
	_G.loadsave.print_r(message)
end

buildLoader()

