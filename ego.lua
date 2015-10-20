--EGO FILE
--Provides IO for the DataSaving module
module (..., package.seeall)


function saveFile( fileName, fileData )
	--Path for file
	local path = system.pathForFile( fileName, system.DocumentsDirectory )
	local file = io.open( path, "w+" )

	if file then
	   file:write( fileData )
	   io.close( file )
	end
end


function loadFile( fileName )
--Path for file
local path = system.pathForFile( fileName, system.DocumentsDirectory )

local file = io.open( path, "r" )
	

	if file then
	   local fileData = file:read( "*a" )
	   io.close( file )
	   return fileData

	else
	   file = io.open( path, "w" )
	   file:write( "empty" )
	   io.close( file )
	   return "empty"
	end
end