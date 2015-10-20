--GAME FILE
--All in game activites are handled here
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ego = require "ego"
local saveFile = ego.saveFile
local loadFile = ego.loadFile
local highscore = loadFile ("highscore.txt")


local function checkForFile ()
if highscore == "empty" then
highscore = 0
ego.saveFile("highscore.txt", highscore)
end
end
checkForFile()

local index = 1
score = 0

print(highscore)

local function hAds(event)
	ads.hide( )
end

-- Called when the scene's view does not exist:
function scene:createScene(event )
		local group = self.view
		popsound = audio.loadSound( "pop.wav")
		tmlvl = 2500
		tmlvl2 = 550
		screenBottom = display.viewableContentHeight + display.screenOriginY
        seed = math.randomseed(os.time())
        screenBottom = display.viewableContentHeight + display.screenOriginY
        seed = os.time( )

        bckgrd = display.newImageRect("bg.png", display.contentWidth, display.contentHeight)
        bckgrd.x = display.contentWidth / 2
        bckgrd.y = display.contentHeight / 2
        group:insert(bckgrd)

        pnts = display.newText( score, display.contentWidth/2, display.contentHeight/8, "SHOWG", 40 )
        pnts:setFillColor(100,100,0)
        --group:insert( pnts )
        lolar = {}
        timer.performWithDelay( 6000, hAds, 1 )
end

local function rdnseed(event)
	seed = seed + math.random(1,250)
	math.randomseed(seed+os.time())
	pnts:toFront()
end

local function incrLvl(event)
	if tmlvl == 1000 then
		timer.cancel( ll )
	else
		
	tmlvl = tmlvl-10
	tmlvl2 = tmlvl2-2.4
	tl._delay = tmlvl2
end
end



local function Destroy_Box (obj)
    --print("obj remove")
    display.remove()
    obj = nil
    audio.play(popsound)
    transition.cancel(self)

    storyboard.gotoScene( "restart" , {time=450, effect="crossFade"} )
end

local function Destroy_Bad_Box (obj)
    --print("obj remove")
    display.remove()
    obj = nil
end

local function onObjectTap(self, event)
	if event.phase=="began" then

    display.remove( self)
    score = score+1
    pnts.text = score
    audio.play(popsound)
    transition.cancel(self)
end

end

local function onBadTap(self,event)
	display.remove( self )
	audio.play(popsound)
	obj = nil
	storyboard.gotoScene( "restart" , {time=450, effect="crossFade"} )
end

local function SpawnBox ()
	math.randomseed( seed+math.random(1,250) )

	local widthBloon = {6,2.5,1.59,1.2}
	local rnd = math.random(1,4)
	local bd = math.random(1,10)

		if bd == 3  then
			lolar[index] = display.newImage( "badballoon.png",display.contentWidth/widthBloon[rnd],display.contentHeight-605 )
		    lolar[index]:scale(.5,.5)	
		    transition.to( lolar[index],{time = tmlvl, y = screenBottom + 75, onComplete = Destroy_Bad_Box} )
		    lolar[index].touch = onBadTap
		    lolar[index]:addEventListener( "touch", lolar[index])
		    index = index + 1
		else
		    lolar[index] = display.newImage( "balloon.png",display.contentWidth/widthBloon[rnd],display.contentHeight-605 )
		    lolar[index]:scale(.5,.5)
		    transition.to( lolar[index],{time = tmlvl, y = screenBottom + 75, onComplete = Destroy_Box} )
		    lolar[index].touch = onObjectTap
		    lolar[index]:addEventListener( "touch", lolar[index])
		    index = index + 1
		end
end
--------------------------------------

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
        ll = timer.performWithDelay(100, incrLvl,0)
        tl = timer.performWithDelay( tmlvl2, SpawnBox, 0 )

		Runtime:addEventListener( "enterFrame", rdnseed )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        Runtime:removeEventListener( "enterFrame", rdnseed )
        pnts:removeSelf( )
        transition.cancel(tween)
        timer.cancel( tl )
        timer.cancel( ll )
for i=1,index do
	display.remove( lolar[i] )
end
		index = 1
		tmlvl = 2500
		tmlvl2 = 550

		    if score > tonumber(highscore) then --We use tonumber as highscore is a string when loaded
				ego.saveFile("highscore.txt", score)
				highscore = loadFile ("highscore.txt")
			end
			ads.show( "banner", { x=display.screenOriginX, y=(display.contentHeight - display.screenOriginY)} )


end

scene:addEventListener( "createScene", scene )

scene:addEventListener( "willEnterScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )


return scene