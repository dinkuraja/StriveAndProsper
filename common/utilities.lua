
module(..., package.seeall)

local http = require("socket.http")
local ltn12 = require("ltn12")

-------------------------- GRAPHICS:

function addGroup(parent, name, myX, myY, myA)

	local grp = display.newGroup()
	grp.x = myX
	grp.y = myY
	grp.id = name
	grp.alpha = myA
	grp.id = name
	
	parent:insert(grp)
	parent[name] = grp
	
	return grp
	
end

function addImage(path, parent, name, myX, myY, mySX, mySY, myR, myA)

	local temp = display.newImage(path, true)
	if( not temp )then
	
		print('no image at that path')
		return
		
	end
	
	local imgW = temp.width
	local imgH = temp.height
	temp:removeSelf()
	temp = nil
	
	local img = display.newImageRect( path, imgW, imgH )
	img.x = myX
	img.y = myY
	img.xScale = mySX
	img.yScale = mySY
	img.rotation = myR
	img.alpha = myA
	img.id = name
	
	--img:setFillColor(1,1,1,1)
	
	parent:insert(img)
	parent[name] = img
	
	return img
	
end

function addFill(parent, name, myR, myG, myB, myA, myX, myY, myW, myH)
	
	local fill = display.newRect(myX, myY, myW, myH)
	fill:setFillColor(myR, myG, myB, myA)
	
	parent:insert(fill)
	parent[name] = fill
	fill.id = name
	
	return fill
	
end

function addRoundRect(parent, name, myR, myG, myB, myA, myX, myY, myW, myH, myRad)
	
	local fill = display.newRoundedRect( myX, myY, myW, myH, myRad )
	fill:setFillColor(myR, myG, myB, myA)
	
	parent:insert(fill)
	parent[name] = fill
	fill.id = name
	
	return fill
	
end

function addText(myText, parent, name, font, myX, myY, size, myR, myG, myB)

	local myfont = font
	
	----------------------------
	
	local txt
	if( myfont == 'native' )then
		txt = display.newText( myText, myX, myY, native.systemFont, size )
	elseif( myfont == 'bold')then
		txt = display.newText( myText, myX, myY, native.systemFontBold, size )
	else
		txt = display.newText( myText, myX, myY, font, size )
	end
	
	-- check font y position: Android
	if( string.find(myfont, 'bangers') )then
	
		if(_G.launchType=='Apple')then
		
			myY = myY + (5 * (size/26) )
			
		end
		
	end
	-------------------

	txt.x = myX
	txt.y = myY
	txt.startX = myX
	txt.startY = myY
	
	txt:setFillColor(myR, myG, myB)
	
	parent:insert(txt)
	parent[name] = txt
	
	updateText(txt, myText)
	
	return txt
	
end

function updateText(field, myText)
	
	field.text = myText
	checkAlign(field)
	field.x = field.startX
	field.y = field.startY
	
end

function addTextMulti(myText, parent, name, myFont, myX, myY, size, myWidth, myAlign, myR, myG, myB)
	
	-- check font y position: Android
	if( string.find(myFont, 'bangers') )then
	
		if(_G.launchType=='Apple')then
		
			myY = myY + (5 * (size/26) )
			
		end
		
	end
	-------------------
	
	
	local options = {}
	
	options = 
	{
	    text = myText,     
	    x = myX,
	    y = myY,
	    width = myWidth, 
	    font = myFont,   
	    fontSize = size,
	    align = myAlign
	}
	
	if( myFont == 'native' )then
	
		--print('is native multi')
		options = 
		{
		    text = myText,     
		    x = myX,
		    y = myY,
		    width = myWidth, 
		    font = native.systemFont,   
		    fontSize = size,
		    align = myAlign
		}
		
	end

	local txt = display.newText( options )
	txt:setFillColor( myR, myG, myB )
	
	parent:insert(txt)
	parent[name] = txt
	
	return txt
	
end

function checkAlign(txt)

	if(txt.align == "left")then
		txt:setReferencePoint(display.TopLeftReferencePoint)
	end
	
	if(txt.align == "center")then
		txt:setReferencePoint(display.TopCenterReferencePoint)
	end
	
	if(txt.align == "right")then
		txt:setReferencePoint(display.TopRightReferencePoint)
	end
	
end

--------------------------- BUTTONS:

function addButton(parent, name, myX, myY, myW, myH)
	
	local btn = util.addGroup(grp_main, 'btn', 0, 0, 1)
	util.addFill(btn, 'bg', .3, .3, .3, 1, 0, 0, 320, 80)
	util.addFill(btn, 'bg', .6, .6, .6, 1, 0, 0, 320-12, 80-12)
	util.addFill(btn, 'over', .9, .9, .9, 1, 0, 0, 320-12, 80-12)
	util.addText('LEVEL DEMO', btn, 'txt', 'bold', 2, 2, 26, 0, 0, 0)
	util.addText('LEVEL DEMO', btn, 'txt', 'bold', 0, 0, 26, 1, 1, 1)
	btn.id = 'engine'
	btn.y = 100
	btn.over.alpha = 0
	btn:addEventListener('touch', onBtnTouch)
	
end

-------------------------- FORMATTING:

function formatSecToString(sec)
	
	local min = math.floor(sec / 60)
	local rSec = sec - (min * 60)
	local secStr = nil
	if(rSec < 10)then
		secStr = '0' .. rSec
	else
		secStr = '' .. rSec
	end

	local tStr = min .. ":" .. secStr
	
	return tStr
	
end

function formatScoreToString(score)

	local scoreStr
	if(score < 10)then
		scoreStr = "0" .. score
	else
		scoreStr = "" .. score
	end
	
	return scoreStr
	
end

function formatEndScoring(myNum)

	if( not myNum )then
	
		myNum = 0
		
	end

	local scoreString = "" .. myNum
	
	local scoreLength = scoreString:len()
	local bil
	local mil
	local thous
	local hund

	if(scoreLength == 12)then

		bil = scoreString:sub(1,3)
		mil = scoreString:sub(4,6)
		thous = scoreString:sub(7,9)
		hund = scoreString:sub(10,12)
		
		scoreString = bil .. "," .. mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 11)then

		bil = scoreString:sub(1,2)
		mil = scoreString:sub(3,5)
		thous = scoreString:sub(6,8)
		hund = scoreString:sub(9,11)
		
		scoreString = bil .. "," .. mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 10)then

		bil = scoreString:sub(1,1)
		mil = scoreString:sub(2,4)
		thous = scoreString:sub(5,7)
		hund = scoreString:sub(8,10)
		
		scoreString = bil .. "," .. mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 9)then

		mil = scoreString:sub(1,3)
		thous = scoreString:sub(4,6)
		hund = scoreString:sub(7,9)
		
		scoreString = mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 8)then

		mil = scoreString:sub(1,2)
		thous = scoreString:sub(3,5)
		hund = scoreString:sub(6,8)
		
		scoreString = mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 7)then

		mil = scoreString:sub(1,1)
		thous = scoreString:sub(2,4)
		hund = scoreString:sub(5,7)
		
		scoreString = mil .. "," .. thous .. "," .. hund
		
	end
	if(scoreLength == 6)then
		
		thous = scoreString:sub(1,3)
		hund = scoreString:sub(4,6)
		
		scoreString = thous .. "," .. hund
		
	end
	if(scoreLength == 5)then
		
		thous = scoreString:sub(1,2)
		hund = scoreString:sub(3,5)
		
		scoreString = thous .. "," .. hund
		
	end
	if(scoreLength == 4)then
		
		thous = scoreString:sub(1,1)
		hund = scoreString:sub(2,4)
		
		scoreString = thous .. "," .. hund
		
	end
	if(scoreLength <= 3)then
		
		hund = scoreString:sub(1,3)
		
		scoreString = hund
		
	end
	if(scoreLength <= 2)then
		
		hund = scoreString:sub(1,2)
		
		scoreString = hund
		
	end
	if(scoreLength <= 1)then
		
		hund = scoreString:sub(1,1)
		
		scoreString = hund
		
	end
	
	return scoreString
	
end

-------------------------- CONVERT COLORS:

function convertRGB(r, g, b)
   assert(r and g and b and r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0, "You must pass all 3 RGB values within a range of 0-255");
   return r/255, g/255, b/255;
end

function convertHexToRGB(hexCode)
   assert(#hexCode == 7, "The hex value must be passed in the form of #XXXXXX");
   local hexCode = hexCode:gsub("#","")
   return tonumber("0x"..hexCode:sub(1,2))/255,tonumber("0x"..hexCode:sub(3,4))/255,tonumber("0x"..hexCode:sub(5,6))/255;
end

-------------------------- EXPLOSIONS:

function explodeConfetti(startX, startY, target, type)
	
	-- add explosion
	local cNum = 1
	local cColors = {'#274da1','#ffffff','#efe933','#9842b9','#b5371c'}
	util.table.shuffle(cColors)
	
	for i=1, 50 do
		
		local part = display.newGroup()
		util.addImage("graphics/confetti/c" .. cNum .. ".png", part, 'img', 0, 0, 1, 1, 0, 1)
		part.x = startX
		part.y = startY
		part.img:setFillColor(util.convertHexToRGB(cColors[cNum]))
		target:insert(part)
		
		-- update
		cNum = cNum + 1
		if( cNum > 5 )then
			cNum = 1
		end
		
		-- animate
		local partFX = ((math.random() * -10) + 5) * .3
		local partFY = (((math.random() * -10) - 5) * .1)
		local partS = (math.random() * .4) + .4
		local partT = ((math.random() * 10) + -5) * .1
		local partR = (math.random() * 360)
		
		if(type == 'right')then
		
			partFX = partFX + 1
			
		end
		if(type == 'left')then
		
			partFX = partFX - 1
			
		end
		
		part.xScale = partS
		part.yScale = partS
		part.rotation = partR
		
		physics.addBody(part, "dynamic", {density=0.0, bounce =1.0, friction=1.0 })
		part.isSensor = true
		part.linearDamping = 3
		part.gravityScale = 2
		
		part:applyForce(partFX, partFY, part.x, part.y)
		part:applyTorque( partT )
		
		local myclosure = function() return util.dropImage(part) end
		local randD = math.random() * 500
		transition.to(part, {delay=1300 + randD, time=100, alpha = 0, onComplete=myclosure})

	end
	
end

-------------------------- UTILITIES:

function externalLink( path )
		
	if http.request( "http://www.google.com" ) == nil then
	
		local alert = native.showAlert( "No Internet Connection", "You need to be online to access this content.", { "OK" }, { listener=dismissCallback } )
			
	else
		
		system.openURL( path )
			
	end
	
end

function openLink( path )

	if http.request( "http://www.google.com" ) == nil then

			
			local alert = native.showAlert( "No Internet Connection", "You need to be online to access this content.", { "OK" }, { listener=dismissCallback } )
			
	else
		
			system.openURL( path )
			
	end
	
end

function unpauseUI()
	
	_G.isPaused = false
	
end

function table.shuffle(t,flag)
	
    math.randomseed(os.time())
    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
    for i = iterations, 2, -1 do
            j = math.random(i)
            t[i], t[j] = t[j], t[i]
    end
		
end

function split(str, pat)
	
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
		  table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
   
end

function printTable( t, label, level )
	
	if label then print( label ) end
	level = level or 1

	if t then
		
		for k,v in pairs( t ) do
			local prefix = ""
			for i=1,level do
				prefix = prefix .. "\t"
			end

			print( prefix .. "[" .. tostring(k) .. "] = " .. tostring(v) )
			if type( v ) == "table" then
				print( prefix .. "{" )
				printTable( v, nil, level + 1 )
				print( prefix .. "}" )
			end
		end
		
	end
	
end

-------------------------- WEB CHECK

function checkWeb()
	
	print("check web...")
	local isAllowed = true

	-- check for server ping	
    local netConn = require('socket').connect('www.google.com', 80)
    if netConn == nil then
		print('no ping')
		return true
	else
		print('ping!')
		netConn:close()
	end
	
	-- check web
	local path = system.pathForFile( "question.txt", system.CachesDirectory)
    local myFile = io.open( path, "w" ) 

    http.request
	{ 
        url = "http://www.interactivemonster.com/clients/utilityNYC/hh.txt",  sink = ltn12.sink.file(myFile),
    }
	print('file contents:')
    print(tostring(myFile))
	
	local contents = ""
    local file = io.open( path, "r" )
    if file then
		
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        io.close( file )
        print(contents)
		
		if( contents == 'allow' )then
		
			print('app enabled')
			
		else
		
			print('app disabled')
			isAllowed = false
			
			local grp = display.newGroup()
			_G.util.addTextMulti(contents, grp, 'txt', 'native', 0, 0, 32, 900, 'center', 1, 1, 1)
			grp.txt.anchorX = .5
			grp.txt.anchorY = .5
			
			local myclosure = function() return _G.loader.hideLoader() end
			timer.performWithDelay(3000, myclosure, 1)
			
			return false
			
		end
		
    else
		
        print("file not found")
		
    end
	
	----------------
	return isAllowed
	
end

-------------------------- GARBAGE COLLECTION:

function dropImage(img)
	
	if(img.parent)then
		
		if(img.sheet)then
			img.sheet:dispose()
		else
			img:removeSelf()
		end
		
	end
	
end








