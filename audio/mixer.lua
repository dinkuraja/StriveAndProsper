
module(..., package.seeall)

-------------------------- IMPORTS & SETTINGS


-------------------------- VARIABLES

local audioFiles = {}
local audioSFX = {}
local navSFX = {}

local musicChannel = 1
local sodaChannel = 2
local fryerChannel = 3
local burgerChannel = 4
local chickenChannel = 5
local readyChannel = 6
local cookerChannel = 7

audio.reserveChannels( 8 )

local musicVolume = .75
local sfxVolume = 1

local ext = {}
ext['Apple'] = '.m4a'
ext['Android'] = '.ogg'
ext['Debug'] = '.m4a'

local folder = {}
folder['Apple'] = 'ios'
folder['Android'] = 'android'
folder['Debug'] = 'ios'

-------------------------- MUSIC CONTROLS

function loadMusic(title)
	
	--local path = 'audio/' .. folder[ _G.launchType ]  .. '/music/' .. title .. ext[ _G.launchType ]

	local path = 'audio/ios/music/' .. title .. '.wav'

	audioFiles['music'] = audio.loadStream( path )
	
end

function unloadMusic( )
	
	if( audioFiles['music'] )then
	
		audio.stop( musicChannel )
		audio.dispose( audioFiles['music'] )
		audioFiles['music'] = nil
		
	end
	
end

function setVolume(mode, value)

	--print('SET VOLUME: ' .. mode .. ', ' .. value )

	if(mode=='music')then
		
		musicVolume = value
		audio.setVolume( musicVolume, { channel=musicChannel } )
		
	end
	
	if(mode=='sound')then
		
		print('set sfx volume: ' .. value)
		sfxVolume = value
		audio.setVolume( sfxVolume, { channel=sodaChannel } )
		audio.setVolume( sfxVolume, { channel=fryerChannel } )
		audio.setVolume( sfxVolume, { channel=burgerChannel } )
		audio.setVolume( sfxVolume, { channel=chickenChannel } )
		audio.setVolume( sfxVolume, { channel=readyChannel } )
				
	end
	
end

function getVolume(mode)

	local volume

	if(mode=='music')then
		
		volume = musicVolume
		
	end
	
	if(mode=='sound')then
		
		volume = sfxVolume
				
	end
	
	return volume
	
end

------------------------- MUSIC EVENTS

function playMusic()
	
	print('play music')
	audio.rewind( audioFiles['music'] )
	audio.play( audioFiles['music'], { channel=musicChannel, loops=999}  )
	audio.setVolume( musicVolume, { channel=musicChannel } )
	
end

function fadeMusic()
	
	print('fade music')
	audio.fade( { channel=musicChannel, time=400, volume=0.0 } )
	
	local myclosure = function() return stopMusic() end
	timer.performWithDelay(500, myclosure, 1)
	
end

function stopMusic()
	
	print('stop music')
	audio.stop( musicChannel )
	unloadMusic()
	
end

function toggleMusicVolume()
	
	audio.setVolume( _G.settings.options.musicVolume, {channel=musicChannel })
	
end

------------------------- SFX

function loadNavSFX()
	
	navSFX = {}
	navSFX['select_location'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/gui/location_level_select' .. ext[ _G.launchType ] )
	navSFX['close'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/gui/close_popup' .. ext[ _G.launchType ] )
	navSFX['play'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/gui/play' .. ext[ _G.launchType ] )
	navSFX['select'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/select' .. ext[ _G.launchType ] )
	navSFX['purchase'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/purchase_upgrade' .. ext[ _G.launchType ] )
	navSFX['level_up'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/level_up' .. ext[ _G.launchType ] )
	navSFX['wrong'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/wrong' .. ext[ _G.launchType ] )
	navSFX['buy_cash'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/buy_cash' .. ext[ _G.launchType ] )
	navSFX['buy_gems'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/gui/buy_gems' .. ext[ _G.launchType ] )
	
		
end

function loadSFX(class)
	
	local path
	audioSFX = {}
	
	if( class=='ceelo' )then
	
		audioSFX['roll'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/dice/throw_dice_full' .. ext[ _G.launchType ] )
		audioSFX['select'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/dice/select_bet' .. ext[ _G.launchType ] )
		audioSFX['win'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/dice/win_bet' .. ext[ _G.launchType ] )
		audioSFX['lose'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/dice/lose_bet' .. ext[ _G.launchType ] )
		
	end
	
	if( class=='map' )then
	
		audioSFX['gui_slide'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/gui_slides_in_map' .. ext[ _G.launchType ] )
		audioSFX['location_slide'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/locations_slide_in_map' .. ext[ _G.launchType ] )
		
	end
	
	if( class=='level1' )then
	
		-- misc
		audioSFX['burnt'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/burned_food' .. ext[ _G.launchType ] )
		
		-- serve
		audioSFX['mango'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_beans' .. ext[ _G.launchType ] )
		audioSFX['fries'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_chips' .. ext[ _G.launchType ] )
		audioSFX['lettuce'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_lettuce' .. ext[ _G.launchType ] )
		audioSFX['tomato'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_tomato' .. ext[ _G.launchType ] )
		audioSFX['cola'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_cola' .. ext[ _G.launchType ] )
		audioSFX['grill'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_grill_item' .. ext[ _G.launchType ] )
		
		-- place
		audioSFX['bun'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/place_bun' .. ext[ _G.launchType ] )
		audioSFX['rice'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/place_chicken_plate' .. ext[ _G.launchType ] )
		audioSFX['bun_meat'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/place_burger_on_bun' .. ext[ _G.launchType ] )
		audioSFX['rice_meat'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/place_chicken_on_plate' .. ext[ _G.launchType ] )
		
		audioSFX['warmer'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/place_meat_warming_tray' .. ext[ _G.launchType ] )
		audioSFX['warmer_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/warming_tray_sizzle_stop' .. ext[ _G.launchType ] )
		audioSFX['warmer_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/warming_tray_sizzle' .. ext[ _G.launchType ] )
		
		-- loops
		audioSFX['pour'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/pour_cola' .. ext[ _G.launchType ] )
		audioSFX['pour_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/pour_cola_start' .. ext[ _G.launchType ] )
		audioSFX['pour_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/pour_cola_stop' .. ext[ _G.launchType ] )
		
		audioSFX['burger'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/fry_meat' .. ext[ _G.launchType ] )
		audioSFX['burger_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/fry_meat_start' .. ext[ _G.launchType ] )
		audioSFX['burger_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/fry_meat_stop' .. ext[ _G.launchType ] )
		
		audioSFX['chicken'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  ..		 	'/sfx/level1/grill_chicken' .. ext[ _G.launchType ] )
		audioSFX['chicken_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/grill_chicken_start' .. ext[ _G.launchType ] )
		audioSFX['chicken_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/grill_chicken_stop' .. ext[ _G.launchType ] )
		
		audioSFX['fryer'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/fryer' .. ext[ _G.launchType ] )
		audioSFX['fryer_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/fryer_start' .. ext[ _G.launchType ] )
		audioSFX['fryer_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/fryer_stop' .. ext[ _G.launchType ] )
		
		-- testing wav files
		if( _G.launchType == 'Apple' )then
		
			audioSFX['fryer'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/loops/fryer.wav' )
			audioSFX['chicken'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  ..		 	'/sfx/level1/loops/grill_chicken.wav' )
			audioSFX['burger'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/loops/fry_meat.wav' )
			audioSFX['pour'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/loops/pour_cola.wav' )
			
		end
				
	end
	
	if( class=='level2' )then
		
		-- select & serve
		audioSFX['coffee'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level1/serve_cola' .. ext[ _G.launchType ] )
		audioSFX['color'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_color' .. ext[ _G.launchType ] )
		audioSFX['hat'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 					'/sfx/level2/select_hat' .. ext[ _G.launchType ] )
		audioSFX['case'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_iphone_case' .. ext[ _G.launchType ] )
		audioSFX['jeans'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_jeans' .. ext[ _G.launchType ] )
		audioSFX['mug'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 					'/sfx/level2/select_mug' .. ext[ _G.launchType ] )
		audioSFX['sketch'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_sketch' .. ext[ _G.launchType ] )
		audioSFX['sneakers'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/select_sneakers' .. ext[ _G.launchType ] )
		audioSFX['stencil'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_stencil' .. ext[ _G.launchType ] )
		audioSFX['tshirt'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_tshirt' .. ext[ _G.launchType ] )
		
		-- loops
		audioSFX['pour'] = audio.loadSound( 'audio/ios/sfx/level2/loops/coffee_loop.wav' )
		audioSFX['pour_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/coffee_start' .. ext[ _G.launchType ] )
		audioSFX['pour_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/coffee_stop' .. ext[ _G.launchType ] )
		
		audioSFX['stencil_loop'] = audio.loadSound( 'audio/ios/sfx/level2/loops/stencil_loop.wav' )
		audioSFX['stencil_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level2/stencil_start' .. ext[ _G.launchType ] )
		audioSFX['stencil_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level2/stencil_stop' .. ext[ _G.launchType ] )
	
		audioSFX['sketch_loop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/sketch_loop' .. ext[ _G.launchType ] )
		audioSFX['sketch_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level2/sketch_start' .. ext[ _G.launchType ] )
		audioSFX['sketch_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/sketch_stop' .. ext[ _G.launchType ] )
		
	end
	
	if( class=='level3' )then
		
		-- select & serve
		audioSFX['order_pizza'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level3/order_pizza' .. ext[ _G.launchType ] )
		audioSFX['pizza_delivered'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/pizza_delivered' .. ext[ _G.launchType ] )
		
		audioSFX['select_autotune'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_autotune' .. ext[ _G.launchType ] )
		audioSFX['select_cd'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level3/select_cd' .. ext[ _G.launchType ] )
		audioSFX['select_drums'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_drums' .. ext[ _G.launchType ] )
		audioSFX['select_guitar'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_guitar' .. ext[ _G.launchType ] )
		audioSFX['select_keyboard'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level3/select_keys' .. ext[ _G.launchType ] )
		audioSFX['select_phone'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_phone' .. ext[ _G.launchType ] )
		audioSFX['select_pizza'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_pizza' .. ext[ _G.launchType ] )
		audioSFX['select_vol_up'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_vol_up' .. ext[ _G.launchType ] )
		audioSFX['select_vol_down'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_vol_down' .. ext[ _G.launchType ] )
		audioSFX['select_water'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/select_water' .. ext[ _G.launchType ] )
		
		-- loops
		audioSFX['pour'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level3/water_loop' .. ext[ _G.launchType ] )
		audioSFX['pour_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level3/water_start' .. ext[ _G.launchType ] )
		audioSFX['pour_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level3/water_stop' .. ext[ _G.launchType ] )
		
		audioSFX['burn_cd_loop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/burn_cd_loop' .. ext[ _G.launchType ] )
		audioSFX['burn_cd_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/burn_cd_start' .. ext[ _G.launchType ] )
		audioSFX['burn_cd_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level3/burn_cd_stop' .. ext[ _G.launchType ] )

	end
	
	if( class=='level4' )then
		
		-- select & serve
		audioSFX['coffee'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level1/serve_cola' .. ext[ _G.launchType ] )
		audioSFX['color'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_color' .. ext[ _G.launchType ] )
		audioSFX['hat'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 					'/sfx/level2/select_hat' .. ext[ _G.launchType ] )
		audioSFX['case'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_iphone_case' .. ext[ _G.launchType ] )
		audioSFX['jeans'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_jeans' .. ext[ _G.launchType ] )
		audioSFX['sneakers'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/select_sneakers' .. ext[ _G.launchType ] )
		audioSFX['stencil'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_stencil' .. ext[ _G.launchType ] )
		audioSFX['tshirt'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level2/select_tshirt' .. ext[ _G.launchType ] )
		
		audioSFX['sweater'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 				'/sfx/level4/select_sweater' .. ext[ _G.launchType ] )
		audioSFX['gift_box'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level4/select_gift_box' .. ext[ _G.launchType ] )
		audioSFX['application'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level4/select_application' .. ext[ _G.launchType ] )
		audioSFX['place_holder'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level4/place_holder_set' .. ext[ _G.launchType ] )
		
		audioSFX['door_open'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level4/door_open' .. ext[ _G.launchType ] )
		audioSFX['door_close'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level4/door_close' .. ext[ _G.launchType ] )
		audioSFX['curtain_open'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level4/curtain_open' .. ext[ _G.launchType ] )
		audioSFX['curtain_close'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level4/curtain_close' .. ext[ _G.launchType ] )
		
		-- loops
		audioSFX['pour'] = audio.loadSound( 'audio/ios/sfx/level2/loops/coffee_loop.wav' )
		audioSFX['pour_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/coffee_start' .. ext[ _G.launchType ] )
		audioSFX['pour_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level2/coffee_stop' .. ext[ _G.launchType ] )
				
	end
	
	if( class=='level5' )then
	
		-- misc
		audioSFX['burnt'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/burned_food' .. ext[ _G.launchType ] )
		
		-- serve
		audioSFX['mac'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/serve_beans' .. ext[ _G.launchType ] )
		audioSFX['greens'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_lettuce' .. ext[ _G.launchType ] )
		audioSFX['cola'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/serve_cola' .. ext[ _G.launchType ] )
		audioSFX['biscuit'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/select_biscuit' .. ext[ _G.launchType ] )
		
		audioSFX['container'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level5/place_container' .. ext[ _G.launchType ] )
		audioSFX['plate'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/place_plate' .. ext[ _G.launchType ] )
		audioSFX['holder'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/place_holder_set' .. ext[ _G.launchType ] )

		-- place
		audioSFX['warmer'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level1/place_meat_warming_tray' .. ext[ _G.launchType ] )
		audioSFX['warmer_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level1/warming_tray_sizzle_stop' .. ext[ _G.launchType ] )
		audioSFX['warmer_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/warming_tray_sizzle' .. ext[ _G.launchType ] )
		
		-- bonus
		audioSFX['aio_beef'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/all_in_one_brisket' .. ext[ _G.launchType ] )
		audioSFX['aio_chicken'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/all_in_one_chicken' .. ext[ _G.launchType ] )
		audioSFX['aio_pork'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/all_in_one_pulledpork' .. ext[ _G.launchType ] )
		
		-- loops
		audioSFX['pour'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level5/drink_loop' .. ext[ _G.launchType ] )
		audioSFX['pour_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/drink_start' .. ext[ _G.launchType ] )
		audioSFX['pour_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/drink_stop' .. ext[ _G.launchType ] )
		
		audioSFX['chicken'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  ..		 	'/sfx/level1/grill_chicken' .. ext[ _G.launchType ] )
		audioSFX['chicken_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/grill_chicken_start' .. ext[ _G.launchType ] )
		audioSFX['chicken_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level1/grill_chicken_stop' .. ext[ _G.launchType ] )

		audioSFX['fryer'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level5/waffles_loop' .. ext[ _G.launchType ] )
		audioSFX['fryer_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/waffles_start' .. ext[ _G.launchType ] )
		audioSFX['fryer_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/waffles_stop' .. ext[ _G.launchType ] )
		
		audioSFX['burger'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level5/oven_loop' .. ext[ _G.launchType ] )
		audioSFX['burger_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level5/oven_start' .. ext[ _G.launchType ] )
		audioSFX['burger_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/oven_stop' .. ext[ _G.launchType ] )
		
		audioSFX['cooker'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 			'/sfx/level5/cooker_loop' .. ext[ _G.launchType ] )
		audioSFX['cooker_start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 	'/sfx/level5/cooker_start' .. ext[ _G.launchType ] )
		audioSFX['cooker_stop'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/level5/cooker_stop' .. ext[ _G.launchType ] )
				
	end
	
	-- customers, gui
	if( string.find(class, "level") )then
		
		-- stingers
		audioSFX['completed'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/level_complete' .. ext[ _G.launchType ] )
		audioSFX['failed'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/level_failed' .. ext[ _G.launchType ] )
		audioSFX['goal'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/level_popup' .. ext[ _G.launchType ] )

		audioSFX['star1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/1star_reached' .. ext[ _G.launchType ] )
		audioSFX['star2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/2stars_reached' .. ext[ _G.launchType ] )
		audioSFX['star3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/3stars_reached' .. ext[ _G.launchType ] )
		
		audioSFX['celebrity'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/special_customer_enters' .. ext[ _G.launchType ] )
		audioSFX['final'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ] 	 .. 		'/sfx/gui/last_customer' .. ext[ _G.launchType ] )
		
		-- gui
		audioSFX['serve'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/serve_customer' .. ext[ _G.launchType ] )
		audioSFX['select'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/select' .. ext[ _G.launchType ] )
		audioSFX['start'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/play' .. ext[ _G.launchType ] )
		audioSFX['order'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/customer_orders' .. ext[ _G.launchType ] )
		audioSFX['leave'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/customer_leaves' .. ext[ _G.launchType ] )
		audioSFX['ready'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/item_ready' .. ext[ _G.launchType ] )
		audioSFX['collect'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/collect_money' .. ext[ _G.launchType ] )
		audioSFX['garbage'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. 		'/sfx/gui/use_trash' .. ext[ _G.launchType ] )
		
		-- male
		audioSFX['m_happy_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_01' .. ext[ _G.launchType ] )
		audioSFX['m_happy_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_02' .. ext[ _G.launchType ] )
		audioSFX['m_happy_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_03' .. ext[ _G.launchType ] )
		audioSFX['m_happy_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_04' .. ext[ _G.launchType ] )
		audioSFX['m_happy_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_05' .. ext[ _G.launchType ] )
		audioSFX['m_happy_6'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_06' .. ext[ _G.launchType ] )
		audioSFX['m_happy_7'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_07' .. ext[ _G.launchType ] )
		audioSFX['m_happy_8'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_08' .. ext[ _G.launchType ] )
		audioSFX['m_happy_9'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_09' .. ext[ _G.launchType ] )
		audioSFX['m_happy_10'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_10' .. ext[ _G.launchType ] )
		audioSFX['m_happy_11'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_11' .. ext[ _G.launchType ] )
		audioSFX['m_happy_12'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_12' .. ext[ _G.launchType ] )
		audioSFX['m_happy_13'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/happy_13' .. ext[ _G.launchType ] )

		audioSFX['m_angry_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/angry_01' .. ext[ _G.launchType ] )
		audioSFX['m_angry_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/angry_02' .. ext[ _G.launchType ] )
		audioSFX['m_angry_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/angry_03' .. ext[ _G.launchType ] )
		audioSFX['m_angry_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/angry_04' .. ext[ _G.launchType ] )
		audioSFX['m_angry_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/angry_05' .. ext[ _G.launchType ] )
		
		audioSFX['m_annoyed_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/annoyed_01' .. ext[ _G.launchType ] )
		audioSFX['m_annoyed_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/annoyed_02' .. ext[ _G.launchType ] )
		audioSFX['m_annoyed_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/annoyed_03' .. ext[ _G.launchType ] )
		audioSFX['m_annoyed_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/annoyed_04' .. ext[ _G.launchType ] )
		audioSFX['m_annoyed_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/male/annoyed_05' .. ext[ _G.launchType ] )

		-- female
		audioSFX['f_happy_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_01' .. ext[ _G.launchType ] )
		audioSFX['f_happy_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_02' .. ext[ _G.launchType ] )
		audioSFX['f_happy_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_03' .. ext[ _G.launchType ] )
		audioSFX['f_happy_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_04' .. ext[ _G.launchType ] )
		audioSFX['f_happy_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_05' .. ext[ _G.launchType ] )
		audioSFX['f_happy_6'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_06' .. ext[ _G.launchType ] )
		audioSFX['f_happy_7'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_07' .. ext[ _G.launchType ] )
		audioSFX['f_happy_8'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_08' .. ext[ _G.launchType ] )
		audioSFX['f_happy_9'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_09' .. ext[ _G.launchType ] )
		audioSFX['f_happy_10'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_10' .. ext[ _G.launchType ] )
		audioSFX['f_happy_11'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_11' .. ext[ _G.launchType ] )
		audioSFX['f_happy_12'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_12' .. ext[ _G.launchType ] )
		audioSFX['f_happy_13'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/happy_13' .. ext[ _G.launchType ] )

		audioSFX['f_angry_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/angry_01' .. ext[ _G.launchType ] )
		audioSFX['f_angry_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/angry_02' .. ext[ _G.launchType ] )
		audioSFX['f_angry_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/angry_03' .. ext[ _G.launchType ] )
		audioSFX['f_angry_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/angry_04' .. ext[ _G.launchType ] )
		audioSFX['f_angry_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/angry_05' .. ext[ _G.launchType ] )
	
		audioSFX['f_annoyed_1'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/annoyed_01' .. ext[ _G.launchType ] )
		audioSFX['f_annoyed_2'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/annoyed_02' .. ext[ _G.launchType ] )
		audioSFX['f_annoyed_3'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/annoyed_03' .. ext[ _G.launchType ] )
		audioSFX['f_annoyed_4'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/annoyed_04' .. ext[ _G.launchType ] )
		audioSFX['f_annoyed_5'] = audio.loadSound( 'audio/' .. folder[ _G.launchType ]  .. '/customer/female/annoyed_05' .. ext[ _G.launchType ] )

	end
		
end

function playNavSFX(title)
	
	--print('play nav sfx: ' .. title )
	
	local availableChannel = audio.findFreeChannel()
	audio.play( navSFX[title], { channel=availableChannel } )
	audio.setVolume( sfxVolume, { channel=availableChannel } )

end

function playSFX(title)
	
	--print('play sfx: ' .. title )
	
	if( title == 'ready' )then
		
		audio.play( audioSFX[title], { channel=readyChannel } )
		return
		
	end
	
	local availableChannel = audio.findFreeChannel()
	audio.play( audioSFX[title], { channel=availableChannel } )
	audio.setVolume( sfxVolume, { channel=availableChannel } )
	
	--print('volume: ' .. sfxVolume)

end

function stopSFX(title)
	
	--print('stop sfx: ' .. title)
	
	if( (title == 'pour') or (title=='coffee_loop') )then
	
		audio.stop(sodaChannel)
		
	end
	
	if( (title == 'fryer') or (title=='sketch_loop') or (title=='burn_cd_loop') )then
	
		audio.stop(fryerChannel)
		
	end
	
	if( (title == 'burger') or (title=='stencil_loop') )then
		
		--print('stop stencil loop')
		audio.stop(burgerChannel)

	end
	
	if( title == 'chicken' )then
	
		audio.stop(chickenChannel)
		
	end
	
	if( title == 'cooker' )then
	
		audio.stop(cookerChannel)
		
	end
	
end

function playLoop(title)
	
	local channel = audio.findFreeChannel()
	
	--print('play loop: ' .. title )
	
	if( (title == 'pour') or (title=='coffee_loop') )then
		
		channel = sodaChannel
		
	end
	
	if( (title == 'fryer') or (title=='sketch_loop') or (title=='burn_cd_loop') )then
		
		channel = fryerChannel
		
	end
	
	if( (title == 'burger') or (title=='stencil_loop') )then
		
		channel = burgerChannel
		
	end
	
	if( title == 'chicken' )then
		
		channel = chickenChannel
		
	end
	
	if( title == 'cooker' )then
		
		channel = cookerChannel
		
	end
	
	audio.play( audioSFX[title], { channel=channel, loops=20 } )
	audio.setVolume( sfxVolume, { channel=channel } )
	
end

function killSFX()
	
	audio.stop()
	
	for k,v in pairs( audioSFX ) do
		
	    --print( "KEY: "..k.." | ".."VALUE: "..v )
		
		audio.dispose( audioSFX[k] )
		
	end
	
end

------------------------- DESTORY




