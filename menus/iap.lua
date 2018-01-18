module(..., package.seeall)

------------------ SET GLOBALS

local grp_main
local overlay

local timer_restoreWait
local timer_purchase
local curID

local timeoutDelay = 20000

-------------------------- INIT

function init()

	startIAP()
	
end

-------------------------- GET/SET

function getIapID(num)
	
	return iapIDs[num]
	
end

-------------------------- TOUCH EVENTS

function executePurchase(id)
	
	print('id: ' .. id )
	curID = id
	
	isActive = false
	local myclosure = function() return purchaseIAP( curID ) end
	timer.performWithDelay(000, myclosure, 1)
	
end

function toggleActive()

	isActive = true
	
end

function executeRestore()

	isActive = false
	local myclosure = function() return callRestoreIAP() end
	timer.performWithDelay(0000, myclosure, 1)
	
end

function callRestoreIAP()
	
	-- add overlay
	overlay = display.newGroup()
	
	local black = display.newImage('graphics/menus/iap/black.png', true)
	black.x = 512
	black.y = 384
	overlay:insert(black)
	overlay.black = black
	
	--- loader sprite
	local s_sheet_data = { width=128, height=128, numFrames=12 }
	local s_sheet = graphics.newImageSheet( 'graphics/menus/iap/loader.png', s_sheet_data )
	local sequenceData =
	{
	    { name="spin", start=1, count=12, time=600, loopCount=0 }
	}
	
	local s_sprite = display.newSprite( s_sheet, sequenceData )
	s_sprite.x = 512
	s_sprite.y = 384
	s_sprite.alpha = .8
	s_sprite:play()
	overlay:insert(s_sprite)
	
	-- cancel after time
	timer_restoreWait = timer.performWithDelay( timeoutDelay, onRestoreFail, 1)
	
	-- call restore
	store.restore()
	
end

-------------------------- IN APP PURCHASING

function startIAP()
	
	_G.store.init( iap.IAPListener )
	
	-- get info
	if( (_G.launchType == 'Apple') or (_G.launchType == 'Google') or (_G.launchType == 'Amazon') )then
		
		local arrayOfProductIdentifiers = iapIDs
		_G.store.loadProducts( arrayOfProductIdentifiers, loadProductsCallback )
		
	end
	
end

function loadProductsCallback( e )
	
		------- check product data
		
		print('iap callback... ')
		--print( e.products )
	
        for i=1, #e.products do

			local currentItem = e.products[i]
			print('*** from store front: ***')
			print(currentItem.title)
			print(currentItem.price)
			print(currentItem.productIdentifier)
			print(currentItem.description)
			print('*****************')
		
        end
		
		------- check for bad calls

        for i=1, #e.invalidProducts do
				
			print('invalid product')
			print( e.invalidProducts[i] )	
				
        end
		
		-------

end

function IAPListener( e )

	print('iap callback')
	print('transaction state: ' .. e.transaction.state )
	
	-- stop timers
	if(timer_restoreWait)then
		timer.cancel(timer_restoreWait)
	end
	if(timer_purchase)then
		timer.cancel(timer_purchase)
	end
	
	-- check event
	if( e.transaction.state == "purchased" ) or (e.transaction.state == "restored" )then
		
		unlockTheme(  e.transaction.productIdentifier )
		
	elseif(e.transaction.state == "cancelled")then
		
		local alert = native.showAlert( "Error", "Sorry, your purchase has been cancelled. Please try again later.", { "Ok" }, nil)
		timer.performWithDelay(300, toggleActive)
		timer.performWithDelay(300, killOverlay)
		--timer.performWithDelay(300, buycoins.purchaseFail )

	elseif(e.transaction.state == "failed")then
		
		local alert = native.showAlert( "Error", "Sorry, your purchase seems to have failed. Please try again later.", { "Ok" }, nil )
		timer.performWithDelay(300, toggleActive)
		timer.performWithDelay(300, killOverlay)
		--timer.performWithDelay(300, buycoins.purchaseFail )
		
	else
		
		local alert = native.showAlert( "Error", "An unknown error has occured. Please try again later.", { "Ok" }, nil )
		timer.performWithDelay(300, toggleActive)
		timer.performWithDelay(300, killOverlay)
		--timer.performWithDelay(300, buycoins.purchaseFail )

	end
	
	_G.store.finishTransaction( e.transaction )
	
end

function purchaseIAP( id )
	
	print('purchaseIAP: ' .. id )
	
	-- add overlay
	overlay = display.newGroup()
	
	local black = display.newImage('graphics/menus/iap/black.png', true)
	black.x = 512
	black.y = 384
	overlay:insert(black)
	overlay.black = black
	
	--- loader sprite
	local s_sheet_data = { width=128, height=128, numFrames=12 }
	local s_sheet = graphics.newImageSheet( 'graphics/menus/iap/loader.png', s_sheet_data )
	local sequenceData =
	{
	    { name="spin", start=1, count=12, time=600, loopCount=0 }
	}
	
	local s_sprite = display.newSprite( s_sheet, sequenceData )
	s_sprite.x = 512
	s_sprite.y = 384
	s_sprite.alpha = .8
	s_sprite:play()
	overlay:insert(s_sprite)
	
	-- cancel after time
	timer_purchase = timer.performWithDelay( timeoutDelay, onPurchaseFail, 1)
	
	-- purchase
	if(_G.launchType == 'Apple' )then
		
		_G.store.purchase( { id } )
		
	end
	if(_G.launchType == 'Google' )then
		
		_G.store.purchase( id )
		
	end 
		
end

function unlockTheme( id )
	
	print('unlock themes: ' .. id)
	
	----------------------------------
	
	if( id == _G.iapIDs[1] )then
		_G.gui.setCash(2500)
	end
	
	if( id == _G.iapIDs[2] )then
		_G.gui.setCash(8000)
	end
	
	if( id == _G.iapIDs[3] )then
		_G.gui.setCash(15000)
	end
	
	if( id == _G.iapIDs[4] )then
		_G.gui.setCash(35000)
	end
	
	if( id == _G.iapIDs[5] )then
		_G.gui.setCash(100000)
	end
	
	if( id == _G.iapIDs[6] )then
		_G.gui.setCash(100000)
		_G.gui.setGems(150)
	end
	
	if( id == _G.iapIDs[7] )then
		_G.gui.setCash(1000000)
	end
	
	----------------------------------
	
	if( id == _G.iapIDs[8] )then
		_G.gui.setGems(10)
	end
	
	if( id == _G.iapIDs[9] )then
		_G.gui.setGems(35)
	end
	
	if( id == _G.iapIDs[10] )then
		_G.gui.setGems(60)
	end
	
	if( id == _G.iapIDs[11] )then
		_G.gui.setGems(125)
	end
	
	if( id == _G.iapIDs[12] )then
		_G.gui.setGems(300)
	end
	
	if( id == _G.iapIDs[13] )then
		_G.gui.setCash(100000)
		_G.gui.setGems(150)
	end
	
	if( id == _G.iapIDs[14] )then
		_G.gui.setGems(5000)
	end
	
	----------------------------------
	
	if( string.find( id, 'Coins') )then
		
		_G.mixer.playNavSFX('buy_cash')
		
	end
	
	if( string.find( id, 'Gems') )then
		
		_G.mixer.playNavSFX('buy_gems')
		
	end	
	
	----------------------------------
	
	timer.performWithDelay(300, toggleActive)
	timer.performWithDelay(300, killOverlay)
	timer.performWithDelay(300, hideIAP)
	
end

function onRestoreFail()

	local alert = native.showAlert( "Failed to Restore", "Sorry, we're having trouble locating your purchases. Please try again later.", { "Ok" }, nil )

	timer.performWithDelay(300, toggleActive)
	timer.performWithDelay(300, killOverlay)
	--timer.performWithDelay(300, buycoins.restoreFail )
	
end

function onPurchaseFail()

	local alert = native.showAlert( "Error", "Sorry, your purchase seems to have failed. Please try again later.", { "Ok" }, nil )

	timer.performWithDelay(300, toggleActive)
	timer.performWithDelay(300, killOverlay)
	--timer.performWithDelay(300, buycoins.purchaseFail )
	
end

function killOverlay()

	if( overlay )then
	
		overlay:removeSelf()
		overlay = nil
		
	end

end

------------------

