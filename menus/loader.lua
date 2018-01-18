
module(..., package.seeall)

-------------------------- TIPS

local tips = {}
tips[1] = 'UPGRADE YOUR SHOP TO EARN MORE CASH'
tips[2] = 'PLAY BACK TO BACK DAYS FOR REWARDS'
tips[3] = 'PURCHASE CELEBRITIES TO BOOST YOUR SCORES'
curTip = 0

-------------------------- VARIABLES

local grp_main

--------------------------- INIT

function buildModule()

	-- build main
	grp_main = util.addGroup(_G.layer_loader, 'grp_main', 0, 0, 1)
	
	buildLoader()
	
end

function buildLoader()
	
	-- add black
	local black = _G.util.addFill(grp_main, 'black', 0, 0, 0, .8, 0, 0, 2000, 768)
	
	-- add loading screen
	local screen = _G.util.addGroup(grp_main, 'screen', 0, 0, 1)
	local col = 0
	local row = 0
	
	for i=1, 4 do
		
		local t = _G.util.addImage('graphics/loader/loader_0' .. i .. '.png', screen, 't', 0, 0, 1, 1, 0, 1)
		t.x = 683 * col
		t.y = 384 * row
		t.anchorX = 0
		t.anchorY = 0
		
		col = col + 1
		if( col==2 )then
			col = 0
			row = row + 1
		end
		
	end
	
	-- position
	screen.x = -683
	screen.y = -384
	
	-- add tip
	local tip = _G.util.addGroup(screen, 'tip', 683, 640, 1)
	local box = _G.util.addImage('graphics/menus/loader/tipbox.png', tip, 'box', 0, 0, 1, 1, 0, 1)
	local msg = _G.util.addGroup(tip, 'msg', 0, 0, 1)
	
	_G.util.addText(' TIP OF THE DAY: ', msg, 'title', 'bangers', 0, 0, 22,  1, .86, 0)
	msg.title.anchorX = 0
	_G.util.addText(' ', msg, 'txt', 'bangers', 0, 0, 22,  1, 1, 1)
	msg.txt.anchorX = 0
	
	msg.txt.x = msg.title.x + msg.title.width + 4
	msg.x = msg.width * -.5
	box.width = msg.width + 32
	
	-- set loader
	screen.endY = screen.y
	screen.y = 800
	screen.startY = screen.y
	black.alpha = 0
	
	-- test
	--timer.performWithDelay(2000, showLoader)
	--timer.performWithDelay(4000, hideLoader)
	
end

--------------------------- INPUT:

function onBlockTouch(e)
	
	return true
	
end

function onBlockTap(e)
	
	return true
	
end

--------------------------- METHODS:

function showLoader()
	
	local msg = grp_main.screen.tip.msg
	local box = grp_main.screen.tip.box
	
	-- set text ---
	curTip = curTip + 1
	if(curTip>#tips)then curTip=1 end
	
	msg.txt.text = tips[curTip]
	
	msg.txt.x = msg.title.x + msg.title.width + 4
	msg.x = msg.width * -.5
	box.width = msg.width + 32
	
	---------------
	
	transition.to(grp_main.black, 	{delay=0000, time=300, alpha=1, transition=easing.outQuad})
	transition.to(grp_main.screen, 	{delay=0200, time=300, y=grp_main.screen.endY, transition=easing.outQuad})
        
end

function hideLoader()
	
	_G.TutorialData.displaying = false

	transition.to(grp_main.screen, 	{delay=0200, time=300, y=grp_main.screen.startY, transition=easing.inQuad})
	transition.to(grp_main.black, 	{delay=0200, time=300, alpha=0, transition=easing.inQuad})
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

