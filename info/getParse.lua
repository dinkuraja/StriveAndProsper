
module(..., package.seeall)

-------------------------- IMPORTS & SETTINGS

local parse = require("info.parse")
local json = require "json"

-------------------------- VARIABLES

local parseKeys = {}
parseKeys['APPID'] = 'WMGVpLsEK07Hg9ZQTXY4TKbbcV2ZhnSobHS4KooJ'
parseKeys['RestKey'] = 'LQ4cKwu3zRgh70gtpMtV7uYhSPqSDu8nTJiISdZi'

local username = 'kevin'
local password = 'asap'

------------

local illoSplit = false
local illoID = nil
local curWord = nil
local curPointData = nil
local wasSplit = false

local clickX1 = {}
local clickY1 = {}
local clickColor1 = {}
local clickSize1 = {}
local clickDrag1 = {}

local clickX2 = {}
local clickY2 = {}
local clickColor2 = {}
local clickSize2 = {}
local clickDrag2 = {}

-------------------------- EVENTS

function init()

	parse:init( { appId = parseKeys['APPID'], apiKey = parseKeys['RestKey'] } )
	--parse.showAlert = true
	--parse.showStatus = true
	
end

---------- 

function loginUser( user, pass )
	
	--_G.username = string.lower( user )
	--_G.password = string.lower( pass )
	print( 'log in user: ' .. user .. ', ' .. pass )
	parse:loginUser( { ["username"] = user, ["password"] = pass }, onLoginUser )
	
end

function onLoginUser( event )
  
	if not event.error then

		print( 'user login success' )
		print( event.response.objectId )
		--_G.userID = event.response.objectId
		--getUserDetails()
		--_G.loginMode = 'premium'
				
	else
	  	
		print('login error')
		print( event.error )
		--login.showError( event.error )
		--_G.login.displayLoginError(event.error)
		
	end
	  
end

----------

function sendDrawingData( pointData, word )
	
	print('submitting drawing data:' .. word )
	
	curWord = word
	
	if( #pointData.clickX > 1800 )then
		
		illoSplit = true
		
		clickX1 = {}
		clickY1 = {}
		clickColor1 = {}
		clickSize1 = {}
		clickDrag1 = {}
		
		clickX2 = {}
		clickY2 = {}
		clickColor2 = {}
		clickSize2 = {}
		clickDrag2 = {}
		
		for i=1, 1800 do
		
			clickX1[i] = pointData.clickX[i]
			clickY1[i] = pointData.clickY[i]
			clickColor1[i] = pointData.clickColor[i]
			clickSize1[i] = pointData.clickSize[i]
			clickDrag1[i] = pointData.clickDrag[i]
			
		end
		
		for i=1801, #pointData.clickX do
		
			clickX2[#clickX2+1] = pointData.clickX[i]
			clickY2[#clickY2+1] = pointData.clickY[i]
			clickColor2[#clickColor2+1] = pointData.clickColor[i]
			clickSize2[#clickSize2+1] = pointData.clickSize[i]
			clickDrag2[#clickDrag2+1] = pointData.clickDrag[i]
			
		end
		
		parse:createObject( 'DrawingsSplit', { ['clickX']= clickX2, 
											   ['clickY']= clickY2,
											   ['clickColor']= clickColor2,
											   ['clickSize']= clickSize2,
											   ['clickDrag']= clickDrag2,
											   ['Name']=word, ['Device']=_G.deviceName, ['Approved']=false }, onDrawingSubmit )
		
	else
		
		parse:createObject( 'Drawings', { ['clickX']= pointData.clickX, 
										  ['clickY']= pointData.clickY,
										  ['clickColor']= pointData.clickColor,
										  ['clickSize']= pointData.clickSize,
										  ['clickDrag']= pointData.clickDrag,
										  ['Name']=word, ['Device']=_G.deviceName, ['Approved']=false }, onDrawingSubmit )
		
	end
	
end

function onDrawingSubmit( event )

	if not event.error then
		
		print( 'drawing data submitted:' .. event.response.objectId )
		if( illoSplit )then
			
			illoSplit = false
			parse:createObject( 'Drawings',		 { ['clickX']= clickX1, 
												   ['clickY']= clickY1,
												   ['clickColor']= clickColor1,
												   ['clickSize']= clickSize1,
												   ['clickDrag']= clickDrag1,
												   ['split'] = event.response.objectId,
												   ['Name']=curWord, ['Device']=_G.deviceName, ['Approved']=false }, onDrawingSubmit )
			
		else
			
			_G.drawing.updateSaveModal('yes', '')
			
			-- save to drawing list
			parse:createObject( 'DrawingTitles', { ['DrawingID'] = event.response.objectId,
												   ['Name']=curWord, ['Device']=_G.deviceName, ['Approved']=false }, onDrawingTitleSubmit )
			
		end

	else
	
		--print( event.error )
		_G.drawing.updateSaveModal('no', event.error )
		
	end
	
end






