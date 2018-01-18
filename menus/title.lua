
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main

--------------------------- INIT

function buildModule()

	-- build main
	grp_main = util.addGroup(_G.layer_stage, 'grp_main', 0, 0, 1)
	
	buildTitleScreen()

	-- set module
	_G.curModule = _G.title
	
end

function buildTitleScreen()
	
	-- background 
	local bg = util.addGroup(grp_main, 'background', 0, 0, 1)
	util.addFill(bg, 'solid', .8, .8, .8, 1, 0, 0, 1366, 768)
	
	-- titles
	util.addText('"HARLEM HUSTLE"', grp_main, 'txt', 'bold', 0, -80, 70, .2, .2, .2)
	util.addText('Prototype: ' .. _G.vstring, grp_main, 'txt', 'bold', 0, -20, 24, .2, .2, .2)
	
	-- buttons
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 220, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 220-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 220-12, 80-12)
	util.addText('MAP DEMO', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('MAP DEMO', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'map'
	btn.num = 3
	btn.x = 0
	btn.y = 110
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 220, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 220-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 220-12, 80-12)
	util.addText('LEVEL ONE', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('LEVEL ONE', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'engine'
	btn.num = 1
	btn.x = -230
	btn.y = 200
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 220, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 220-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 220-12, 80-12)
	util.addText('LEVEL TWO', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('LEVEL TWO', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'engine'
	btn.num = 2
	btn.x = 0
	btn.y = 200
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 220, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 220-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 220-12, 80-12)
	util.addText('LEVEL THREE', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('LEVEL THREE', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'engine'
	btn.num = 3
	btn.x = 230
	btn.y = 200
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 320, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 320-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 320-12, 80-12)
	util.addText('CEELO DEMO', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('CEELO DEMO', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'ceelo'
	btn.y = 290
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
end

--------------------------- INPUT:

function onBtnTouch(e)

	if(e.phase~='began')then return end
	
	killModule()
	
	e.target.over.alpha = 1
	if( e.target.id == 'engine' )then
		
		_G.engine.buildModule( e.target.num )
		
	end
	if( e.target.id == 'ceelo' )then
		
		_G.ceelo.buildModule()
		
	end
	if( e.target.id == 'map' )then
		
		_G.map.buildModule()
		
	end
	
end

--------------------------- METHODS:


--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()
	_G.TutorialData.displaying = false
	grp_main:removeSelf()
	grp_main = nil
	
end

