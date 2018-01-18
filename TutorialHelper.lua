module(..., package.seeall)

displaying = false -- Check Tutorial remaining for 
autoHideSec = 3000 -- In milliseconds
tutorialNo = 0 -- Check Tutorial is Running
tutorialRunning = false -- Check Tutorial is Running
data = {}

noActionDrag = false
noActiontap = false
noActionTimer = false
noActiontapColor = false
noTutTap = false
noActiontapMeat = false

targetAction = ""
totalDisplay = 0
totalTutorial = 0

function checkTargetTouch ( tagert )
    if displaying then
        if tagert == 1 then
            return _G.TutorialData.noTutTap
        elseif tagert == 2 then
            return _G.TutorialData.noActionDrag
        elseif tagert == 3 then
            return _G.TutorialData.noActiontap
        elseif tagert == 33 then
            return _G.TutorialData.noActiontapColor
        elseif tagert == 34 then
            return _G.TutorialData.noActiontapMeat
        elseif tagert == 4 then
            return _G.TutorialData.noActionTimer
        else
            return false
        end
    else
        return false
    end
end

function getTotalDisplayTutorail()
    local remainCount = 0
    local tCount = 0
    for k, v in pairs(defaultData) do
        if not v.display then
            remainCount = remainCount + 1
        end
        -- remainCount = remainCount + 1
        tCount = tCount + 1
    end
    totalDisplay = remainCount
    totalTutorial = tCount
end

function checkTutorialLevelData()
    for k, v in pairs(_G.TutorialData.data) do
        if not v.display and v.level and v.stage then
            for l, m in pairs(_G.TutorialData.data) do
                -- print( m.display, m.level, v.level, m.stage,v.stage )
                if m.display and m.level == v.level and m.stage == v.stage then
                    v.display = true
                    _G.TutorialData.data[k] = v
                    break
                end
            end
        end
    end
end

--[[

    It is for tutorial data that need to displaying tutorial.

    ->  message :   Display Message in tutorial.

    ->  display :   Tutorial is displayed or not.

    ->  type    :   it is where to display the tutorial
                ->  none( Center scene )
                ->  up( object is above )
                ->  below( object is below )
                ->  left ( object is in left side )
                ->  right ( object is in right side )

    ->  tutType :   Type of tutorial
                ->  1. Informative
                ->  2. Drag Action Perform
                ->  3. Tap Action Perform
                ->  4. Timer Action Perform

    ->  x       :   X position of tutorial

    ->  Y       :   Y position of tutorial

    ->  stage   :   Stage of game which between the 1 to 5 ( In game it call level ) Default 0 .

    ->  level   :   Level of game which between the 1 to 30 or more ( In game it call Stage ) Default 0 .

    ->  fy      :   First y postion of tutorial means where the tutorial come from in animation Default 0 .

    ->  fx      :   First x postion of tutorial means where the tutorial come from in animation  Default 0 .

    ->  dynamicX    :   If true then x pos is dynamic.

    ->  dynamicY    :   If true then y pos is dynamic.

]]--
defaultObjectTargetType = {
    dragDrink={
        mode = "auto-fill",
        select = "cola",
        stage = 1,
        level = 1,
    },
    dragLemonadeDrink5={
        mode = "auto-fill",
        select = "cola",
        stage = 5,
        level = 1,
    },
    selectChicken5={
        targ = "chicken",
        stage = 5,
        level = 1,
    },
    selectPork5={
        targ = "pork",
        stage = 5,
        level = 4,
    },
    selectBrisket5={
        targ = "beef",
        stage = 5,
        level = 11,
    },
    dragWhiteShoseT3={
        mode = "cooker",
        select = "sneakers",
        stage = 4,
        level = 8,
    },
    collectMoney={
        mode = "collect",
        select = "money",
        stage = 1,
        level = 1,
    },
    collectArtStandMoney={
        mode = "collect",
        select = "money",
        stage = 2,
        level = 1,
    },
    collectFregsApperalMoney={
        mode = "collect",
        select = "money",
        stage = 4,
        level = 1,
    },
    
    collectArtStand2Money={
        mode = "collect",
        select = "money",
        stage = 2,
        level = 2,
    },
    collectMoney2={
        mode = "collect",
        select = "money",
        stage = 1,
        level = 1,
    },
    collectMoney51={
        mode = "collect",
        select = "money",
        stage = 5,
        level = 1,
    },
    collectBackDoorMoney={
        mode = "collect",
        select = "money",
        stage = 3,
        level = 1,
    },
    dragPattyToCustomer = {
        mode = "sandwich",
        stage = 1,
        level = 4,
    },
    pattyToFries={
        mode = "meat",
        targ = "gyro",
        type = "single",
        stage = 1,
        level = 1,
    },
    dragPlatesPreperingDishes52={
        mode = "sandwich",
        targ = "plate",
        type = "single",
        stage = 5,
        level = 1,
    },
    dragPlatesPreperingDishes511={
        mode = "sandwich",
        targ = "plate",
        type = "single",
        stage = 5,
        level = 11,
    },
    dragChickenPlate5={
        mode = "topping",
        stage = 5,
        level = 1,
    },
    dragBrisket5={
        mode = "topping",
        stage = 5,
        level = 11,
    },
    dragCd={
        mode = "cd",
        stage = 3,
        level = 1,
    },
    dragPorkCustomer52={
        mode = "topping",
        stage = 5,
        level = 4,
    },
    dragChickenPlateCustomer5={
        mode = "sandwich",
        select = "plate",
        stage = 5,
        level = 1,
    },
    dragOrderedPizza={
        mode = "cooker",
        select = "select_pizza",
        stage = 3,
        level = 11,
    },
    selectPent23={
        mode = "clothes",
        targ = "pants",
        type = "single",
        stage = 4,
        level = 1,
    },
    orderPizza={
        mode = "cooker",
        targ = "pizza",
        type = "all",
        stage = 3,
        level = 11,
    },
    selectWhiteShoseColorT3={
        mode = "cooker",
        targ = "shoes02",
        type = "all",
        stage = 4,
        level = 8,
    },
    selectDiskBurner={
        mode = "cd",
        targ = "cds",
        type = "single",
        stage = 3,
        level = 1,
    },
    selectLogo={
        mode = "stencil",
        select = "stencil",
        stage = 2,
        level = 2,
    },
    selectDrawing={
        mode = "cooker",
        targ = "sketch",
        type = "single",
        stage = 2,
        level = 11,
    },
    selectpaint={
        mode = "clothes",
        targ="jeans",
        type = "single",
        stage = 2,
        level = 1,
    },
    selectpaint2={
        mode = "clothes",
        targ="jeans",
        type = "single",
        stage = 2,
        level = 2,
    },
    selectColor={
        stage = 2,
        level = 1,
        selNumber=1
    },
    selectColor3={
        stage = 4,
        level = 1,
        selNumber=2
    },
    dragBurgerBanBottom={
        mode = "sandwich",
        stage = 1,
        level = 1,
    },
    dragPent3={
        mode = "clothes",
        select="jeans",
        stage = 4,
        level = 1,
    },
    dragAutotune={
        select = "select_autotune",
        mode="instant-fill",
        stage = 3,
        level = 1,
    },
    dragUpButton={
        select = "select_vol_up",
        mode="volume",
        stage = 3,
        level = 1,
    },
    dragToCustomerLogo={
        mode = "clothes",
        select="jeans",
        stage = 2,
        level = 2,
    },
    
    dragpaint={
        mode = "clothes",
        select="jeans",
        stage = 2,
        level = 1,
    },
    burgerBanBottom={
        mode = "sandwich",
        targ = "pita",
        type = "single",
        stage = 1,
        level = 1,
    },
    throwOtherBurger={
        mode = "meat",
        targ = "gyro",
        type = "single",
        stage = 1,
        level = 1,
    },
    decayItem={
        mode = "meat",
        select = "grill",
        stage = 1,
        level = 1,
        targDelet = true
    },
    warmerMessageChikanFrier={
        mode = "meat",
        select = "grill",
        stage = 1,
        level = 4,
    },
    pattyFried={
        mode = "meat",
        select = "grill",
        stage = 1,
        level = 1,
    },
    chikanFrier={
        mode = "meat",
        targ = "hotdog",
        type = "single",
        stage = 1,
        level = 4,
    },
    secondChikanFrier={
        mode = "meat",
        targ = "hotdog",
        type = "single",
        stage = 1,
        level = 4,
    },
    ricePlat={
        mode = "sandwich",
        targ = "buns",
        type = "single",
        stage = 1,
        level = 4,
    },
    chikanFried={
        mode = "meat",
        select = "grill",
        stage = 1,
        level = 4,
    },
    tapFrier={
        mode = "cooker",
        targ = "knish",
        type = "all",
        stage = 1,
        level = 18,
    },
    dragFrier={
        mode = "cooker",
        select = "fries",
        stage = 1,
        level = 18,
    },
    lowBetCello={
        tap = "btn1",
    } 
}
-- Common tutorial information.
defaultData = {
    wellcomeCelloMessage = {
        message = "Ceelo is a popular street game in Harlem.",
        display = true,
        type = "none2",
        tutType = 1,
    },
    lowBetCello = {
        message = "First, let's start by making a bet. For now, we'll just choose to bet Low.",
        display = true,
        type = "below",
        tutType = 3
    },
    info1Message = {
        message = "Ceelo is played with three die. If a player rolls 'ceelo' they win and the game is over. A ceelo is when a player rolls 4, 5, and 6.",
        display = true,
        type = "none2",
        tutType = 1
    },
    info2Message = {
        message = "But the game can also end if a player 'busts'. If a player rolls a 1, 2, and 3 they lose and the game is over. ",
        display = true,
        type = "none2",
        tutType = 1
    },
    info3Message = {
        message = "If you don't hit ceelo or bust, you can still score if two of the dice have the same number. Then, your score is the third number. If you rolled 4,4, 6, your score is 6.",
        display = true,
        type = "none2",
        tutType = 1
    },
    roolMessage = {
        message = "If you and your opponent score the same, then the game ends in a tie and everyone gets their money back. I think you should be ready to start playing!",
        display = true,
        type = "none2",
        tutType = 1
    },
    
    -- Wellcome message.
    wellcomeMessage = {
        message = "What's up! My name is A$AP Ferg, and  I hope you're ready to explore my hometown: Harlem! Come on, let's get going. ",
        display = true,
        type = "none2",
        tutType = 1
    },    
    wellcomeMessage57 = {
        message = "Now some of your customers might want some sides.",
        display = true,
        type = "none2",
        tutType = 1,
    },
    -- Please select stage one.
    mainSatage = {
        message = "We'll start at Heggie's burger joint first.",
        display = true,
        type = "left",
        tutType = 3
    },
    
    -- After select stage overlay display with play button.
    playStage = {
        message = "Hit play to begin!",
        display = true,
        type = "below",
        tutType = 3
    },
    
    -- After select level one.
    selectLevel = {
        message = "Let's start at Level One!",
        display = true,
        type = "left",
        tutType = 3
    },
    -- Wellcome message.
    wellcomeHaggisMessage = {
        message = "You’ve gotta start somewhere! Let me show you how to serve it up at Heggies.",
        display = true,
        type = "none2",
        tutType = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeArtStandMessage = {
        message = "It's time to get creative! Welcome to the Art Stand!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 2,
        level = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeBackDoorMessage = {
        message = "Welcome to Blackdoor Recordings! Lemme show you how to help your clients cook up sick beats!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 3,
        level = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeCopelandMessage = {
        message = "This is Copeland's famous chicken & waffle shack! Everyone loves chicken & waffles!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 5,
        level = 1,
    },
    wellcomeCopelandMessage2 = {
        message = "Let me show you around the kitchen!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 5,
        level = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeFregsApparelMessage = {
        message = "Welcome to my personal boutique!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 4,
        level = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeFregsApparelMessage2 = {
        message = "I got started selling clothes right here on the Upper West Side. Let’s see if you’ve got what it takes to make it too!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 4,
        level = 1,
    },
    -- Wellcome Art Stand message.
    wellcomeArtStand11Message = {
        message = "It's time to get really creative! You can now create drawings for customers.",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 2,
        level = 11,
    },
    -- Wellcome Art Stand message.
    wellcomeArtStand4Message = {
        message = "You can create T-shirts now!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 2,
        level = 4,
    },
    -- Wellcome Art Stand message.
    wellcomeArtStand7Message = {
        message = "You can create caps now!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 2,
        level = 7,
    },
    -- Wellcome message.
    wellcomeLastMessage = {
        message = "Congratulations! You've unlocked the last food item at Heggie's: the deep fryer!" ,
        display = true,
        type = "none2",
        tutType = 1,
        stage = 1,
        level = 18,
    },
    waitChikenFriesReady = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 5,
        level = 1,
        tutType = 4
    },
    waitOrderPizza = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 3,
        level = 11,
        tutType = 4
    },
    waitCustomerAutotuneDone = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 3,
        level = 1,
        tutType = 4
    },
    waitCustomerCdDone = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 3,
        level = 1,
        tutType = 4
    },
    waitCustomerUpButtonDone = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 3,
        level = 1,
        tutType = 4
    },
    waitPorkFriesReady = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 5,
        level = 4,
        tutType = 4
    },
    waitBiscutFriesReady = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 5,
        level = 11,
        tutType = 4
    },
    -- Wellcome message.
    wellcomeTopingsMessage = {
        message = "Certain customers might want toppings too.",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 1,
        level = 5,
    },

    -- First time customer come here message.
    firstCopelendCustomerMessage = {
        message = "This customer wants chicken and some lemonade. Let's make him some!",
        display = true,
        type = "right",
        stage = 5,
        level = 1,
        tutType = 1
    },
    lastBackDorrMessage = {
        message = "And that's all you need to know about Blackdoor Recordings!",
        display = true,
        type = "none2",
        tutType = 1,
        stage = 3,
        level = 11,
    },
    -- First time customer come here message.
    firstBackdoorRecordingsCustomerMessage = {
        message = "It looks like this client wants some tools to help him become a better artist. Let's start with some autotune.",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 1
    },
    -- First time customer come here message.
    firstCustomerMessage = {
        message = "Here is your first customer! He wants a drink.",
        display = true,
        type = "right",
        stage = 1,
        level = 1,
        tutType = 1
    },
    -- First time customer come here message.
    firstFragsApperal2CustomerMessage = {
        message = "This customer wants a pair of fresh white kicks, good news is you can order those now! ",
        display = true,
        type = "right",
        stage = 4,
        level = 8,
        tutType = 1
    },
    -- First time customer come here message.
    artFirstCustomerMessage = {
        message = "You can now put designs on your clothing! This customer wants white pants with a 'Trap Lord' design. Let's make them! ",
        display = true,
        type = "right",
        stage = 2,
        level = 2,
        tutType = 1
    },
    -- Second time customer come here message.
    secondCustomerMessage = {
        message = "Nice! Here's your second customer: he wants a salmon burger. Let's make him one!",
        display = true,
        type = "right",
        stage = 1,
        level = 1,
        tutType = 1
    },
    -- Thirds time customer come here message.
    thirdCustomerMessage = {
        message = "This customer wants some jerk chicken, let's make them some! ",
        display = true,
        type = "right",
        stage = 1,
        level = 4,
        tutType = 1
    },
    -- Drag drink to customer message.
    dragDrink = {
        message = "So just drag the cola over to him.",
        display = true,
        type = "left",
        stage = 1,
        level = 1,
        tutType = 2
    },
    waitDrinkReady = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 1,
        level = 1,
        tutType = 4
    },
    waitShoseReady = {
        message = "Wait for the dispenser to fill the cup, then drag the drink to the customer!",
        display = true,
        type = "none2",
        stage = 4,
        level = 8,
        tutType = 4
    },
    waitPaintReady = {
        message = "Now just wait for your design to finish...",
        display = true,
        type = "none2",
        stage = 2,
        level = 2,
        tutType = 4
    },
    -- Don't forget to collect money.
    collectMoney= {
        message = "And don’t forget to pick up your money! Just tap on it!",
        display = true,
        type = "right",
        stage = 1,
        level = 1,
        tutType = 3
    },
    -- Don't forget to collect money.
    collectBackDoorMoney= {
        message = "And don't forget to pick up your cash! ",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 3
    },
    -- Don't forget to collect money.
    collectArtStand2Money= {
        message = "And that's all there is to it! Pick up your money!",
        display = true,
        type = "right",
        stage = 2,
        level = 2,
        tutType = 3
    },
    -- Don't forget to collect money.
    collectArtStandMoney= {
        message = "Again, don't forget your money!",
        display = true,
        type = "right",
        stage = 2,
        level = 1,
        tutType = 3
    },
    -- Don't forget to collect money.
    collectFregsApperalMoney= {
        message = "Again, don't forget to pick up your money!",
        display = true,
        type = "right",
        stage = 4,
        level = 1,
        tutType = 3
    },
    -- Don't forget to collect money.
    collectMoney2= {
        message = "Don't forget to pick up your money!",
        display = true,
        type = "right",
        stage = 1,
        level = 1,
        tutType = 3
    },

    -- Bun Burger Bottom.
    burgerBanBottom= {
        message = "Tap on the hamburger bun to set it on the counter.",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 3
    },
    -- Wellcome message.
    throwOtherBurger = {
        message = "Alright now let's throw another patty on the grill.",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 3
    },
    -- Burger Vadu
    pattyToFries={
        message = "Tap on the meat to place it on the grill.",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 3
    },
    -- Bun Burger Bottom.
    dragBurgerBanBottom= {
        message = "Now just drag the burger over to the customer!",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 2
    },
    -- Bun Burger Bottom.
    dragPattyToCustomer= {
        message = "Now just drag the dish over to the customer!",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        tutType = 2
    },
    
    -- Burger vadu frie
    waitPattyFried={
        message = "Wait until the meat is cooked!",
        display = true,
        type = "none2",
        stage = 1,
        level = 1,
        tutType = 4
    },
    -- Burger vadu frie
    secondWaitPattyFried={
        message = "Let's leave this burger on the grill and see what happens!",
        display = true,
        type = "none2",
        stage = 1,
        level = 1,
        tutType = 4
    },
    -- Burger vadu frie
    pattyFried={
        message = "The meat is ready. Now drag and place it on the bun.",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 2
    },
    
    -- Burger Topins
    lettuceTopings={
        message = "Now customers might start asking for lettuce! Just drag the topping onto their burger whenever they ask for it!" ,
        display = true,
        type = "left",
        stage = 1,
        level = 11,
        twoArraw = true,
    },
    
    -- Burger Topins
    tometoToping={
        message = "It looks like your customers want more toppings! Drag the tomatoes onto their burger whenever they ask for it! ",
        display = true,
        type = "left",
        stage = 1,
        level = 12
    },
    -- Chikan Rice plate 
    ricePlat = {
        message = "Tap on the tray to set it on the counter! ",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        tutType = 3
     },
     
     -- -- Pita in rice plate
     -- riceTopings = {
     --    message = "drag chikan to rice plate if customer need.",
     --    display = true,
     --    type = "left",
     --    stage = 1,
     --    level = 2
     -- },
     
     -- Pita in rice plate
     chikanFrier = {
        message = "Tap on the chicken to place it on the grill.",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        tutType = 3
     },
    -- Burger vadu frie
    waitChikanFried={
        message = "Wait until the meat is cooked!",
        display = true,
        type = "none2",
        stage = 1,
        level = 4,
        tutType = 4
    },
    -- Chikan in rice plate
    chikanFried = {
        message = "The meat is ready, drag the chicken onto the plate.",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        level = 4,
        tutType = 2
    },
    -- Wellcome message.
    secondChikanFrier = {
        message = "Let's throw another piece of chicken onto the grill.",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        tutType = 3
    },
    -- Wellcome message.
    warmerMessageChikanFrier = {
        message = "Uh oh! There's nobody around. Drag the chicken to the food warmer so it doesn't burn!",
        display = true,
        type = "below",
        stage = 1,
        level = 4,
        tutType = 2
    },
    -- Burger vadu frie
    wait2PattyFried={
        message = "Wait until the meat is cooked!",
        display = true,
        type = "none2",
        stage = 1,
        level = 4,
        tutType = 4
    },
    -- Pita in rice plate
     tapFrier = {
        message = "Tap on the deep fryer to cook up some fish & chips!",
        display = true,
        type = "below",
        stage = 1,
        level = 18,
        tutType = 3
     },
     -- Pita in rice plate
     waitFrier = {
        message = "Wait for the deep fryer to finish...",
        display = true,
        type = "none2",
        stage = 1,
        level = 18,
        tutType = 4
     },
    -- Chikan in rice plate
    dragFrier = {
        message = "Then just drag it to the customer",
        display = true,
        type = "below",
        stage = 1,
        level = 18,
        tutType = 2
    },
    -- Upgrad button.
    upgradNow = {
        message = "Then tap here to upgrade it!",
        display = true,
        type = "below",
        tutType = 3
    },
    -- Upgrad Info.
    upgradInfo = {
        message = "Use the money you earn from running your businesses to upgrade your food, equipment, or even your restaurant!",
        display = true,
        type = "none2",
        tutType = 1
    },
    -- Topin.
    selectUpdate = {
        message = "Select the item you want to upgrade!",
        display = true,
        type = "left",
        tutType = 3
    },

    -- Pita in rice plate
    PitaSelect = {
        message = "Like mangoes with their chicken! Just drag the topping onto the tray whenever the customer asks for mangoes. ",
        display = true,
        type = "left",
        stage = 1,
        level = 5
    },
    -- Extra burnt.
    decayItem = {
        message = "Uh oh! looks like this burger got burnt! Drag it over to the garbage!",
        display = true,
        type = "below",
        stage = 1,
        level = 1,
        tutType = 2
    },
    -- Select Color
    selectColor = {
        message = "Looks like this customer wants red pants. Well we can make them a pair! Just tap on the color first!",
        display = true,
        type = "right",
        stage = 2,
        level = 1,
        tutType = 33
    },
    -- Slect paint.
    selectpaint = {
        message = "Now tap on the pants below the counter to make the pants.",
        display = true,
        type = "below",
        stage = 2,
        level = 1,
        tutType=3
    },
    -- Slect paint.
    selectpaint2 = {
        message = "First, create the right-colored pants!",
        display = true,
        type = "below",
        stage = 2,
        level = 2,
        tutType=3
    },
     
    -- Drag paint.
    dragpaint = {
        message = "And drag them over to the customer.",
        display = true,
        type = "below",
        stage = 2,
        level = 1,
        tutType=2
    },
    -- Slect Coffe.
    selectCoffe = {
        message = "Some customers might get thirsty shopping and want coffee! Make sure to serve them up!",
        display = true,
        type = "left",
        stage = 2,
        level = 1,

    },
    -- Remove Colths.
    removeCloth = {
        message = "But watch out, if you select the wrong-colored pants, you're going to need to throw them out!",
        display = true,
        type = "below",
        stage = 2,
        level = 1
    },
    -- Remove Colths.
    removeItemFragApperalItem = {
        message = "But, don't forget that if you make the wrong color T-shirt, you might have to throw it in the garbage to make room for a new t-shirt!",
        display = true,
        type = "below",
        stage = 4,
        level = 1
    },
    -- Select Logo
    selectLogo = {
        message = "To make a design, just drag it onto the clothing item.",
        display = true,
        type = "right",
        stage = 2,
        level = 2,
        tutType = 2
    },
    -- Select Logo
    dragToCustomerLogo = {
        message = "Looks like the design is done! Let's drag it over to the customer.",
        display = true,
        type = "right",
        stage = 2,
        level = 2,
        tutType = 2
    },
    -- Slect Tshirts.
    selectTshirts = {
        message = "Prepare T-shirts by tapping on a color, then tapping on the T-shirt under the counter.",
        display = true,
        type = "below",
        stage = 2,
        level = 4
    },
    -- Slect Cap.
    selectCap = {
        message = "Prepare a cap by tapping on a color, then tapping on the cap under the counter!",
        display = true,
        type = "below",
        stage = 2,
        level = 7
    },
    -- Slect Cap.
    selectDrawing = {
        message = "Just tap on the sketch book to create one...",
        display = true,
        type = "left",
        stage = 2,
        level = 11,
        tutType = 3
    },
    waitDrawing={
        message = "Then wait for it to finish...",
        display = true,
        type = "none2",
        stage = 2,
        level = 11,
        tutType = 4
    },
    -- Drag Cap.
    dragDrawing = {
        message = "There you go! A beautiful drawing for your next customer.",
        display = true,
        type = "none2",
        stage = 2,
        level = 11
    },
    -- Slect Cap.
    selectMug = {
        message = "Customers can now ask for mugs! Just tap on the mug box then wait to create a mug.",
        display = true,
        type = "below",
        stage = 2,
        level = 15
    },
    -- -- Drag Cap.
    -- dragMug = {
    --     message = "Drawing is mug. Drag it to the customer",
    --     display = true,
    --     type = "below",
    --     stage = 2,
    --     level = 15
    -- },
    -- Slect Cap.
    selectBelt = {
        message = "Congrats, you've unlocked the final item at the Art Stand. If a customer asks for a belt just tap on the belt box and wait!",
        display = true,
        type = "below",
        stage = 2,
        level = 18
    },
    -- -- Drag Cap.
    -- dragBelt = {
    --     message = "Belt is ready. Drag it to the customer",
    --     display = true,
    --     type = "below",
    --     stage = 2,
    --     level = 18
    -- },
    -- Drag Cap.
    dragDrink3 = {
        message = "You can also serve coffee if any of your shoppers get thirsty!",
        display = true,
        type = "left",
        stage = 4,
        level = 4
    },
    -- Drag Cap.
    selectColor3 = {
        message = "Well... two taps. Just tap the color you want,",
        display = true,
        type = "right",
        stage = 4,
        level = 1,
        tutType = 33
    },
    -- -- Drag Cap.
    -- selectPent3 = {
    --     message = "Pants...",
    --     display = true,
    --     type = "below",
    --     stage = 4,
    --     level = 1
    -- },
    -- Drag Cap.
    selectPent23 = {
        message = "followed by the item.",
        display = true,
        type = "below",
        stage = 4,
        level = 1,
        tutType=3
    },
    -- Drag Cap.
    selectCap3 = {
        message = "Just select a color and tap on the cap under the counter.",
        display = true,
        type = "below",
        stage = 4,
        level = 10
    },
    -- Drag Cap.
    selectPlainColorT3 = {
        message = "Congrats! You can now create sweaters in the same way you create t-shirts and pants!",
        display = true,
        type = "below",
        stage = 4,
        level = 6
    },
    -- Drag Cap.
    selectMultiColorT3 = {
        message = "Here at Ferg's Apparel, you can create t-shirts and pants  with the tap of a button.",
        display = true,
        type = "none2",
        stage = 4,
        level = 1
    },
    -- Drag Cap.
    selectWhiteShoseColorT3 = {
        message = "You can order some white shoes by tapping on the white box!",
        display = true,
        type = "below",
        stage = 4,
        level = 8,
        tutType=3
    },
    -- Drag Cap.
    selectBlackShoseColorT3 = {
        message = "You can order some shoes by tapping on the black box.",
        display = true,
        type = "below",
        stage = 4,
        level = 1
    },
    -- Drag Cap.
    dragPent3 = {
        message = "Then drag it to the customer.",
        display = true,
        type = "below",
        stage = 4,
        level = 1,
        tutType=2
    },
    -- Drag Cap.
    dragWhiteShoseT3 = {
        message = "Now just drag them to the customer.",
        display = true,
        type = "below",
        stage = 4,
        level = 8,
        tutType=2
    },
    dragjobRequestT3 = {
        message = "A$AP Ferg has always been about giving back to the community. If a customer wants job request forms, drag them from under the counter!",
        display = true,
        type = "below",
        stage = 4,
        level = 12
    },
    selectPhoneCaseT3 = {
        message = "If a customer wants a phone case, tap on the box under the table and wait for it to be delivered.",
        display = true,
        type = "below",
        stage = 4,
        level = 15
    },
    dragGift = {
        message = "Customers might also want to give your items to their friends and family. So just drag a gift to the customers who ask for it.",
        display = true,
        type = "below",
        stage = 4,
        level = 11
    },
    
    dragAutotune = {
        message = "Just drag over the autotune into his box.",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 2
    },
    dragKeyboard = {
        message = "You can also give the client some keyboard...",
        display = true,
        type = "below",
        stage = 3,
        level = 1,
        tutType = 1
    },
    dragUpButton = {
        message = "Next, your client wants to turn his songs up a notch, drag him the green arrow to turn it up!",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 2,
    },
    dragDownButton = {
        message = "or the down button if they want to take it down a notch.",
        display = true,
        type = "below",
        stage = 3,
        level = 1
    },
    dragCd = {
        message = "It looks like it's ready, deliver it to the client!",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 2
    },
    selectDiskBurner = {
        message = "Now tap on the CD machine to create a CD...",
        display = true,
        type = "right",
        stage = 3,
        level = 1,
        tutType = 3
    },
    dragGuittar = {
        message = "Looks like you've learned a new instrument! Drag the guitar to the client when they ask for it.",
        display = true,
        type = "below",
        stage = 3,
        level = 4
    },
    dragDrum = {
        message = "You've learned another instrument! Drag the client some drums if they need it.",
        display = true,
        type = "below",
        stage = 3,
        level = 6
    },
    dragWater = {
        message = "Looks like your clients might be building up a thirst, drag them some water when they ask for it!",
        display = true,
        type = "below",
        stage = 3,
        level = 8
    },
    orderPizza = {
        message = "This customer is hungry! You can't make music on an empty stomach. Click on the cell phone to order some pizza. ",
        display = true,
        type = "below",
        stage = 3,
        level = 11,
        tutType = 3
    },
    dragOrderedPizza = {
        message = "Now just drag it over to the booth! ",
        display = true,
        type = "below",
        stage = 3,
        level = 11,
        tutType = 2
    },
    dragLemonadeDrink5 = {
        message = "Drag the lemonade over to the customer!",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType = 2
    },
    -- dragIcedTea5 = {
    --     message = "Drag Iced tea to the customer, if customer wants.",
    --     display = true,
    --     type = "below",
    --     stage = 5,
    --     level = 3
    -- },
    dragPlatesPreperingDishes5 = {
        message = "If the customer wants the dish to go, put it in a tray...",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType=1
    },
    dragPlatesPreperingDishes52 = {
        message = "This customer wants it on a plate, so let’s give him one.",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType=3
    },
    dragPlatesPreperingDishes511 = {
        message = "This customer wants it on a plate, so let’s give him one.",
        display = true,
        type = "below",
        stage = 5,
        level = 11,
        tutType=3
    },
    
    dragtravesPreperingDishes5 = {
        message = "Or on the plate if the customer wants it to stay!",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType=1
    },
    selectChicken5 = {
        message = "Then try creating some fried chicken by tapping on the raw chicken.",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType=34
    },
    selectPork5 = {
        message = "Congratulations! You can now cook pork. To cook some up, just tap on it!",
        display = true,
        type = "below",
        stage = 5,
        level = 4,
        tutType=34
    },
    selectWafflesIron5 = {
        message = "If a customer wants waffles, just tap on the waffle iron to make some!",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType = 1
    },
    dragChickenPlate5 = {
        message = "Now just make sure to drag that delicious fried chicken onto the plate.",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType = 2
    },
    -- Don't forget to collect money.
    collectMoney51= {
        message = "Don't forget the cash!",
        display = true,
        type = "right",
        stage = 5,
        level = 1,
        tutType = 3
    },
    dragChickenPlateCustomer5 = {
        message = "And drag that chicken over to the customer!",
        display = true,
        type = "below",
        stage = 5,
        level = 1,
        tutType = 2
    },

    dragPorkCustomer5 = {
        message = "Uh oh! The pork is ready, but it looks like there's nobody around to eat it.",
        display = true,
        type = "below",
        stage = 5,
        level = 4,
        tutType = 1
    },
    dragPorkCustomer52 = {
        message = "Let's use our old friend the food warmer. Drag the pork over to the food warmer.",
        display = true,
        type = "below",
        stage = 5,
        level = 4,
        tutType = 2
    },
    -- dragWafflesCustomer5 = {
    --     message = "Waffles redy for the serving pelase drag it to the plates or traves.",
    --     display = true,
    --     type = "below",
    --     stage = 5,
    --     level = 1
    -- },
    dragmacAndCheese5 = {
        message = "If they do, just drag some mac & cheese onto thier plate!",
        display = true,
        type = "right",
        stage = 5,
        level = 7
    },
    dragGreen5 = {
        message = "Customers might begin asking for some collared greens now! If they do, just drag 'em over!",
        display = true,
        type = "right",
        stage = 5,
        level = 9
    },
    selectBrisket5 = {
        message = "Looks like you’ve unlocked the final food! This customer wants brisket. Tap on the brisket to roast it.",
        display = true,
        type = "below",
        stage = 5,
        level = 11,
        tutType=34
    },

    dragBrisket5 = {
        message = "Then, just drag it onto the plate!",
        display = true,
        type = "below",
        stage = 5,
        level = 11,
        tutType=2
    },
}
