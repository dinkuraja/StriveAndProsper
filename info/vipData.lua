
module(..., package.seeall)

-------------------------- IMPORTS & SETTINGS


-------------------------- VARIABLES

local vipData = {}

-- rocky
vipData[1] = {}
vipData[1].name = 'A$AP Rocky'
vipData[1].title = 'Founding member of The A$AP Mob'
vipData[1].img = 'celeb01'
vipData[1].locked = false
vipData[1].price = '1.99'
vipData[1].stats = { {'FAVORITE ORDER:','Salmon Burger'},{'TIPS:','25% Bonus Cash'},{'CEELO:','Trip Specialist'} }
vipData[1].quote = "Syrup got me throwed, mouth is full of gold."

-- yams
vipData[2] = {}
vipData[2].name = 'A$AP Yams'
vipData[2].title = 'Founding member of The A$AP Mob'
vipData[2].img = 'celeb02'
vipData[2].locked = false
vipData[2].price = '2.99'
vipData[2].stats = { {'FAVORITE ORDER:','Chicken & Waffles'},{'TIPS:','30% Bonus Cash'},{'CEELO:','Ceelo Master'} }
vipData[2].quote = "Rocky's like Skywalker... and I'm Yoda."

-- nigel
vipData[3] = {}
vipData[3].name = 'Nigel Sylvester'
vipData[3].title = 'Professional BMX biker'
vipData[3].img = 'celeb03'
vipData[3].locked = false
vipData[3].price = '1.99'
vipData[3].stats = { {'FAVORITE ORDER:','Anything Sweet'},{'TIPS:','15% Bonus Cash'},{'CEELO:','Doubles Specialist'} }
vipData[3].quote = "I'm so used to hate that I'm starting to embrace it."

-- coming soon
vipData[4] = {}
vipData[4].name = 'Coming Soon'
vipData[4].title = ''
vipData[4].img = 'celeb01'
vipData[4].locked = true
vipData[4].price = '1.99'
vipData[4].stats = { {'FAVORITE ORDER:','Salmon Burger'},{'TIPS:','25% Bonus Cash'},{'CEELO:','Trip Specialist'} }

-- coming soon
vipData[5] = {}
vipData[5].name = 'Coming Soon'
vipData[5].title = ''
vipData[5].img = 'celeb01'
vipData[5].locked = true
vipData[5].price = '1.99'
vipData[5].stats = { {'FAVORITE ORDER:','Salmon Burger'},{'TIPS:','25% Bonus Cash'},{'CEELO:','Trip Specialist'} }

-------------------------- INIT


-------------------------- CONSTRUCTION


------------------------- EVENTS

function getVipData()
	
	return vipData
	
end

------------------------- DESTORY


