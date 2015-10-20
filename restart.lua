local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local loadFile = ego.loadFile
local highscore = loadFile ("highscore.txt")
-- local forward references should go here --

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
		popsound = audio.loadSound( "pop.wav")

        bckgrd = display.newImageRect("bgfinished.jpg", display.contentWidth, display.contentHeight)
        bckgrd.x = display.contentWidth / 2
        bckgrd.y = display.contentHeight / 2
        group:insert( bckgrd)

        btnStart = display.newImage("invisibuttn.png",display.contentWidth/2,display.contentHeight/1.35)
        btnStart:scale( .45, .45 )
        group:insert(btnStart)

        currscore = display.newText( score, (display.contentWidth/2)+80, display.contentHeight/3.45, "SHOWG",22 )
        currscore:setFillColor(48/255,101/255,236/255)
        group:insert( currscore )

        hscore = display.newText( highscore, (display.contentWidth/2)+80, display.contentHeight/2.18, "SHOWG", 22 )
        hscore:setFillColor(48/255,101/255,236/255)
        group:insert(hscore)
end

function myTapListener( event )

    --code executed when the button is tapped
    audio.play(popsound)
    tmlvl = 2500
	tmlvl2 = 550

     storyboard.removeScene( "game")
     storyboard.gotoScene( "game", {time=450, effect="crossFade"}  )  --'event.target' is the tapped object
    return true
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  local group = self.view
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  local group = self.view
  btnStart:addEventListener( "tap", myTapListener )
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
  local group = self.view
  btnStart:removeEventListener( "tap", myTapListener ) 
end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  local group = self.view
 
end
 
-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  local group = self.view
 
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene