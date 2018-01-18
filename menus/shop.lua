
module(..., package.seeall)

-------------------------- VARIABLES

local widget 	= require( "widget" )
local vipData 	= require("info.vipData")

local TWITTER_KEY = 'GIQzfZ6MjSRQfpuLDrrF1d21h'
local TWITTER_SECRET = 'RfKMzWkvK35xGBo98DxkeJnRvc9K8MuzYmnJUy6TryyKlTtLyO'

local grp_main = nil
local isAnim = false
local backClosure = nil
local curMode = nil
local curVipItem = nil

--------------------------- INIT

function buildModule(mode)

	if(grp_main)then
	
		print('shop already open')
		return
		
	end

	-- build main
	grp_main = util.addGroup(_G.layer_menus, 'grp_main', 0, 0, 1)
	
	-- bg
	_G.util.addImage('graphics/menus/shop/bg.png', grp_main, 'bg', 0, 0, 1, 1, 0, 1)
	
	-- nav
	local ids = {'cash','gems','free offers','vip characters'}
	local nav = {}
	for i=1, 4 do
	
		local t = _G.util.addText(' ' .. ids[i] .. ' ', grp_main, 't_'..ids[i], 'bangers', 0, -222, 50, 1, .86, 0)
		t.anchorX = 0
		t.x = -445
		
		nav[i] = t
		
		if(i>1)then
		
			t.x = nav[i-1].x + nav[i-1].width + 23
			_G.util.addFill(grp_main, 'f', 1, .86, 0, 1, t.x - 10, t.y+2, 2, 50)
			
		end
		
		local hit = _G.util.addFill(grp_main, 'hit'..i, 1, 0, 0, .5, t.x+(t.width*.5), t.y, t.width, t.height)
		hit.alpha = .01
		hit.id = ids[i]
		hit:addEventListener('touch', onNavTouch)
	
		-- set current
		if( ids[i] ~= mode )then
		
			t:setFillColor(_G.util.convertHexToRGB('#75726b'))
			curMode = mode
			
		end
		
	end
	
	-- build buttons
	buildMenu('cash')
	buildMenu('gems')
	buildFree()
	buildVIP()
	
	-- close button
	local btn = _G.util.addGroup(grp_main, 'close', 0, 0, 1)
	_G.util.addImage('graphics/menus/buttons/close.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
	_G.util.addText(' X ', btn, 'txt', 'bangers', 12, -5, 36, 237/255, 28/255, 36/255)
	btn.x = 420
	btn.y = -230
	btn:addEventListener('touch', onBtnTouch)
	
	-- init
	grp_main.endY = grp_main.y + 20
	grp_main.y = grp_main.y + 100
	grp_main.alpha = 0
	
	-- show menu
	isAnim = true
	timer.performWithDelay(050, showMenu)
	
	-- set module
	_G.curModule = _G.results
	
end

function buildMenu(mode)
		
	-- build buttons
	local col = 0
	local row = 0
	
	local btns = _G.util.addGroup(grp_main, mode, 0, 0, 1)
	local cashValues = {5,25,80,150,350,1000,1000,10000} -- /100
	local cashCosts = {'FREE','.99','2.99','4.99','9.99','19.99','49.99','99.99'}
	local gemValues = {5,10,35,60,125,300,750,5000}
	local gemCosts = {'FREE','.99','2.99','4.99','9.99','19.99','49.99','99.99'}
		
	local values = {}
	local costs = {}
	
	-- set values
	if( mode == 'cash' )then
			
		values = cashValues
		costs = cashCosts
			
	end
	if( mode == 'gems' )then
			
		values = gemValues
		costs = gemCosts
			
	end
	
	-- build list
	for i=1, 8 do
		
		-- bg
		local btn = _G.util.addGroup(btns, 'btn'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/shop/button.png', btn, 'bg', 0, 0, 1, 1, 0, 1)
		btn.bg.anchorX = 0
		btn.bg.anchorY = 0
		
		-- value
		_G.util.addText(mode:upper(), btn, 'title', 'bold', 94, 16, 12, 1, 1, 1)
		
		if( mode == 'cash' )then
			_G.util.addText(' $'.._G.util.formatEndScoring(values[i]*100)..' ', btn, 'value', 'bangers', 94, 40, 42, 1, .86, 0)
			_G.util.addImage('graphics/menus/shop/cash0'..i..'.png', btn, 'img', 94, 110, 1, 1, 0, 1)
			
			btn.cashReward = values[i]*100
			
		end
		if( mode == 'gems' )then
			_G.util.addText(' '.._G.util.formatEndScoring(values[i])..' ', btn, 'value', 'bangers', 94, 40, 42, 1, .86, 0)
			_G.util.addImage('graphics/menus/shop/gems0'..i..'.png', btn, 'img', 94, 110, 1, 1, 0, 1)
			
			btn.gemReward = values[i]
			
		end
		
		-- special case
		if( i==7 )then
			
			btn.title.text = ' CASH '
			btn.title.anchorX = 0
			btn.title.x = 16
			btn.value:removeSelf()
			
			_G.util.addText(' $100,000 ', btn, 'value', 'bangers', 10, 38, 30, 1, .86, 0)
			btn.value.anchorX = 0
			
			btn.cashReward = 100000
			btn.gemReward = 750
			
			-- gems extra
			_G.util.addText(' GEMS ', btn, 'g', 'bold', 136, 58, 12, 1, 1, 1)
			_G.util.addText(' 750 ', btn, 'value', 'bangers', 162, 78, 30, 1, .86, 0)
			btn.value.anchorX = 1
			
		end
		
		-- cta
		_G.util.addImage('graphics/menus/shop/cta.png', btn, 'cta', 94, 164, 1, 1, 0, 1)
		
		local priceStr = '$' .. costs[i]
		if( costs[i] == 'FREE' )then priceStr = 'FREE' end
		_G.util.addText(priceStr, btn, 'price_txt', 'bangers', 94, 162, 24, 0, 0, 0)
		
		-- position
		btn.x = col * 222
		btn.y = row * 208
		
		-- enable
		btn.num = i-1
		if( mode=='gems' )then
			btn.num = btn.num + 7
		end
		btn:addEventListener('touch', onShopTouch)
		
		-- increment
		col = col + 1
		if( col == 4 )then 
			col = 0
			row = row + 1
		end
		
	end
	btns.x = btns.width * -.5
	btns.y = btns.height * -.5
	btns.y = btns.y + 46
	btns.alpha = 0
	
	-- set default
	if( mode == curMode )then
		btns.alpha = 1
	end
		
end

function buildFree()

	-- build buttons
	local col = 0
	local row = 0
	
	-- btns
	local btns = _G.util.addGroup(grp_main, 'free offers', 0, 0, 1)
	btns.alpha = 0
	if( curMode == 'free offers' )then
		btns.alpha = 1
	end
	
	-- video button
	_G.util.addImage('graphics/menus/freeoffers/video.png', btns, 'video', -240, 54, 1, 1, 0, 1)
	_G.util.addText('watch an advertisement', btns, 't', 'bangers', -234, -150, 18,  1, .86, 0)
	_G.util.addText(' CASH AND GEMS! ', btns, 'type', 'bold', -234, -125, 12,  1, 1, 1)
	_G.util.addText(' $10,000 + 5 GEMS! ', btns, 'title', 'bangers', -234, -98, 42,  1, .86, 0)
	btns.video.id = 'ad'
	btns.video:addEventListener('touch', onFreeTouch)
	
	-- other buttons
	local names = {'connect on facebook','post on facebook','invite a facebook friend','follow us on twitter'}
	local ids = {'connect','post','invite','twitter'}
	for i=1, #names do
	
		local b = _G.util.addGroup(btns, 'b'..i, 0, 0, 1)
		_G.util.addImage('graphics/menus/freeoffers/btn.png', b, 'bg', 0, 0, 1, 1, 0, 1)
		
		-- title
		_G.util.addText(names[i], b, 'title', 'bangers', 0, -100, 18,  1, .86, 0)
		
		-- money
		_G.util.addText(' CASH ', b, 'type', 'bold', 0, -76, 12,  1, 1, 1)
		_G.util.addText('$500', b, 'title', 'bangers', 0, -50, 42,  1, .86, 0)
		_G.util.addImage('graphics/menus/freeoffers/icon02.png', b, 'icon', 0, 10, 1, 1, 0, 1)
		
		-- cta
		_G.util.addImage('graphics/menus/freeoffers/cta.png', b, 'icon', 1, 64, 1, 1, 0, 1)
		_G.util.addText(' Collect ', b, 'ctatxt', 'bangers', 1, 62, 23,  0, 0, 0)
		
		-- position
		b.x = 100 + (col*220)
		b.y = -50 + (row*208)
		
		-- increment
		col = col+1
		if(col==2)then
			row = row +1
			col = 0
		end
		
		-- activate
		b.id = ids[i]
		b:addEventListener('touch', onFreeTouch)
		
	end
	
	
end

function buildVIP()

	local main = _G.util.addGroup(grp_main, 'vip characters', 0, 0, 1)
	main.alpha = 0
	if( curMode == 'vip characters' )then
		main.alpha = 1
	end

	-- build list
	local list = _G.util.addGroup(main, 'list', 0, 0, 1)
	local order = vipData.getVipData()

	for i=1, #order do
	
		local info = order[i]
		local item = _G.util.addGroup(list, 'item'..i, 0, 0, 1)
		list['item'..i] = item
		
		-- base
		_G.util.addImage('graphics/menus/vip/item_shad.png', item, 'shad', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/vip/item_on.png', item, 'bg', 0, 0, 1, 1, 0, 1)
		_G.util.addImage('graphics/menus/vip/item_bg.png', item, 'on', 0, 0, 1, 1, 0, 0)
		_G.util.addImage('graphics/menus/vip/item_off.png', item, 'off', 0, 0, 1, 1, 0, 0)
		item.shad.anchorX = 0
		item.shad.anchorY = 0
		item.bg.anchorX = 0
		item.bg.anchorY = 0
		item.on.anchorX = 0
		item.on.anchorY = 0
		item.off.anchorX = 0
		item.off.anchorY = 0
		
		-- set first item
		if(i==1)then
		
			item.on.alpha = 1
			curVipItem = item
			
		end
		
		-- name
		_G.util.addText(' ' .. info.name .. ' ', item, 'name', 'bangers', 40, 21, 26, 1, .86, 0)
		item.name.anchorX = 0
		
		-- info
		_G.util.addTextMulti(info.title, item, 'info', 'native', 44, 37, 18, 200, 'left', 1, 1, 1)
		item.info.anchorX = 0
		item.info.anchorY = 0
		
		-- check locked
		if( info.locked )then
		
			item.bg.alpha = 0
			item.off.alpha = 1
			item.name:setFillColor(1,1,1)
			item.name.alpha = .5
			
		end
		
		-- position
		item.x = 10
		item.y = (i-1) * 100
		item.y = item.y + 30
		
		-- enable
		item.info = info
		item:addEventListener('tap', onVIPTap )
				
	end
	
	-- add shim
	local shimY = list['item' .. #order].y + 130
	_G.util.addImage('graphics/menus/levelselect/shim.png', list, 'shim', 200, shimY, 1, 1, 0, .01)
	
	-- scrollview
	local sv = widget.newScrollView(
	    {
	        top = -166,
	        left = -455,
	        width = 360,
	        height = 420,
	        scrollWidth = 500,
	        scrollHeight = 334,
			backgroundColor = { 0.5, 0.5, 0.5, .5 },
			horizontalScrollDisabled=true,
			hideBackground = true,
			listener = scrollListener
	    }
	)
	
	sv:insert(list)
	main:insert(sv)
	
	-- shadows
	local shad
	shad = _G.util.addImage('graphics/menus/achievements/shadow.png', main, 'shadow', 0, -151, 1, -1, 0, 1)
	shad.anchorX = 0
	shad.width = 380
	shad.x = -450
	
	shad = _G.util.addImage('graphics/menus/achievements/shadow.png', main, 'shadow', 8, 238, 1, 1, 0, 1)
	shad.anchorX = 0
	shad.width = 380
	shad.x = -450
	
	-- info panel
	local info = _G.util.addGroup(main, 'info', 165, 44, 1)
	_G.util.addImage('graphics/menus/vip/window.png', info, 'bg', 0, 0, 1, 1, 0, 1)
	
	local data = order[1]
	
	_G.util.addImage('graphics/menus/vip/' .. data.img .. '.png', info, 'celeb', -110, -26, 1, 1, 0, 1)

	for i=1, 3 do
	
		local txt = _G.util.addText(data.stats[i][1], info, 'statTitle'..i, 'bangers', 60, 0, 18,  1, .86, 0)
		txt.anchorX = 0
		txt.y = (i-1)*54
		txt.y = txt.y - 130
		
		-- info
		local txt = _G.util.addTextMulti(data.stats[i][2], info, 'statInfo'..i, 'native', 60, 37, 18, 200, 'left', 1, 1, 1)
		txt.anchorX = 0
		txt.anchorY = 0
		txt.y = (i-1)*54
		txt.y = txt.y - 119
		
	end
	
	-- button
	_G.util.addImage('graphics/menus/vip/button.png', info, 'button', 156, 76-8, 1, 1, 0, 1)
	_G.util.addText(' $' .. data.price .. ' ', info, 'price_b', 'bangers', 156+2, 70+2-8, 32,  0, 0, 0)
	_G.util.addText(' $' .. data.price .. ' ', info, 'price_w', 'bangers', 156, 70-8, 32,  1, 1, 1)
	
	-- quote
	_G.util.addTextMulti( '"' .. data.quote .. '"', info, 'quote', 'native', 0, 140, 18, 480, 'center', 1, 1, 1)
	info.quote.anchorX = .5
	info.quote.anchorY = 0
	
end

--------------------------- INPUT:

function onBtnTouch(e)
	
	print('touch')
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
		
	if(e.target.id=='back')then
		
		hideMenu()
		
	end
	
	if(e.target.id=='close')then
		
		hideMenu()
		
	end
	
end

function onShopTouch(e)
	
	if(e.phase~='began')then return end
	if(isAnim)then return end
	
	if( e.target.price_txt.text == 'FREE' )then
	
		print('it was free!')
		
		-- shift display
		grp_main[curMode].alpha = 0
		grp_main['free offers'].alpha = 1
	
		-- shift text
		grp_main['t_'..curMode]:setFillColor(_G.util.convertHexToRGB('#75726b'))
		grp_main['t_'..'free offers']:setFillColor(_G.util.convertHexToRGB('#ffda00'))
	
		-- save mode
		curMode = 'free offers'
		
		return
		
	end
	
	-- launch IAP
	_G.iap.executePurchase( _G.iapIDs[ e.target.num ] )
		
	-- give reward
	if( e.target.cashReward )then
	
		--_G.gui.setCash( e.target.cashReward )
		--_G.mixer.playNavSFX('buy_cash')
		
	end
	if( e.target.gemReward )then
	
		--_G.gui.setGems( e.target.gemReward )
		--_G.mixer.playNavSFX('buy_gems')
		
	end
	
end

function onNavTouch(e)

	if(e.phase~='began')then return end
	if(isAnim)then return end
	if(e.target.id == curMode)then return end
	
	-- shift display
	grp_main[curMode].alpha = 0
	grp_main[e.target.id].alpha = 1
	
	-- shift text
	grp_main['t_'..curMode]:setFillColor(_G.util.convertHexToRGB('#75726b'))
	grp_main['t_'..e.target.id]:setFillColor(_G.util.convertHexToRGB('#ffda00'))
	
	-- save mode
	curMode = e.target.id
	
end

function onFreeTouch(e)

	if(e.phase~='began')then return end
	if(isAnim)then return end

	if( e.target.id == 'connect' )then
	
		_G.fbconnect.enforceFacebookLogin()
		
	end

	if( e.target.id == 'invite' )then
		
		--_G.facebook.login( onInviteListener )
			
		local options = 
		{
            message = "You should download this game!",
            filter = "APP_NON_USERS"
        }
        _G.facebook.showDialog( "requests", options )
		
	end
	
	if( e.target.id == 'post' )then
		
		local options = 
		{
	        link = "http://www.interactivemonster.com/",
	        title = "Strive and Prosper"
        }
        _G.facebook.showDialog( "link", options )
		
	end
	
	if( e.target.id == 'ad' )then
		
		_G.ads.show( "incentivized", { isAnimated=false, isBackButtonEnabled=true } )
		
	end
	
	if( e.target.id == 'twitter' )then
	
		twitter.init(TWITTER_KEY, TWITTER_SECRET)
		twitter.login(onTwitterSuccess, onTwitterFail)
		
	end 
	
end

function onInviteListener( event )

    if ( "session" == event.type ) then
		
        if ( "login" == event.phase ) then

            facebook.showDialog( "requests", 
            { 
                message = "You should download this game!",
                filter = "APP_NON_USERS"
            })
			
        end

    elseif ( "dialog" == event.type ) then
		
		print( 'on dialogue end!')
        print( event.response )
		
		if( event.didComplete )then
							
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

function onAdEvent(event)
	
	print( '********* VUNGLE: ' )
	print( event.type )
	
	if ( event.type == "adStart" and e.isError ) then
	    print('Ad has not finished caching and will not play')
	end
	if ( event.type == "adStart" and not e.isError ) then
		print('Ad will play')
	end
	if ( event.type == "cachedAdAvailable" ) then
		print('Ad has finished caching and is ready to play')
	end
	if ( event.type == "adView" ) then
		
		print('An ad has completed')
		
		native.showAlert( 'Bonus Reward!', "Thanks for watching an add from our sponsors!", { "OK" }, nil )
		_G.gui.setCash(10000)
		_G.gui.setGems(5)
		
	end
	if ( event.type == "adEnd" ) then
		print('The ad experience has been closed')
	end
	
end

function onTwitterSuccess(e)
	
	twitter.follow("@nyuloser", onTwitterFollow)
	
end

function onTwitterFollow(e)

	print('onTwitterFollow >>>>>>>>> ')
	
	native.showAlert( 'Bonus Reward!', "Thanks for following us on Twitter!", { "OK" }, nil )
	_G.gui.setCash(500)
	
end

function onTwitterFail(e)
	
	print('twitter login failed')
	
end

function onVIPTap(e)
	
	if(isAnim)then return end
	if( e.target.off.alpha == 1)then return end
	
	setVIPInfo( e.target )
	
end

function setVIPInfo(item)
	
	-- reset list
	if( curVipItem )then curVipItem.on.alpha=0 end
	item.on.alpha = 1
	curVipItem = item

	-- set stats
	local data = item.info
	local txt
	for i=1, 3 do
	
		txt = grp_main['vip characters'].info['statTitle'..i]
		txt.text = data.stats[i][1]
		
		txt = grp_main['vip characters'].info['statInfo'..i]
		txt.text = data.stats[i][2]
		
	end
	
	-- swap image
	grp_main['vip characters'].info.celeb:removeSelf()
	_G.util.addImage('graphics/menus/vip/' .. data.img .. '.png', grp_main['vip characters'].info, 'celeb', -110, -26, 1, 1, 0, 1)
	
	-- set price
	grp_main['vip characters'].info.price_b.text = ' $' .. data.price .. ' '
	grp_main['vip characters'].info.price_w.text = ' $' .. data.price .. ' '
	
	-- set quote
	grp_main['vip characters'].info.quote.text = '"' .. data.quote .. '"'
	
	
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
	
		timer.performWithDelay(500, _G.gui.onShopClose(), 1)
		
	end
	

	isAnim = true
	
	_G.mixer.playNavSFX('close')
	
end

function setBackClosure(myclosure)
	
	backClosure = myclosure
	
end

--------------------------- MODULE EVENTS:

function stopModule()

	
	
end

function killModule()

	grp_main:removeSelf()
	grp_main = nil
	
end

