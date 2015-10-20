local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local popsound = audio.loadSound( "pop.wav")

function scene:createScene( event )
        local group = self.view
        bckgrd = display.newImageRect("bgstart.png", display.contentWidth, display.contentHeight)
        bckgrd.x = display.contentWidth / 2
        bckgrd.y = display.contentHeight / 2
        group:insert( bckgrd)

        bln = display.newImage("balloon.png", display.contentWidth/2,display.contentHeight/2.5)
        bln:scale( .5, .5 )
        group:insert( bln )


        btnStart = display.newImage("invisibuttn.png",display.contentWidth/2,display.contentHeight/1.35)
        btnStart:scale( .45, .45 )
        group:insert(btnStart)

        counter = 0
        moveup = 1
end

function blnMove(self,event)
        if counter <= 8 then
                if(moveup == 1) then
                        self.y = self.y+3
                        counter = counter+1
                else
                        self.y = self.y-3
                        counter = counter+1
                end
        else
                counter = 0
                moveup = -moveup
        end
end

function myTapListener( event )

    --code executed when the button is tapped
    audio.play(popsound)
     storyboard.purgeScene( "game")
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
        bln.enterFrame = blnMove
        Runtime:addEventListener( "enterFrame", bln)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        Runtime:removeEventListener( "tap", myTapListener )
        Runtime:removeEventListener( "enterFrame", bln )
        storyboard.purgeAll()
end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
        storyboard.purgeScene( "start" )

end


-- Called prior to the removal of scene's "view" (display group)
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

scene:addEventListener( "createScene", scene )

scene:addEventListener( "willEnterScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "didExitScene", scene )

scene:addEventListener( "destroyScene", scene )

scene:addEventListener( "overlayBegan", scene )

scene:addEventListener( "overlayEnded", scene )


return scene