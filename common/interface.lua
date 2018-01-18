
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main

local pinColors = {'#9742B8','#AD392B','#274DA1','#45C499','#84C441','#FBAE17'}

--------------------------- OBJECTS:

function buildButton(title, size, color, icon)

	local btn = display.newGroup()
	
	_G.util.addImage('graphics/interface/button'..size..'/shad.png', btn, 'shad', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/button'..size..'/fill.png', btn, 'fill', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/button'..size..'/fill.png', btn, 'down', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/button'..size..'/fill.png', btn, 'over', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/button'..size..'/bevel.png', btn, 'bevel', 0, 0, 1, 1, 0, 1)
	_G.util.addText(title, btn, 'txt', 'castledownheavy', 0, -1, 32,  1, 1, 1)
	
	if(icon)then
		
		_G.util.addImage('graphics/interface/icons/'..icon..'.png', btn, 'icon', 0, 0, 1, 1, 0, 1)
		btn.icon.x = (btn.fill.width * -.5) + 26
		btn.txt.x = btn.txt.x + 13
		
	end	
	
	btn.fill:setFillColor( _G.util.convertHexToRGB(color) )
	btn.down:setFillColor( 0,0,0,.5 )
	btn.over:setFillColor( 1,1,1,.5 )
	
	btn.id = title:lower()
	
	return btn
	
end

function buildRoundButton(icon, color)

	local btn = display.newGroup()
	
	_G.util.addImage('graphics/interface/round/shad.png', btn, 'shad', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/round/fill.png', btn, 'fill', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/icons/'..icon..'.png', btn, 'icon', -1, -3, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/round/fill.png', btn, 'down', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/round/fill.png', btn, 'over', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/round/bevel.png', btn, 'bevel', 0, 0, 1, 1, 0, 1)
	
	btn.fill:setFillColor( _G.util.convertHexToRGB(color) )
	btn.down:setFillColor( 0,0,0,.5 )
	btn.over:setFillColor( 1,1,1,.5 )
	
	btn.id = icon:lower()
	
	return btn
	
end

function buildKey(letter, color)

	local btn = display.newGroup()
	
	_G.util.addImage('graphics/interface/keyboard/shad.png', btn, 'shad', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/keyboard/fill.png', btn, 'fill', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/keyboard/fill.png', btn, 'fill2', 0, 0, 1, 1, 0, 0)
	_G.util.addText(letter, btn, 'txt', 'castledown', -1, -1, 62,  1, 1, 1)
	_G.util.addText(letter:lower(), btn, 'txt_lower', 'castledown', -1, -1, 56,  1, 1, 1)
	_G.util.addImage('graphics/interface/keyboard/fill.png', btn, 'off', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/keyboard/fill.png', btn, 'over', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/keyboard/bevel.png', btn, 'bevel', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/keyboard/bevelB.png', btn, 'bevelB', 0, 0, 1, 1, 0, 1)
	
	btn.fill:setFillColor( _G.util.convertHexToRGB(color) )
	btn.off:setFillColor( 0,0,0,.2 )
	btn.over:setFillColor( 1,1,1,.5 )
	btn.bevelB.alpha = 0
	btn.txt_lower.alpha = 0
	
	if(_G.launchType == 'Android')then
		btn.txt.y = btn.txt.y - 5
		btn.txt_lower.y = btn.txt_lower.y - 5
	end
	
	btn.id = letter:lower()
	
	return btn
	
end

function buildKeyboardKey(size, value, color)

	local btn = display.newGroup()
	
	-- bg
	util.addImage('graphics/keyboard/key'..size..'/shad.png', btn, 'shad', 0, 0, 1, 1, 0, 1)
	util.addImage('graphics/keyboard/key'..size..'/fill.png', btn, 'fill', 0, 0, 1, 1, 0, 1)
	util.addImage('graphics/keyboard/key'..size..'/fill.png', btn, 'over', 0, 0, 1, 1, 0, 0)
	util.addImage('graphics/keyboard/key'..size..'/bevel.png', btn, 'bevel', 0, 0, 1, 1, 0, 1)
	
	-- single letter key
	if( value:len() == 1 )then
	
		util.addText(value:lower(), btn, 'lower', 'castledown', 0, 0, 32, 0, 0, 0)
		util.addText(value:upper(), btn, 'upper', 'castledown', 0, 0, 32, 0, 0, 0)
		btn.lower.alpha = 1
		btn.upper.alpha = 0
		
		btn.fill:setFillColor( util.convertHexToRGB('#edeef0') )
		btn.over:setFillColor( util.convertHexToRGB('#84c441') )
		
	end
	
	-- special keys
	if( value:len() > 1 )then
	
		--util.addText(value, btn, 'title', 'castledown', 0, 0, 36, 0, 0, 0)
		if( value == 'Delete' )then
		
			util.addImage('graphics/keyboard/icons/delete.png', btn, 'icon', 0, 0, 1, 1, 0, 1)
			btn.fill:setFillColor( util.convertHexToRGB('#b4b5b7') )
			
		end
		if( value == 'Shift' )then
		
			util.addImage('graphics/keyboard/icons/up.png', btn, 'icon', 0, 0, 1, 1, 0, 1)
			btn.fill:setFillColor( util.convertHexToRGB('#b4b5b7') )
			btn.over:setFillColor( util.convertHexToRGB('#84c441') )
			
		end
		if( value == 'Caps' )then
		
			util.addImage('graphics/keyboard/icons/up.png', btn, 'icon', 0, 0, 1, 1, 0, 1)
			btn.fill:setFillColor( util.convertHexToRGB('#b4b5b7') )
			btn.over:setFillColor( util.convertHexToRGB('#84c441') )
			
		end
		
		if( value == 'Back' )then
		
			util.addImage('graphics/keyboard/icons/back.png', btn, 'icon', -50, 0, 1, 1, 0, 1)
			util.addText(value, btn, 'lower', 'castledownheavy', 20, -2, 32, 1, 1, 1)
			btn.fill:setFillColor( util.convertHexToRGB('#b4b5b7') )
			btn.over:setFillColor( util.convertHexToRGB('#84c441') )
			
		end
		
		if( value == 'Save' )then
		
			util.addImage('graphics/keyboard/icons/save.png', btn, 'icon', -50, 0, 1, 1, 0, 1)
			util.addText(value, btn, 'lower', 'castledownheavy', 20, -2, 32, 1, 1, 1)
			btn.fill:setFillColor( util.convertHexToRGB('#84c441') )
			btn.over:setFillColor( util.convertHexToRGB('#ffffff') )
			
		end
		
	end

	btn.id = value
	
	return btn
	
end

function buildCheckbox(title)

	local btn = display.newGroup()
	
	_G.util.addImage('graphics/interface/checkbox/bg.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/checkbox/outline.png', btn, 'outline', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/interface/checkbox/check.png', btn, 'check', 0, 0, 1, 1, 0, 1)
	_G.util.addText(title, btn, 'txt', 'castledownheavy', 0, 0, 31,  .3, .3, .3)
	btn.txt.anchorX = 0 
	btn.txt.x = 30
	
	btn.id = title
	
	return btn

end

function buildClosePin(color)

	local grp = display.newGroup()
	
	_G.util.addImage('graphics/interface/clip/shad.png', grp, 'shad', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/clip/fill.png', grp, 'fill', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/clip/bevel.png', grp, 'bevel', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/clip/pin.png', grp, 'pin', 0, 0, 1, 1, 0, 1)
	
	grp.shad.anchorY = 1
	grp.fill.anchorY = 1
	grp.bevel.anchorY = 1
	grp.pin.anchorY = 1
	
	local fillNum = math.floor(math.random()*#pinColors)+1
	local color = pinColors[fillNum]
	
	grp.fill:setFillColor( _G.util.convertHexToRGB(color) )
	
	return grp
	
end

function buildAvatarButton()

	local btn = display.newGroup()
	
	_G.util.addImage('graphics/interface/avatar/over.png', btn, 'over', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/avatar/fill.png', btn, 'fill', 0, 0, 1, 1, 0, 1)
	_G.util.addImage('graphics/interface/avatar/bevel.png', btn, 'bevel', 0, 0, 1, 1, 0, 1)
	
	local icon = _G.util.addGroup(btn, 'icon', -110, 0, 1)
	_G.util.addImage('graphics/avatars/icons/outline.png', icon, 'outline', 0, 0, 1, 1, 0, 0)
	_G.util.addImage('graphics/avatars/icons/blank.png', icon, 'blank', 0, 0, 1, 1, 0, 1)
	--_G.util.addImage('graphics/avatars/icons/avatar1.png', icon, 'avatar', 0, 0, 1, 1, 0, 0)
	
	_G.util.addText('New Player', btn, 'name', 'castledownheavy', -50, 0, 32,  1, 1, 1)
	btn.name.anchorX = 0
	
	--btn.fill:setFillColor( _G.util.convertHexToRGB( pinColors[num] ) )
	btn.over.alpha = 0
	
	return btn
	
end

--------------------------- SCROLLBOX EVENTS:

