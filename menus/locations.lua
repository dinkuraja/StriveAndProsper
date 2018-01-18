
module(..., package.seeall)

-------------------------- DATA

local lData = {}

lData[0] = {}
lData[0].name = 'Ceelo'

lData[1] = {}
lData[1].name = 'Heggies - 125th Street'

lData[2] = {}
lData[2].name = 'Art Stand'

lData[3] = {}
lData[3].name = 'Blackdoor Recordings'

lData[4] = {}
lData[4].name = "Ferg's Apparel"

lData[5] = {}
lData[5].name = "Copeland's"

-------------------------- VARIABLES

local grp_main
local isAnim = false
local backClosure = nil
local curNum = 0
local info = nil
--------------------------- INIT

function buildModule(num)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 10, 1)
	
	-- build map
	curNum = num
	buildMenu(num)
	isAnim = true
	timer.performWithDelay(050, showMenu)
		
end

function buildMenu(num)

	-- bg
	_G.util.addImage('graphics/menus/locations/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. lData[num].name .. ' ', grp_main, 'txt', 'bangers', 0, -226, 60, 1, .86, 0)
	
	-- img
	_G.util.addImage('graphics/menus/locations/img0' .. num .. '.png', grp_main, 'img', 0, 0, 1, 1, 0, 1)
	
	-- buttons
	local btn = _G.util.addGroup(grp_main, 'play', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/btn.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' PLAY ', btn, 'txt', 'bangers', 12, -5, 36, 1, .86, 0)
	btn.x = 0
	btn.y = 223
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = _G.util.addGroup(grp_main, 'close', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/close.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' X ', btn, 'txt', 'bangers', 12, -5, 36, 237/255, 28/255, 36/255)
	btn.x = 420
	btn.y = -223
	btn:addEventListener('touch', onBtnTouch)
	
	-- facts
	for i=1, 3 do
		
		local item = _G.util.addGroup(grp_main, 'item'..i, 0, 0, 1)
		
		-- base
		_G.util.addImage('graphics/menus/achievements/image.png', item, 'image', 2, 0, .9, .9, 0, 1)
		item.image.anchorX = 0
		item.image.anchorY = 0
		
		_G.util.addImage('graphics/menus/achievements/entry.png', item, 'entry', 134, 0, .9, .9, 0, 1)
		item.entry.anchorX = 0
		item.entry.anchorY = 0
		
		-- title
		_G.util.addText('Fact Title ' .. i .. ' ', item, 'title', 'bangers', 223, 22, 24, 1, .8, 0)
		item.title.ancohrX = 0
		
		-- info
		local info = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
		_G.util.addTextMulti(info, item, 'info', 'native', 175, 38, 20,  280, 'left', 1, 1, 1)
		item.info.anchorX = 0
		item.info.anchorY = 0
		
		-- position
		item.x = -464
		item.y = -163 + ((i-1)*114)
		
	end
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

function buildTag(info)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 0, 1)
	
	-- artwork
	_G.util.addImage('graphics/map/icons/tag_bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. info.name .. ' ', grp_main, 'title', 'bangers', 0, -140, 46, 0, 0, 0)
	
	local infoText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere tortor non ligula ve blah leh'
	_G.util.addTextMulti( info.detail, grp_main, 'info', 'native', 0, -90, 18, 360, 'left', 0, 0, 0)
	grp_main.info.anchorY = 0
	
	-- close
	local btn = _G.util.addGroup(grp_main, 'close', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/close.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' X ', btn, 'txt', 'bangers', 12, -5, 36, 237/255, 28/255, 36/255)
	btn.x = 196
	btn.y = -154
	btn:addEventListener('touch', onBtnTouch)
	
	-- init
	grp_main.endY = grp_main.y
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
	-- show window
	isAnim = true
	timer.performWithDelay(050, showMenu)
		
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	--print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='play')then
		
		hideMenu()
		
		if(curNum==0)then

			local levelClosure = function() return _G.ceelo.buildModule() end
			_G.map.setLevelClosure(levelClosure)
	
		else
		
			local levelClosure = function() return _G.engine.buildModule( curNum ) end
			_G.map.setLevelClosure(levelClosure)
		
		end
		
		_G.map.exitMap()
		
	end
	if not _G.TutorialData.displaying then
		if(e.target.id=='close')then
			
			_G.gui.hideTransOverlay()
			hideMenu()
			
		end
	end
	
end

function onTutorialTouch(e)
        print( "Come to Touch tutorial.." )
	if(e.phase~='began')then return end
	if(e.target.alpha ~= 1)then return end
        
         _G.TutorialData.displaying = false

        -- hide window
        local endClosure = function() return _G.util.dropImage(info) end	
        transition.to( info, {delay=0, time=100, y=info.y+40, alpha=0, transition=easing.inBack,onComplete=endClosure})
end
-- hide Tutorial window
function hideTutorial()
        print( "Come to Hide tutorial.." )
        _G.util.dropImage(info)
        
end

function setTutorial(num)
    print( "Come to set tutorial.." )
    _G.TutorialData.displaying = true
    
    info = _G.gui.buildInfoPanel('below', "Customers arrive at here.",grp_main)
    info.y = 100 + 40
    --info.x = 1000
    transition.to( info, {delay=1000, time=100, y= 150, alpha=1, transition=easing.outBack})
    info.step = 0
    info:addEventListener('touch', onTutorialTouch)

end
--------------------------- METHODS:
local function displayTutorial(e)
    print( "Display Tutorial" )
    _G.gui.setTutorial("playStage",{ fY = 100 + 40,y=160, group=grp_main })
    
    return true
end
function showMenu()
        print( "Show Menu..." )
	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad,onComplete=displayTutorial})
	isAnim = false
	
end

function hideMenu()
	_G.TutorialData.displaying = false
	_G.gui.unSetAtionPerform()
	
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

