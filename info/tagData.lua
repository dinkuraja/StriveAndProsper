
module(..., package.seeall)

-------------------------- IMPORTS & SETTINGS


-------------------------- VARIABLES

local tagData = {}

-- tag: 1
tagData[1] = {}
tagData[1].name = 'Hungry Ham'
tagData[1].detail = "A$AP Ferg grew up on 143rd between Broadway and Amsterdam in Hamilton Heights, which is located in New York City's Harlem neighborhood. Hungry Ham is the nickname given to the Hamilton Heights area as everyone living there is hungry to get off the block. Ferg raps here about difficult experiences he endured in his early years living on this particular block."
tagData[1].sx = 600
tagData[1].sy = 300

-------------------------- INIT


-------------------------- CONSTRUCTION


------------------------- EVENTS

function getTagInfo()
	
	return tagData
	
end

------------------------- DESTORY


