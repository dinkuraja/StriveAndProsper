
module(..., package.seeall)

-------------------------- VARIABLES

local grp_main
local isAnim = false
local backClosure = nil

-------------------------- FB VARIABLES

-- Facebook Commands
local fbCommand			
local LOGOUT = 1
local SHOW_FEED_DIALOG = 2
local SHARE_LINK_DIALOG = 3
local POST_MSG = 4
local POST_PHOTO = 5
local GET_USER_INFO = 6
local PUBLISH_INSTALL = 7

-- Layout Locations
local statusMessage

--------------------------- INIT

function buildModule(mode)

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 0, 1)
	
	-- build map
	buildMenu()
	isAnim = true
	timer.performWithDelay(050, showMenu)
		
end

function buildMenu(mode)
	
	-- bg
	_G.util.addImage('graphics/menus/facebook/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' ' .. 'CONNECT TO FACEBOOK' .. ' ', grp_main, 'txt', 'bangers', 0, -180, 60, 1, .86, 0)
	_G.util.addImage('graphics/menus/facebook/icon.png', grp_main, 'icon', -290, -15, 1, 1, 0, 1)
	
	-- buttons
	local btn = _G.util.addImage('graphics/menus/buttons/btn.png', grp_main, 'ok', 0, 0, 1, 1, 0, 1)
	btn.x = 0
	btn.y = 160
	btn.id = 'connect'
	btn:addEventListener('touch', onBtnTouch)
	_G.util.addText(' CONNECT ', grp_main, 'txt', 'bangers', 12, 160-5, 36, 1, .86, 0)
	
	-- close button
	local btn = _G.util.addGroup(grp_main, 'close', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/close.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' X ', btn, 'txt', 'bangers', 12, -5, 36, 237/255, 28/255, 36/255)
	btn.x = 356
	btn.y = -180
	btn.id = 'close'
	btn:addEventListener('touch', onBtnTouch)
	
	--statusMessage = createStatusMessage( "   Not connected  ", 0, 0 )
	
	local statusText = 'Log in to Facebook to earn extra rewards in the shop!'
	local txt = _G.util.addTextMulti(statusText, grp_main, 'textObject', 'native', 60, -10,  32, 460, 'left', 1, 1, 1)
	statusMessage = {}
	statusMessage.textObject = txt
	
	--grp_main:insert( statusMessage )
	
	-- init
	grp_main.endY = grp_main.y + 10
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	--print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='connect')then
		
		print('connect to fb')
		--fbLogin()
		enforceFacebookLogin()
		
	end
	
	if(e.target.id=='close')then
		
		hideMenu()
		
	end
		
end

--------------------------- FB METHODS:

function fbLogin()

	_G.facebook.login( facebookListener, { "user_friends", "email" } )
	
end

function facebookListener(e)

    print( "event.name:" .. e )  --"fbconnect"
    print( "isError: " .. tostring( e.isError ) )
    print( "didComplete: " .. tostring( e.didComplete ) )
    print( "event.type:" .. e )  
	
	--"session", "request", or "dialog"
    --"session" events cover various login/logout events
    --"request" events handle calls to various Graph API calls
    --"dialog" events are standard popup boxes that can be displayed

    if ( "session" == e ) then
		
        --options are "login", "loginFailed", "loginCancelled", or "logout"
        if ( "login" == e ) then
			
            local access_token = e.token
            --code for tasks following a successful login
			
        end

    elseif ( "request" == e ) then
		
        print("facebook request")
        if ( not e.isError ) then
			
            local response = json.decode( e.response )
            --process response data here
			
        end

    elseif ( "dialog" == e ) then
		
        print( "dialog", e.response )
        --handle dialog results here
		
    end
end

--------------------------- METHODS:

function showMenu()

	transition.to(grp_main, {time=500, y=grp_main.endY, alpha=1, transition=easing.outQuad})
	isAnim = false
	
end

function hideMenu()
	_G.TutorialData.displaying = false
	transition.to(grp_main, {time=400, y=grp_main.endY+100, alpha=0, transition=easing.inQuad})
	
	local myclosure = function() return killModule() end
	timer.performWithDelay(500, myclosure, 1)
	
	if( backClosure )then
		
		timer.performWithDelay(500, backClosure, 1)
		backClosure = nil
		
	else
	
		local myclosure = function() return _G.levelselect.buildModule() end
		timer.performWithDelay(500, myclosure, 1)
		
	end
	
	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function setBackClosure(closure)

	backClosure = closure
	
end

--------------------------- UTILITIES:

function inTable( table, item )
	
	for k,v in pairs( table ) do
		
		if v == item then
			return true
		end
		
	end
	return false
	
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

function processFBCommand( )
	
	-- The following displays a Facebook dialog box for posting to your Facebook Wall
	if fbCommand == SHOW_FEED_DIALOG then
		-- "feed" is the standard "post status message" dialog
		local response = facebook.showDialog( "feed" )
		printTable(response)
	end

	-- This displays a Facebook Dialog for posting a link with a photo to your Facebook Wall
	if fbCommand == SHARE_LINK_DIALOG then
		local response = facebook.showDialog( "link", {
			name = "Facebook v4 Corona plugin on iOS!",
			link = "https://coronalabs.com/blog/2015/09/01/facebook-v4-plugin-ios-beta-improvements-and-new-features/",
			description = "More Facebook awesomeness for Corona!",
			picture = "https://coronalabs.com/wp-content/uploads/2014/11/Corona-Icon.png",
		})
		printTable(response)
	end

	-- Request the current logged in user's info
	if fbCommand == GET_USER_INFO then
		local response = facebook.request( "me" )
		printTable(response)
		-- facebook.request( "me/friends" )		-- Alternate request
	end

	-- This code posts a photo image to your Facebook Wall
	if fbCommand == POST_PHOTO then
		local attachment = {
			name = "Developing a Facebook Connect app using the Corona SDK!",
			link = "http://www.coronalabs.com/links/forum",
			caption = "Link caption",
			description = "Corona SDK for developing iOS and Android apps with the same code base.",
			picture = "http://www.coronalabs.com/links/demo/Corona90x90.png",
			actions = json.encode( { { name = "Learn More", link = "http://coronalabs.com" } } )
		}
	
		local response = facebook.request( "me/feed", "POST", attachment )		-- posting the photo
		printTable(response)
	end
	
	-- This code posts a message to your Facebook Wall
	if fbCommand == POST_MSG then
		local time = os.date("*t")
		local postMsg = {
			message = "Posting from Corona SDK! " ..
				os.date("%A, %B %e")  .. ", " .. time.hour .. ":"
				.. time.min .. "." .. time.sec
		}
	
		local response = facebook.request( "me/feed", "POST", postMsg )		-- posting the message
		printTable(response)
	end
	
end

function listener( event )

	-- Debug Event parameters printout --------------------------------------------------
	-- Prints Events received up to 20 characters. Prints "..." and total count if longer
	print( "Facebook Listener events:" )
	
	local maxStr = 20		-- set maximum string length
	local endStr
	
	for k,v in pairs( event ) do
		local valueString = tostring(v)
		if string.len(valueString) > maxStr then
			endStr = " ... #" .. tostring(string.len(valueString)) .. ")"
		else
			endStr = ")"
		end
		print( "   " .. tostring( k ) .. "(" .. tostring( string.sub(valueString, 1, maxStr ) ) .. endStr )
	end
	-- End of debug Event routine -------------------------------------------------------

    print( "event.name", event.name ) -- "fbconnect"
    print( "event.type:", event.type ) -- type is either "session" or "request" or "dialog"
	print( "isError: " .. tostring( event.isError ) )
	print( "didComplete: " .. tostring( event.didComplete ) )
	print( "response: " .. tostring( event.response ) )
	-----------------------------------------------------------------------------------------
		-- Process the response to the FB command
		-- Note: If the app is already logged in, we will still get a "login" phase
	-----------------------------------------------------------------------------------------

	-- if no status message, make blank one
	if( not statusMessage )then
	
		statusMessage = {}
		statusMessage.textObject = display.newText( 'hey', 0, 0, native.systemFont, 20 )
		
	end

	-- if login callback
    if ( "session" == event.type ) then
		
        -- event.phase is one of: "login", "loginFailed", "loginCancelled", "logout"
		statusMessage.textObject.text = event.phase
		
		print( "Session Status: " .. event.phase )
		
		if event.phase ~= "login" then
			-- Exit if login error
			return
		else
			-- Run the desired command
			--processFBCommand()
			statusMessage.textObject.text = 'Successful login!'
			native.showAlert( 'Bonus Reward!', 'Thanks for connecting to Facebook - enjoy some extra cash!', { "OK" }, nil )
			_G.gui.setCash(500)
			
		end

	-- if request: info, friend, post, etc
    elseif ( "request" == event.type ) then
        -- event.response is a JSON object from the FB server
        local response = event.response
        
		if ( not event.isError ) then
	        response = json.decode( event.response )
	        
			print( "Facebook Command: " .. fbCommand )

	        if fbCommand == GET_USER_INFO then
				statusMessage.textObject.text = response.name
				printTable( response, "User Info", 3 )
				print( "name", response.name )
				
			elseif fbCommand == POST_PHOTO then
				printTable( response, "photo", 3 )
				statusMessage.textObject.text = "Photo Posted"
							
			elseif fbCommand == POST_MSG then
				printTable( response, "message", 3 )
				statusMessage.textObject.text = "Message Posted"
				
			else
				-- Unknown command response
				print( "Unknown command response" )
				statusMessage.textObject.text = "Unknown ?"
			end

        else
        	-- Post Failed
			statusMessage.textObject.text = "Post failed"
			printTable( event.response, "Post Failed Response", 3 )
		end
	
	-- if share dialogue: invite, etc	
	elseif ( "dialog" == event.type ) then
		
		-- showDialog response
		print( "******* dialog response:", event.response )
		statusMessage.textObject.text = event.response
		
		if( event.didComplete )then
				
			-- posted to feed
			if( string.find( event.response, 'PostID') )then
				
				print('reward cash for posting')
				
				native.showAlert( 'Bonus Reward!', "Thanks for posting to Facebook! Here's some extra cash!", { "OK" }, nil )
				_G.gui.setCash(500)

			end
			
			-- invites
			if( string.find( event.response, 'Recipient') )then
				
				print('reward cash for invites')
				
				local fbstr = event.response .. ''
				local startI = string.find(fbstr,'(', 1, true)
				local endI = string.find(fbstr,')', 1, true)
				local subS = string.sub(fbstr, startI+1, endI-1)
				local ids = _G.util.split( subS, ',' )
				
				print('invited: ' .. #ids )
				
				native.showAlert( 'Bonus Reward!', 'Thanks for inviting ' .. #ids .. " friends! Here's some extra cash!", { "OK" }, nil )
				_G.gui.setCash(500 * #ids)
				
			end
			
		end 
		
    end
end

function enforceFacebookLogin( )
	
	if facebook.isActive then
		
		local accessToken = facebook.getCurrentAccessToken()
		if accessToken == nil then

			print( "Need to log in" )
			facebook.login( listener )

		elseif not inTable( accessToken.grantedPermissions, "publish_actions" ) then

			print( "Logged in, but need permissions" )
			printTable( accessToken, "Access Token Data" )
			facebook.login( listener, {"user_friends","publish_pages"} )

		else

			print( "Already logged in with needed permissions" )
			printTable( accessToken, "Access Token Data" )
			if( statusMessage )then
				statusMessage.textObject.text = "Already logged in"
			end
			native.showAlert( 'Already Connected', 'This game is already connected to Facebook.', { "OK" }, nil )
			--processFBCommand()

		end
		
	else
		
		print( "Please wait for facebook to finish initializing before checking the current access token" );
		
	end
	
end

function createStatusMessage( message, x, y )
	
	-- Show text, using default bold font of device (Helvetica on iPhone)
	local textObject = display.newText( message, 0, 0, native.systemFontBold, 24 )
	textObject:setFillColor( 1,1,1 )

	-- A trick to get text to be centered
	local group = display.newGroup()
	group.x = x
	group.y = y
	group:insert( textObject, true )

	-- Insert rounded rect behind textObject
	local r = 10
	local roundedRect = display.newRoundedRect( 0, 0, textObject.contentWidth + 2*r, textObject.contentHeight + 2*r, r )
	roundedRect:setFillColor( 55/255, 55/255, 55/255, 190/255 )
	group:insert( 1, roundedRect, true )

	group.textObject = textObject
	return group
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

